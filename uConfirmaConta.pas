unit uConfirmaConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadBase, Vcl.ComCtrls, RzButton,
  Vcl.ExtCtrls, RzPanel, Vcl.StdCtrls, Vcl.Mask, RzEdit, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Jsons;

type
  TfrmConfirmaConta = class(TfrmCadBase)
    edtNumero: TRzEdit;
    lblUsuario: TLabel;
    edtSenha: TRzEdit;
    lblSenha: TLabel;
    IdHTTP: TIdHTTP;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private { Private declarations }

  public { Public declarations }
    sNumero   : String;
    iCodConta : Integer;
  end;

var
  frmConfirmaConta: TfrmConfirmaConta;

implementation

{$R *.dfm}

procedure TfrmConfirmaConta.btnConfirmarClick(Sender: TObject);
begin
  if edtSenha.Text = '' then
    raise Exception.Create('É necessário preencher uma senha para Logar');

  var sRequest := '{"codigo": "'+ iCodConta.ToString + '", "senha": "' + edtSenha.Text + '"}';
  var msResponse  := TMemoryStream.Create;
  try
    try
      var stJson := TStringStream.Create(UTF8Encode(sRequest));
      try
        msResponse.Clear;
        IdHTTP.Post('http://localhost:3051/conta/login', stJson, msResponse);
        msResponse.Position := 0;

        var slRequest := TStringList.Create;
        try
          slRequest.LoadFromStream(msResponse);

          var sJson := Trim(slRequest.Text);
          var Json := TJson.Create();

          Json.Parse(sJson);

          if Json['mensagem'].AsString = 'ok' then
            ModalResult := MrOk
          else
            raise Exception.Create('Usuário e/ou senha inválido!');
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

procedure TfrmConfirmaConta.FormShow(Sender: TObject);
begin
  inherited;
  edtNumero.Text := sNumero;
end;

end.
