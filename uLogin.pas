unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, RzEdit, RzButton, RzPanel, Jsons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, RzCmboBx, uCadConta;

type
  TfrmLogin = class(TfrmBase)
    lblUsuario: TLabel;
    edtSenha: TRzEdit;
    lblSenha: TLabel;
    imgLogo: TImage;
    btnLogin: TRzToolButton;
    tbContas: TFDMemTable;
    IdHTTP: TIdHTTP;
    tbContasNUMERO: TIntegerField;
    tbContasSENHA: TIntegerField;
    tbContasSALDO: TCurrencyField;
    tbContasCOD_USUARIO: TIntegerField;
    tbContasCODIGO: TIntegerField;
    cmbConta: TRzComboBox;
    tbContasSTATUS: TBooleanField;
    btnNovo: TRzToolButton;
    Bevel3: TBevel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnNovoClick(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }

  public { Public declarations }
    iCodUsuario: Integer;
    iCodConta: Integer;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if cmbConta.ItemIndex = -1 then
    raise Exception.Create('É necessário selecionar uma conta!');

  tbContas.Locate('CODIGO', Integer(cmbConta.Items.Objects[cmbConta.ItemIndex]));

  if tbContas.FieldByName('SENHA').AsString = edtSenha.Text then
    ModalResult := MrOk
  else
    raise Exception.Create('Senha inválida!');

  iCodConta := tbContas.FieldByName('CODIGO').AsInteger;
end;

procedure TfrmLogin.btnNovoClick(Sender: TObject);
begin
  frmCadConta := TfrmCadConta.Create(Self);
  try
    frmCadConta.iCodUsuario := iCodUsuario;
    frmCadConta.tbContas.CopyDataSet(tbContas, [coAppend, coRestart, coStructure]);
    if frmCadConta.ShowModal = MrOk then
      FormShow(Sender);
  finally
    FreeAndNil(frmCadConta);
  end;
end;

procedure TfrmLogin.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then btnLogin.Click;

end;

procedure TfrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Char(Key), ['0'..'9', #13, #8]) then
    Key := #0;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
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
