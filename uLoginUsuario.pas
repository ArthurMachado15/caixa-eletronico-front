unit uLoginUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, Vcl.StdCtrls, Vcl.Mask, RzEdit,
  dxGDIPlusClasses, Vcl.ExtCtrls, RzButton, RzPanel, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, uLib, Jsons;

type
  TfrmLoginUsuario = class(TfrmBase)
    Bevel3: TBevel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    imgLogo: TImage;
    btnLogin: TRzToolButton;
    edtSenha: TRzEdit;
    edtUsuario: TRzEdit;
    IdHTTP: TIdHTTP;
    procedure btnLoginClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private { Private declarations }

  public { Public declarations }
    iCodUsuario: Integer;
  end;

var
  frmLoginUsuario: TfrmLoginUsuario;

implementation

{$R *.dfm}

procedure TfrmLoginUsuario.btnLoginClick(Sender: TObject);
begin
  if edtUsuario.Text = '' then
    raise Exception.Create('É necessário preencher o usuário para Logar!');

  if edtSenha.Text = '' then
    raise Exception.Create('É necessário preencher uma senha para Logar');

 var msResponse  := TMemoryStream.Create;
  try
    try
      var stJson := TStringStream.Create(UTF8Encode('{"login": "'+ edtUsuario.Text + '", "senha": "' + edtSenha.Text + '"}'));
      try
        msResponse.Clear;
        IdHTTP.Post('http://localhost:3051/usuario/login', stJson, msResponse);
        msResponse.Position := 0;

        var slRequest := TStringList.Create;
        try
          slRequest.LoadFromStream(msResponse);

          var sJson := Trim(slRequest.Text);
          var Json := TJson.Create();

          Json.Parse(sJson);

          iCodUsuario := Json['retorno'].AsInteger;
          if Json['mensagem'].AsString = 'ok' then
          begin
            iCodUsuario := Json['retorno'].AsInteger;
            ModalResult := MrOk;
          end
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

  ModalResult := MrOk
end;

procedure TfrmLoginUsuario.edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then btnLogin.Click;
end;

end.
