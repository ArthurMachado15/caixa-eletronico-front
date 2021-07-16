inherited frmCadTransferencia: TfrmCadTransferencia
  Caption = 'Transfer'#234'ncia bancaria'
  ClientHeight = 132
  ClientWidth = 431
  OnShow = FormShow
  ExplicitWidth = 437
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 431
    Height = 72
    ExplicitLeft = 0
    ExplicitTop = 45
    ExplicitWidth = 749
    ExplicitHeight = 80
  end
  object lblUsuario: TLabel [1]
    Left = 16
    Top = 53
    Width = 79
    Height = 16
    Caption = 'Conta Destino'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel [2]
    Left = 247
    Top = 53
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
    Width = 431
    inherited btnSair: TRzToolButton
      Left = 290
      ExplicitLeft = 290
    end
    inherited Bevel2: TBevel
      Left = 287
      ExplicitLeft = 287
    end
    inherited btnConfirmar: TRzToolButton
      Left = 146
      OnClick = btnConfirmarClick
      ExplicitLeft = 146
    end
    inherited Bevel3: TBevel
      Left = 143
      ExplicitLeft = 143
    end
  end
  inherited StatusBar: TStatusBar
    Top = 113
    Width = 431
  end
  object cmbConta: TRzComboBox
    Left = 16
    Top = 67
    Width = 201
    Height = 22
    Style = csOwnerDrawFixed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    ReadOnlyColorOnFocus = True
    TabOnEnter = True
    TabOrder = 2
  end
  object edtValor: TRzNumericEdit
    Left = 247
    Top = 67
    Width = 162
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnlyColorOnFocus = True
    TabOnEnter = True
    TabOrder = 3
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
  object tbContas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 8
    object tbContasNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object tbContasSENHA: TIntegerField
      FieldName = 'SENHA'
    end
    object tbContasSALDO: TCurrencyField
      FieldName = 'SALDO'
    end
    object tbContasCOD_USUARIO: TIntegerField
      FieldName = 'COD_USUARIO'
    end
    object tbContasCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbContasSTATUS: TBooleanField
      FieldName = 'STATUS'
    end
  end
end
