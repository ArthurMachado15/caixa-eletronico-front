unit uBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RzButton, RzPanel;

type
  TfrmBase = class(TForm)
    RzPanel1: TRzPanel;
    btnSair: TRzToolButton;
    Bevel2: TBevel;
    Bevel1: TBevel;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }

  public { Public declarations }

  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

procedure TfrmBase.btnSairClick(Sender: TObject);
begin
  ModalResult := MrCancel;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
