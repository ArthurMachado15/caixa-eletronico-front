inherited frmCadBase: TfrmCadBase
  Caption = 'Cadastro Base'
  ClientHeight = 633
  ClientWidth = 749
  Font.Height = -11
  ExplicitWidth = 755
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 749
    Height = 573
    ExplicitWidth = 613
    ExplicitHeight = 461
  end
  inherited RzPanel1: TRzPanel
    Width = 749
    BorderSides = [sdTop, sdBottom]
    ExplicitWidth = 613
    inherited btnSair: TRzToolButton
      Left = 608
      Top = 2
      Width = 141
      Height = 37
      ImageIndex = 6
      Images = DM.imgList24
      Caption = 'Cancelar [Esc]'
      ExplicitLeft = 472
      ExplicitTop = 2
      ExplicitWidth = 141
      ExplicitHeight = 37
    end
    inherited Bevel2: TBevel
      Left = 605
      Top = 2
      Width = 3
      Height = 37
      ExplicitLeft = 475
      ExplicitTop = 2
      ExplicitWidth = 3
      ExplicitHeight = 37
    end
    object btnConfirmar: TRzToolButton
      Left = 464
      Top = 2
      Width = 141
      Height = 37
      GradientColorStyle = gcsSystem
      ImageIndex = 5
      Images = DM.imgList24
      ShowCaption = True
      UseToolbarButtonLayout = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      Caption = 'Confirmar [F10]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 472
      ExplicitTop = 0
      ExplicitHeight = 39
    end
    object Bevel3: TBevel
      Left = 461
      Top = 2
      Width = 3
      Height = 37
      Align = alRight
      Shape = bsLeftLine
      ExplicitLeft = 325
      ExplicitTop = -4
      ExplicitHeight = 39
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 614
    Width = 749
    Height = 19
    Panels = <>
    ExplicitTop = 502
    ExplicitWidth = 613
  end
end
