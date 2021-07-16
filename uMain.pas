unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, RzButton, Vcl.ExtCtrls, RzPanel,
  dxGDIPlusClasses, Vcl.StdCtrls, Vcl.ComCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Jsons, JsonsUtilsEx, uLib, uCadDeposito, uCadSaque, uCadTransferencia;

type
  TfrmMain = class(TfrmBase)
    btnDeslogar: TRzToolButton;
    bvl4: TBevel;
    Bevel3: TBevel;
    tmrAbertura: TTimer;
    StatusBar1: TStatusBar;
    Label6: TLabel;
    Label1: TLabel;
    imgLogo: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnDepositar: TRzToolButton;
    Bevel4: TBevel;
    btnDesativar: TRzToolButton;
    Bevel5: TBevel;
    IdHTTP: TIdHTTP;
    btnSaque: TRzToolButton;
    Bevel6: TBevel;
    btnTransferir: TRzToolButton;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure tmrAberturaTimer(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnDeslogarClick(Sender: TObject);
    procedure btnDesativarClick(Sender: TObject);
    procedure btnDepositarClick(Sender: TObject);
    procedure btnSaqueClick(Sender: TObject);
    procedure btnTransferirClick(Sender: TObject);
  private { Private declarations }
    Aberto    : Boolean;
    iCodConta : Integer;
    procedure AlterarStatus;
  public { Public declarations }
    iCodUsuario : Integer;
    cSaldo      : Currency;
    bStatus     : Boolean;
    sConta      : String;
    cSaldoCaixa : Currency;

  end;

var
  frmMain: TfrmMain;

implementation

uses
  uLogin, uLoginUsuario;
{$R *.dfm}

procedure TfrmMain.AlterarStatus;
begin
 var msResponse := TMemoryStream.Create;
  try
    try
      var stJson := TStringStream.Create(UTF8Encode('{"codigo": ' + iCodConta.ToString +' }'));
      try
        if bStatus then
        begin
          msResponse.Clear;
          IdHTTP.Post('http://localhost:3051/conta/desativar', stJson, msResponse);
          msResponse.Position := 0;

          btnDesativar.Caption    := 'Reativar';
          btnDesativar.ImageIndex := 5;
          Label1.Caption          := 'Inativa';
          bStatus                 := False;
          Label1.Font.Color       := clMaroon;

          btnDepositar.Enabled := False;
          TLib.Aviso('Conta Desativada!');
        end
        else
        begin
          msResponse.Clear;
          IdHTTP.Post('http://localhost:3051/conta/reativar', stJson, msResponse);
          msResponse.Position := 0;

          btnDesativar.Caption    := 'Desativar';
          btnDesativar.ImageIndex := 6;
          Label1.Caption          := 'Ativa';
          bStatus                 := True;
          Label1.Font.Color       := clGreen;

          btnDepositar.Enabled := True;
          TLib.Aviso('Conta Reativada!');
        end;
      finally
        stJson.Free;
      end;
    except
      raise;
    end;
  finally
    msResponse.Free;
  end;

  btnDepositar.Enabled := not ((cSaldo > 0) and (bStatus = False));
  btnDesativar.Enabled := (cSaldo > 0);
  btnSaque.Enabled := bStatus;
  btnTransferir.Enabled := bStatus;
end;

procedure TfrmMain.btnDepositarClick(Sender: TObject);
begin
  frmCadDeposito := TfrmCadDeposito.Create(Self);
  try
    frmCadDeposito.iCodConta := iCodConta;
    frmCadDeposito.sConta    := sConta;
    if frmCadDeposito.ShowModal = MrOk then
    begin
      var bSaldo := cSaldo = 0;
      cSaldo := frmCadDeposito.cSaldo;
      cSaldoCaixa := frmCadDeposito.cSaldoCaixa;

      Label5.Caption := 'R$ ' + FormatFloat('0.00', cSaldo);
      Label8.Caption := 'R$ ' + FormatFloat('0.00', cSaldoCaixa);
      if bSaldo then
        AlterarStatus;
    end;
  finally
    FreeAndNil(frmCadDeposito);
  end;
end;

procedure TfrmMain.btnDesativarClick(Sender: TObject);
begin
  if not TLib.Perg('Deseja ' + UpperCase(btnDesativar.Caption) + ' esta conta?') then Exit;

  AlterarStatus;
end;

procedure TfrmMain.btnDeslogarClick(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(Self);
  try
    Label1.Visible := False;
    Label2.Visible := False;
    Label3.Visible := False;
    Label4.Visible := False;
    Label5.Visible := False;
    Label6.Visible := False;
    Label7.Visible := False;
    Label8.Visible := False;

    frmLogin.iCodUsuario := iCodUsuario;
    if frmLogin.ShowModal <> mrOk then
    begin
      Application.Terminate;
      Exit
    end
    else
    begin
      Label1.Visible := True;
      Label2.Visible := True;
      Label3.Visible := True;
      Label4.Visible := True;
      Label5.Visible := True;
      Label6.Visible := True;
      Label7.Visible := True;
      Label8.Visible := True;

      iCodConta            := frmLogin.tbContas.FieldByName('CODIGO').AsInteger;
      Label3.Caption       := frmLogin.tbContas.FieldByName('NUMERO').AsString;
      cSaldo               := frmLogin.tbContas.FieldByName('SALDO').AsCurrency;
      sConta               := frmLogin.tbContas.FieldByName('NUMERO').AsString;
      bStatus              := frmLogin.tbContas.FieldByName('STATUS').AsBoolean;
      Label5.Caption       := 'R$ ' + FormatFloat('0.00', frmLogin.tbContas.FieldByName('SALDO').AsCurrency);
      btnDesativar.Enabled := frmLogin.tbContas.FieldByName('SALDO').AsCurrency > 0;

      if bStatus then
      begin
        Label1.Caption := 'Ativa';
        Label1.Font.Color := clGreen;
      end
      else
      begin
        Label1.Caption := 'Inativa';
        Label1.Font.Color := clMaroon;
      end;
    end;

    try
      var msResponse  := TMemoryStream.Create;
      try
        var sRequest := '1';
        var stJson := TStringStream.Create(UTF8Encode(sRequest));
        try
          msResponse.Clear;
          IdHTTP.Post('http://localhost:3051/caixa/obter', stJson, msResponse);
          msResponse.Position := 0;

          var slRequest := TStringList.Create;
          try
            slRequest.LoadFromStream(msResponse);

            var sJson := Trim(slRequest.Text);
            var Json  := TJson.Create();

            Json.Parse(sJson);

            if Json['mensagem'].AsString = 'ok' then
            begin
              cSaldoCaixa := Json['retorno'].AsObject.Values['total'].AsNumber;
              ModalResult := MrOk;
            end
            else
              raise Exception.Create('Erro ao capturar total do caixa!');
          finally
            slRequest.Free;
          end;
        finally
          stJson.Free;
        end;
      finally
        msResponse.Free;
      end;
    except
      raise;
    end;

    Label8.Caption        := 'R$ ' + FormatFloat('0.00', cSaldoCaixa);

    btnDepositar.Enabled  := (frmLogin.tbContas.FieldByName('SALDO').AsCurrency = 0) or (frmLogin.tbContas.FieldByName('STATUS').AsBoolean);
    btnTransferir.Enabled := bStatus;
    btnSaque.Enabled      := bStatus;

    if not bStatus then
    begin
      btnDesativar.Caption    := 'Reativar';
      btnDesativar.ImageIndex := 5;
    end
    else
    begin
      btnDesativar.Caption    := 'Desativar';
      btnDesativar.ImageIndex := 6;
    end;
  finally
    FreeAndNil(frmLogin);
  end;
end;

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
  Application.Terminate;
end;

procedure TfrmMain.btnSaqueClick(Sender: TObject);
begin
  if cSaldo = 0 then
    raise Exception.Create('Não há saldo disponivel para realizar o saque!');

  if cSaldoCaixa = 0 then
    raise Exception.Create('Não há saldo disponivel no Caixa!');

  frmCadSaque := TfrmCadSaque.Create(Self);
  try
    frmCadSaque.iCodConta := iCodConta;
    frmCadSaque.sConta    := sConta;
    frmCadSaque.cSaldo    := cSaldo;
    frmCadSaque.cSaldoCaixa := cSaldoCaixa;
    if frmCadSaque.ShowModal = MrOk then
    begin
      cSaldo := frmCadSaque.cSaldo;
      cSaldoCaixa := frmCadSaque.cSaldoCaixa;
      if cSaldo = 0 then
      begin
        AlterarStatus;
      end;

      Label5.Caption := 'R$ ' + FormatFloat('0.00', cSaldo);
      Label8.Caption := 'R$ ' + FormatFloat('0.00', cSaldoCaixa);
    end;
  finally
    FreeAndNil(frmCadSaque);
  end;
end;

procedure TfrmMain.btnTransferirClick(Sender: TObject);
begin
  inherited;
  frmCadTransferencia := TfrmCadTransferencia.Create(Self);
  try
    frmCadTransferencia.iCodUsuario := iCodUsuario;
    frmCadTransferencia.cSaldo      := cSaldo;
    frmCadTransferencia.iCodConta   := iCodConta;
    frmCadTransferencia.sConta      := sConta;
    if frmCadTransferencia.ShowModal = MrOk then
      cSaldo := frmCadTransferencia.cSaldo;
  finally
    FreeAndNil(frmCadTransferencia);
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if Aberto then Exit;

  tmrAbertura.Enabled := True;
  Aberto              := True;
end;


procedure TfrmMain.tmrAberturaTimer(Sender: TObject);
begin
  tmrAbertura.Enabled := False;

  frmLoginUsuario := TfrmLoginUsuario.Create(Self);
  try
    if frmLoginUsuario.ShowModal <> MrOk then
      btnSair.Click;

    iCodUsuario := frmLoginUsuario.iCodUsuario;
  finally
    FreeAndNil(frmLoginUsuario);
  end;

  frmLogin := TfrmLogin.Create(Self);
  try
    frmLogin.iCodUsuario := iCodUsuario;
    if frmLogin.ShowModal <> MrOk then
      btnSair.Click
    else
    begin
      Label1.Visible := True;
      Label2.Visible := True;
      Label3.Visible := True;
      Label4.Visible := True;
      Label5.Visible := True;
      Label6.Visible := True;
      Label7.Visible := True;
      Label8.Visible := True;
      
      iCodConta            := frmLogin.tbContas.FieldByName('CODIGO').AsInteger;
      sConta               := frmLogin.tbContas.FieldByName('NUMERO').AsString;
      cSaldo               := frmLogin.tbContas.FieldByName('SALDO').AsCurrency;
      bStatus              := frmLogin.tbContas.FieldByName('STATUS').AsBoolean;
      Label3.Caption       := sConta;
      Label5.Caption       := Label5.Caption + ' ' + FormatFloat('0.00', cSaldo);
      btnDesativar.Enabled := frmLogin.tbContas.FieldByName('SALDO').AsCurrency > 0;

      try
        var msResponse  := TMemoryStream.Create;
        try
          var sRequest := '1';
          var stJson := TStringStream.Create(UTF8Encode(sRequest));
          try
            msResponse.Clear;
            IdHTTP.Post('http://localhost:3051/caixa/obter', stJson, msResponse);
            msResponse.Position := 0;

            var slRequest := TStringList.Create;
            try
              slRequest.LoadFromStream(msResponse);

              var sJson := Trim(slRequest.Text);
              var Json  := TJson.Create();

              Json.Parse(sJson);

              if Json['mensagem'].AsString = 'ok' then
              begin
                cSaldoCaixa := Json['retorno'].AsObject.Values['total'].AsNumber;
                ModalResult := MrOk;
              end
              else
                raise Exception.Create('Erro ao capturar total do caixa!');
            finally
              slRequest.Free;
            end;
          finally
            stJson.Free;
          end;
        finally
          msResponse.Free;
        end;
      except
        raise;
      end;

      Label8.Caption := 'R$ ' + FormatFloat('0.00', cSaldoCaixa);
      if bStatus then
      begin
        Label1.Caption := 'Ativa';
        Label1.Font.Color := clGreen;
      end
      else
      begin
        Label1.Caption := 'Inativa';
        Label1.Font.Color := clMaroon;
      end;
    end;

    btnDepositar.Enabled  := (frmLogin.tbContas.FieldByName('SALDO').AsCurrency = 0) or (frmLogin.tbContas.FieldByName('STATUS').AsBoolean);
    btnSaque.Enabled      := bStatus;
    btnTransferir.Enabled := bStatus;

    if not bStatus then
    begin
      btnDesativar.Caption    := 'Reativar';
      btnDesativar.ImageIndex := 5;
    end
    else
    begin
      btnDesativar.Caption    := 'Desativar';
      btnDesativar.ImageIndex := 6;
    end;

    iCodConta := frmLogin.iCodConta;

  finally
    FreeAndNil(frmLogin);
  end;
end;

end.
