unit uCadBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uBase, RzButton, RzPanel;

type
  TfrmCadBase = class(TfrmBase)
    StatusBar: TStatusBar;
    btnConfirmar: TRzToolButton;
    Bevel3: TBevel;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  frmCadBase: TfrmCadBase;

implementation

{$R *.dfm}

procedure TfrmCadBase.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    btnSair.Click
  else if Key = VK_F10 then
    btnConfirmar.Click;
end;

procedure TfrmCadBase.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

end.
