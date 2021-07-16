object frmConBase: TfrmConBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro'
  ClientHeight = 546
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 16
  object pnlPesquisa: TPanel
    Left = 0
    Top = 41
    Width = 889
    Height = 80
    Align = alTop
    TabOrder = 0
    DesignSize = (
      889
      80)
    object btnPesquisar: TRzToolButton
      Left = 789
      Top = 18
      Width = 70
      Height = 36
      GradientColorStyle = gcsSystem
      ImageIndex = 4
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 656
    end
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 170
      Height = 16
      Caption = 'Consulta por C'#243'digo ou Nome'
    end
    object edtPesquisa: TEdit
      Left = 15
      Top = 31
      Width = 733
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = edtPesquisaKeyPress
      ExplicitWidth = 610
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 889
    Height = 41
    Align = alTop
    BorderOuter = fsGroove
    BorderSides = [sdTop, sdBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    VisualStyle = vsGradient
    ExplicitWidth = 766
    object btnExcluir: TRzToolButton
      Left = 216
      Top = 2
      Width = 106
      Height = 37
      GradientColorStyle = gcsSystem
      ImageIndex = 3
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = 'Excluir [F4]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 246
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object btnSair: TRzToolButton
      Left = 842
      Top = 2
      Width = 47
      Height = 37
      GradientColorStyle = gcsSystem
      ImageIndex = 0
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSairClick
      ExplicitLeft = 712
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object btnNovo: TRzToolButton
      Left = 0
      Top = 2
      Width = 106
      Height = 37
      GradientColorStyle = gcsSystem
      ImageIndex = 1
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = 'Incluir [F2]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 8
      ExplicitHeight = 39
    end
    object Bevel3: TBevel
      Left = 214
      Top = 2
      Width = 2
      Height = 37
      Align = alLeft
      Shape = bsLeftLine
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object Bevel1: TBevel
      Left = 106
      Top = 2
      Width = 2
      Height = 37
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 214
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object btnAlterar: TRzToolButton
      Left = 108
      Top = 2
      Width = 106
      Height = 37
      GradientColorStyle = gcsSystem
      ImageIndex = 2
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = 'Alterar [F3]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 246
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object Bevel2: TBevel
      Left = 841
      Top = 2
      Width = 1
      Height = 37
      Align = alRight
      Shape = bsLeftLine
      ExplicitLeft = 633
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object bvl2: TBevel
      Left = 322
      Top = 2
      Width = 2
      Height = 37
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 330
      ExplicitTop = -4
      ExplicitHeight = 39
    end
  end
  object grdConsulta: TDBGrid
    Left = 0
    Top = 121
    Width = 889
    Height = 425
    Align = alClient
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grdConsultaDblClick
    OnKeyDown = grdConsultaKeyDown
  end
  object dsDados: TDataSource
    DataSet = tbDados
    Left = 376
    Top = 184
  end
  object tbDados: TFDMemTable
    AfterScroll = tbDadosAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 432
    Top = 184
  end
end
