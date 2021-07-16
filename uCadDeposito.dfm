inherited frmCadDeposito: TfrmCadDeposito
  Caption = 'Cadastro de Dep'#243'sito'
  ClientHeight = 134
  ClientWidth = 263
  ExplicitWidth = 269
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 263
    Height = 74
    ExplicitLeft = 0
    ExplicitTop = 45
    ExplicitWidth = 318
    ExplicitHeight = 74
  end
  object Label8: TLabel [1]
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
    Width = 263
    ExplicitWidth = 263
    inherited btnSair: TRzToolButton
      Left = 183
      Width = 80
      UseToolbarButtonSize = False
      Caption = ''
      ExplicitLeft = 248
      ExplicitWidth = 80
    end
    inherited Bevel2: TBevel
      Left = 180
      ExplicitLeft = 180
    end
    inherited btnConfirmar: TRzToolButton
      Left = 100
      Width = 80
      UseToolbarButtonSize = False
      Caption = ''
      OnClick = btnConfirmarClick
      ExplicitLeft = 167
      ExplicitTop = 2
      ExplicitWidth = 80
      ExplicitHeight = 37
    end
    inherited Bevel3: TBevel
      Left = 97
      ExplicitLeft = 97
    end
  end
  inherited StatusBar: TStatusBar
    Top = 115
    Width = 263
    ExplicitTop = 115
    ExplicitWidth = 263
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
