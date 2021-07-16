unit uCadDeposito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadBase, Vcl.StdCtrls, Vcl.Mask,
  RzEdit, Vcl.ComCtrls, RzButton, Vcl.ExtCtrls, RzPanel, uConfirmaConta,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Jsons;

type
  TfrmCadDeposito = class(TfrmCadBase)
    edtValor: TRzNumericEdit;
    Label8: TLabel;
    IdHTTP: TIdHTTP;
    procedure btnConfirmarClick(Sender: TObject);
  private { Private declarations }

  public { Public declarations }
    iCodConta: Integer;
    sConta: String;
    cSaldo: Currency;
    cSaldoCaixa: Currency;
  end;

var
  frmCadDeposito: TfrmCadDeposito;

implementation

{$R *.dfm}

procedure TfrmCadDeposito.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if edtValor.Value = 0 then
    raise Exception.Create('O valor do depósito necessita ser maior que 0 (zero)!');

  frmConfirmaConta := TfrmConfirmaConta.Create(Self);
  try
    frmConfirmaConta.iCodConta := iCodConta;
    frmConfirmaConta.sNumero   := sConta;
    if frmConfirmaConta.ShowModal = MrOk then
    begin
      var sRequest := '{"valor": "'+ edtValor.Value.ToString + '", "codigo": ' + iCodConta.ToString + '}';
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
                cSaldo := Json['retorno'].AsNumber;
              end
              else
                raise Exception.Create('Erro ao depositar!');
            finally
              slRequest.Free;
            end;
          finally
            stJson.Free;
          end;

          sRequest := '{"valor": "'+ edtValor.Value.ToString + '", "codigo": 1}';
          stJson := TStringStream.Create(UTF8Encode(sRequest));
          try
            msResponse.Clear;
            IdHTTP.Post('http://localhost:3051/caixa/total', stJson, msResponse);
            msResponse.Position := 0;

            var slRequest := TStringList.Create;
            try
              slRequest.LoadFromStream(msResponse);

              var sJson := Trim(slRequest.Text);
              var Json  := TJson.Create();

              Json.Parse(sJson);

              if Json['mensagem'].AsString = 'ok' then
              begin
                cSaldoCaixa := Json['retorno'].AsNumber;
                ModalResult := MrOk;
              end
              else
                raise Exception.Create('Erro ao depositar!');
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
  finally
    FreeAndNil(frmConfirmaConta);
  end;
end;

end.
