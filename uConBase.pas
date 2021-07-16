unit uConBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, PngImageList, RzButton, RzPanel, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf;

type
  TfrmConBase = class(TForm)
    pnlPesquisa: TPanel;
    edtPesquisa: TEdit;
    dsDados: TDataSource;
    tbDados: TFDMemTable;
    RzPanel1: TRzPanel;
    btnExcluir: TRzToolButton;
    btnSair: TRzToolButton;
    btnNovo: TRzToolButton;
    Bevel3: TBevel;
    Bevel1: TBevel;
    btnAlterar: TRzToolButton;
    Bevel2: TBevel;
    btnPesquisar: TRzToolButton;
    grdConsulta: TDBGrid;
    Label1: TLabel;
    bvl2: TBevel;
    procedure tbDadosAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  frmConBase : TfrmConBase;

implementation

{$R *.dfm}

uses uDM;


procedure TfrmConBase.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmConBase.edtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnPesquisar.Click;
end;

procedure TfrmConBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel
  else if Key =vk_F2 then
    btnNovo.Click
  else if Key =vk_F3 then
    btnAlterar.Click
  else if Key =vk_F4 then
    btnExcluir.Click;

end;

procedure TfrmConBase.grdConsultaDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmConBase.grdConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    btnAlterar.Click;
end;

procedure TfrmConBase.tbDadosAfterScroll(DataSet: TDataSet);
begin
  btnAlterar.Enabled := True;
  btnExcluir.Enabled := True;
end;

procedure TfrmConBase.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

end.
