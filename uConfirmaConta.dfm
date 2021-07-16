inherited frmConfirmaConta: TfrmConfirmaConta
  Caption = 'Confirma'#231#227'o da conta'
  ClientHeight = 186
  ClientWidth = 393
  OnShow = FormShow
  ExplicitWidth = 399
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 393
    Height = 126
    ExplicitLeft = 0
    ExplicitTop = 40
    ExplicitWidth = 393
    ExplicitHeight = 138
  end
  object lblUsuario: TLabel [1]
    Left = 26
    Top = 54
    Width = 33
    Height = 16
    Caption = 'Conta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblSenha: TLabel [2]
    Left = 26
    Top = 104
    Width = 36
    Height = 16
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited RzPanel1: TRzPanel
    Width = 393
    ExplicitWidth = 393
    inherited btnSair: TRzToolButton
      Left = 252
      ExplicitLeft = 252
    end
    inherited Bevel2: TBevel
      Left = 249
      ExplicitLeft = 249
    end
    inherited btnConfirmar: TRzToolButton
      Left = 108
      OnClick = btnConfirmarClick
      ExplicitLeft = 108
    end
    inherited Bevel3: TBevel
      Left = 105
      ExplicitLeft = 105
    end
  end
  inherited StatusBar: TStatusBar
    Top = 167
    Width = 393
    ExplicitTop = 167
    ExplicitWidth = 393
  end
  object edtNumero: TRzEdit
    Left = 26
    Top = 70
    Width = 332
    Height = 24
    TabStop = False
    Text = ''
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOnEnter = True
    TabOrder = 2
  end
  object edtSenha: TRzEdit
    Left = 26
    Top = 119
    Width = 332
    Height = 24
    Text = ''
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOnEnter = True
    TabOrder = 3
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
