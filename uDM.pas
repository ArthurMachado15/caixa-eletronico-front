unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.ImageList, Vcl.ImgList,
  Vcl.Controls, PngImageList;

type
  TDM = class(TDataModule)
    imgList24: TPngImageList;
    imgList16: TPngImageList;
    Wait: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
