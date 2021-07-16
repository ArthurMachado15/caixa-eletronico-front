inherited frmCadConta: TfrmCadConta
  Caption = 'Cadastro de Conta'
  ClientHeight = 245
  ClientWidth = 379
  OnShow = FormShow
  ExplicitWidth = 385
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 379
    Height = 185
    ExplicitWidth = 379
    ExplicitHeight = 185
  end
  object lblSenha: TLabel [1]
    Left = 20
    Top = 111
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
  object lblUsuario: TLabel [2]
    Left = 20
    Top = 61
    Width = 45
    Height = 16
    Caption = 'Numero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [3]
    Left = 20
    Top = 164
    Width = 110
    Height = 16
    Caption = 'Confirma'#231#227'o senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited RzPanel1: TRzPanel
    Width = 379
    TabOrder = 3
    ExplicitWidth = 379
    inherited btnSair: TRzToolButton
      Left = 238
      ExplicitLeft = 238
    end
    inherited Bevel2: TBevel
      Left = 235
      ExplicitLeft = 235
    end
    inherited btnConfirmar: TRzToolButton
      Left = 94
      OnClick = btnConfirmarClick
      ExplicitLeft = 94
    end
    inherited Bevel3: TBevel
      Left = 91
      ExplicitLeft = 91
    end
  end
  inherited StatusBar: TStatusBar
    Top = 226
    Width = 379
    ExplicitTop = 226
    ExplicitWidth = 379
  end
  object edtSenha: TRzEdit
    Left = 20
    Top = 126
    Width = 332
    Height = 24
    Text = ''
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    PasswordChar = '*'
    TabOnEnter = True
    TabOrder = 1
    OnKeyPress = edtNumeroKeyPress
  end
  object edtNumero: TRzEdit
    Left = 20
    Top = 76
    Width = 332
    Height = 24
    Text = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOnEnter = True
    TabOrder = 0
    OnKeyPress = edtNumeroKeyPress
  end
  object edtConfSenha: TRzEdit
    Left = 20
    Top = 179
    Width = 332
    Height = 24
    Text = ''
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    PasswordChar = '*'
    TabOnEnter = True
    TabOrder = 2
    OnKeyPress = edtNumeroKeyPress
  end
  object tbContas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 24
    Top = 8
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
    Left = 80
    Top = 8
  end
end
