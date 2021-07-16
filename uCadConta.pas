unit uCadConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadBase, Vcl.ComCtrls, RzButton,
  Vcl.ExtCtrls, RzPanel, Vcl.StdCtrls, Vcl.Mask, RzEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Jsons, uLib;

type
  TfrmCadConta = class(TfrmCadBase)
    edtSenha: TRzEdit;
    lblSenha: TLabel;
    edtNumero: TRzEdit;
    lblUsuario: TLabel;
    edtConfSenha: TRzEdit;
    Label1: TLabel;
    tbContas: TFDMemTable;
    IdHTTP: TIdHTTP;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }

  public { Public declarations }
    iCodUsuario: Integer;
  end;

var
  frmCadConta: TfrmCadConta;

implementation

{$R *.dfm}

procedure TfrmCadConta.btnConfirmarClick(Sender: TObject);
begin
  if edtSenha.Text <> edtConfSenha.Text then
    raise Exception.Create('As senhas não coincidem!');

  if tbContas.Locate('NUMERO', edtNumero.Text) then
    raise Exception.Create('Numero de conta já cadastrado!');

  if not TLib.Perg('Deseja incluir a conta em questão?') then Exit;

  var msResponse  := TMemoryStream.Create;
  try
    var sJson :='{"numero": "' + edtNumero.Text + '", "senha": "' + edtSenha.Text + '", "saldo": 300, "codUsuario": ' + iCodUsuario.ToString + ' }';
    try
      var stJson := TStringStream.Create(UTF8Encode(sJson));
      try
        msResponse.Clear;
        IdHTTP.Post('http://localhost:3051/conta/incluir', stJson, msResponse);
        msResponse.Position := 0;

      finally
        stJson.Free;
      end;
    except
      raise;
    end;
  finally
    msResponse.Free;
  end;

  TLib.Aviso('Conta incluida com Sucesso!');
  ModalResult := MrOk;
end;

procedure TfrmCadConta.edtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Char(Key), ['0'..'9', #13, #8]) then
    Key := #0;
end;

procedure TfrmCadConta.FormShow(Sender: TObject);
begin
  inherited;
  tbContas.Open;
end;

end.
