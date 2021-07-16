unit uCadTransferencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadBase, Vcl.ComCtrls, RzButton,
  Vcl.ExtCtrls, RzPanel, Vcl.StdCtrls, RzCmboBx, Vcl.Mask, RzEdit,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Jsons, uConfirmaConta;

type
  TfrmCadTransferencia = class(TfrmCadBase)
    cmbConta: TRzComboBox;
    lblUsuario: TLabel;
    edtValor: TRzNumericEdit;
    Label8: TLabel;
    IdHTTP: TIdHTTP;
    tbContas: TFDMemTable;
    tbContasNUMERO: TIntegerField;
    tbContasSENHA: TIntegerField;
    tbContasSALDO: TCurrencyField;
    tbContasCOD_USUARIO: TIntegerField;
    tbContasCODIGO: TIntegerField;
    tbContasSTATUS: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private { Private declarations }

  public  { Public declarations }
    iCodUsuario: Integer;
    iCodConta: Integer;
    sConta: String;
    cSaldo: Currency;
  end;

var
  frmCadTransferencia: TfrmCadTransferencia;

implementation

{$R *.dfm}

procedure TfrmCadTransferencia.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if edtValor.Value = 0 then
    raise Exception.Create('O valor do depósito necessita ser maior que 0 (zero)!');

  if edtValor.Value > cSaldo then
    raise Exception.Create('Valor maior que o disponível para transferir!');

  frmConfirmaConta := TfrmConfirmaConta.Create(Self);
  try
    frmConfirmaConta.iCodConta := iCodConta;
    frmConfirmaConta.sNumero   := sConta;
    if frmConfirmaConta.ShowModal = MrOk then
    begin
      var sRequest := '{"valor": "'+ (edtValor.Value * -1).ToString + '", "codigo": ' + iCodConta.ToString + '}';
      var msResponse  := TMemoryStream.Create;
      try
        try
          var stJson := TStringStream.Create(UTF8Encode(sRequest));
          try
            msResponse.Clear;
            IdHTTP.Post('http://localhost:3051/conta/movimentar', stJson, msResponse);
            msResponse.Position := 0;

            var slRequest := TStringList.Create;
            try
              slRequest.LoadFromStream(msResponse);

              var sJson := Trim(slRequest.Text);
              var Json := TJson.Create();

              Json.Parse(sJson);

              if Json['mensagem'].AsString = 'ok' then
              begin
                ModalResult := MrOk;
                cSaldo := Json['retorno'].AsNumber;
              end
              else
                raise Exception.Create('Erro ao transferir!');
            finally
              slRequest.Free;
            end;
          finally
            stJson.Free;
          end;
        except
          raise;
        end;
      finally
        msResponse.Free;
      end;

      sRequest := '{"valor": "'+ edtValor.Value.ToString + '", "codigo": ' + Integer(cmbConta.Items.Objects[cmbConta.ItemIndex]).ToString + '}';
      msResponse  := TMemoryStream.Create;
      try
        try
          var stJson := TStringStream.Create(UTF8Encode(sRequest));
          try
            msResponse.Clear;
            IdHTTP.Post('http://localhost:3051/conta/movimentar', stJson, msResponse);
            msResponse.Position := 0;

            var slRequest := TStringList.Create;
            try
              slRequest.LoadFromStream(msResponse);

              var sJson := Trim(slRequest.Text);
              var Json := TJson.Create();

              Json.Parse(sJson);

              if Json['mensagem'].AsString = 'ok' then
              begin
                ModalResult := MrOk;
                cSaldo := Json['retorno'].AsNumber;
              end
              else
                raise Exception.Create('Erro ao transferir!');
            finally
              slRequest.Free;
            end;
          finally
            stJson.Free;
          end;
        except
          raise;
        end;
      finally
        msResponse.Free;
      end;
    end;

    tbContas.Open;

  finally
    FreeAndNil(frmConfirmaConta);
  end;
end;

procedure TfrmCadTransferencia.FormShow(Sender: TObject);
begin
  inherited;
  edtValor.Max := cSaldo;

  tbContas.Open;
  var msResponse := TMemoryStream.Create;
  try
    try
      var stJson := TStringStream.Create(UTF8Encode(iCodUsuario.ToString));
      try
        msResponse.Clear;
        IdHTTP.Post('http://localhost:3051/conta/contasUsuario', stJson, msResponse);
        msResponse.Position := 0;

        var slRequest := TStringList.Create;
        try
          slRequest.LoadFromStream(msResponse);

          var sJson     := slRequest.Text;
          var JsonArray := TJsonArray.Create();

          JsonArray.Parse(sJson);
          var Json := TJson.Create();

          for var i := 0 to JsonArray.Count - 1 do
          begin
            Json.Assign(JsonArray[i]);

            tbContas.Append;
            tbContas.FieldByName('NUMERO').AsInteger      := Json['numero'].AsInteger;
            tbContas.FieldByName('SENHA').AsInteger       := Json['senha'].AsInteger;
            tbContas.FieldByName('SALDO').AsCurrency      := Json['saldo'].AsNumber;
            tbContas.FieldByName('COD_USUARIO').AsInteger := Json['codUsuario'].AsInteger;
            tbContas.FieldByName('CODIGO').AsInteger      := Json['codigo'].AsInteger;
            tbContas.FieldByName('STATUS').AsBoolean      := Json['status'].AsBoolean;
            tbContas.Post;
          end;
        finally
          slRequest.Free;
        end;
      finally
        stJson.Free;
      end;
    except
      raise;
    end;
  finally
    msResponse.Free;
  end;

  tbContas.First;
  while not tbContas.Eof do
  begin
    cmbConta.Items.AddObject(tbContas.FieldByName('NUMERO').AsString, TObject(tbContas.FieldByName('CODIGO').AsInteger));

    tbContas.Next;
  end;

end;

end.
