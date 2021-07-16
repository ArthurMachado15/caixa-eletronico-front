program CaixaEletronico;

uses
  Vcl.Forms,
  uBase in '..\SOURCE\uBase.pas' {frmBase},
  uCadBase in '..\SOURCE\uCadBase.pas' {frmCadBase},
  uConBase in '..\SOURCE\uConBase.pas' {frmConBase},
  uMain in '..\SOURCE\uMain.pas' {frmMain},
  uDM in '..\SOURCE\uDM.pas' {DM: TDataModule},
  uLogin in '..\SOURCE\uLogin.pas' {frmLogin},
  Jsons in '..\SOURCE\Jsons.pas',
  JsonsUtilsEx in '..\SOURCE\JsonsUtilsEx.pas',
  uLib in '..\SOURCE\uLib.pas',
  uLoginUsuario in '..\SOURCE\uLoginUsuario.pas' {frmLoginUsuario},
  uCadConta in '..\SOURCE\uCadConta.pas' {frmCadConta},
  uCadDeposito in '..\SOURCE\uCadDeposito.pas' {frmCadDeposito},
  uConfirmaConta in '..\SOURCE\uConfirmaConta.pas' {frmConfirmaConta},
  uCadSaque in '..\SOURCE\uCadSaque.pas' {frmCadSaque},
  uCadTransferencia in '..\SOURCE\uCadTransferencia.pas' {frmCadTransferencia};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLoginUsuario, frmLoginUsuario);
  Application.CreateForm(TfrmCadConta, frmCadConta);
  Application.CreateForm(TfrmCadDeposito, frmCadDeposito);
  Application.CreateForm(TfrmConfirmaConta, frmConfirmaConta);
  Application.CreateForm(TfrmCadSaque, frmCadSaque);
  Application.CreateForm(TfrmCadTransferencia, frmCadTransferencia);
  Application.Run;
end.
