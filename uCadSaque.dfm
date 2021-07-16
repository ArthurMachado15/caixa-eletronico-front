inherited frmCadSaque: TfrmCadSaque
  Caption = 'Saque'
  ClientHeight = 131
  ClientWidth = 266
  OnShow = FormShow
  ExplicitWidth = 272
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 266
    Height = 71
    ExplicitWidth = 266
    ExplicitHeight = 71
  end
  object Bevel4: TBevel [1]
    Left = 0
    Top = 41
    Width = 266
    Height = 71
    Align = alClient
    Shape = bsFrame
    ExplicitLeft = 8
    ExplicitTop = 49
    ExplicitWidth = 263
    ExplicitHeight = 74
  end
  object Label8: TLabel [2]
    Left = 23
    Top = 55
    Width = 30
    Height = 16
    Caption = 'Valor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited RzPanel1: TRzPanel
    Width = 266
    inherited btnSair: TRzToolButton
      Left = 186
      Width = 80
      UseToolbarButtonSize = False
      Caption = ''
      ExplicitLeft = 192
      ExplicitWidth = 80
    end
    inherited Bevel2: TBevel
      Left = 183
      ExplicitLeft = 183
    end
    inherited btnConfirmar: TRzToolButton
      Left = 103
      Width = 80
      UseToolbarButtonSize = False
      Caption = ''
      OnClick = btnConfirmarClick
      ExplicitLeft = 48
      ExplicitTop = 2
      ExplicitWidth = 80
      ExplicitHeight = 37
    end
    inherited Bevel3: TBevel
      Left = 100
      ExplicitLeft = 100
    end
  end
  inherited StatusBar: TStatusBar
    Top = 112
    Width = 266
  end
  object edtValor: TRzNumericEdit
    Left = 23
    Top = 69
    Width = 210
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnlyColorOnFocus = True
    TabOnEnter = True
    TabOrder = 2
    IntegersOnly = False
    DisplayFormat = 'R$ #,##0.00'
  end
  object IdHTTP: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'application/json'
    Request.Accept = 'application/json'
    Request.BasicAuthentication = True
    Request.Password = 'caixa123'
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Username = 'caixa'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 24
    Top = 8
  end
end
