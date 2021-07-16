unit uLib;

interface

uses
  System.SysUtils, Vcl.Dialogs, System.UITypes, System.JSON,
  System.Hash, System.Classes, IdHTTP, System.Generics.Collections,
  Winapi.Windows, Vcl.Forms, DBXJSON, DBXJSONReflect;

type
  rRelatorio = record
    Prefixo:    String;
    Nome:       String;
    Descricao:  String;
  end;

  eRelatorios = (REEE, RMDE, RDRM, RDRF, RDRP);

  TRelatorios = array[Low(eRelatorios)..High(eRelatorios)] of rRelatorio;
  TLib = class

  private
    class function  DoWhat(Action, Src: String): String;
  public
    class function  Perg(sMsg: String): Boolean;
    class procedure Aviso(sMsg: String);
    class procedure Erro(sMsg: String);
    class function  ClearString(StrToClear: String): String;
    class function  ValidarCPF(Texto: String): Boolean;
    class function  Numeros(Texto: String): String;
    class function  GetFileVersion(sNmArq: String): String;
    class function  Capitalize(Texto: String): String;
    class function  ComputerName: String;
    class function  IIF(Condicao: Boolean; RetTrue, RetFalse: Variant): Variant;
    class function  Crypt(vSrc: String): String;
    class function  DeCrypt(vSrc: String): String;
    class function  ZeroEsq(Texto: String; Qtde: Integer): String;
    class function  Hash(Texto: String): String;
  end;

implementation

{ TLib }

class procedure TLib.Aviso(sMsg: String);
begin
  MessageDlg(sMsg, mtInformation, [mbOK], 0);
end;

class function TLib.Capitalize(Texto: String): String;
const
  Chars = [' ', '-'];
var
  i: Integer;
  bUp: Boolean;
begin
  Result := LowerCase(Texto);
  bUp    := True;

  for i := 1 to Length(Result) do
  begin
    if bUp then
    begin
      Result[i] := UpCase(Result[i]);
      bUp       := False;
    end
    else
    begin
      if CharInSet(Result[i], Chars) then
        bUp := True;
    end;
  end;
end;

class function TLib.ClearString(StrToClear: String): String;
var
  i: integer;
  CleanedString: string;
begin
  CleanedString := '';
  for i := 1 to Length(StrToClear) do
  begin
    if (StrToClear[i] <> '-') and (StrToClear[i] <> '.') and (StrToClear[i] <> ',') and (StrToClear[i] <> '/') then
      CleanedString := CleanedString + StrToClear[i];
  end;
  Result := CleanedString;
end;

class function TLib.ComputerName: String;
begin
  Result := GetEnvironmentVariable('COMPUTERNAME');

  if Trim(Result) = '' then
    raise Exception.Create('Falha ao recuperar Nome do Computador!');
end;

class function TLib.Crypt(vSrc: String): String;
begin
  if vSrc <> '' then
    Result := DoWhat('C', vSrc)
  else
    Result := '';
end;

class function TLib.DeCrypt(vSrc: String): String;
begin
  if vSrc <> '' then
    Result := DoWhat('D', vSrc)
  else
    Result := '';
end;

class function TLib.DoWhat(Action, Src: String): String;
var KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin

  Key := 'YUQL23KL23DAITV64S9JAJAS467NMCXXL6JAOAUWWM6VCWONMUM4A4BNRTD3KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  Range := 256;

  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x',[OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin

      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x',[SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$'+ copy(Src,1,2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
      if (KeyPos < KeyLen) Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;

  Result:= Dest;
end;

class procedure TLib.Erro(sMsg: String);
begin
  MessageDlg(sMsg, mtError, [mbOK], 0);
end;

class function TLib.GetFileVersion(sNmArq: String): String;
var
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: array[1..4] of word;
begin
  Result := '';

  iBufferSize := GetFileVersionInfoSize(PChar(sNmArq), iDummy);
  if (iBufferSize > 0) then
  begin
    GetMem(pBuffer, iBufferSize);
    try
      GetFileVersionInfo(PChar(sNmArq), 0, iBufferSize, pBuffer);
      VerQueryValue(pBuffer, '\', pFileInfo, iDummy);

      iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
      iVer[4] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      Freemem(pBuffer);
    end;

    Result := Format('%d.%d.%d.%d', [iVer[1], iVer[2], iVer[3], iVer[4]]);
  end;
end;

class function TLib.Hash(Texto: String): String;
var
  Hash: THashMD5;
begin
  Hash := THashMD5.Create;
  Hash.Update(Texto);
  Result := Hash.HashAsString;
end;

class function TLib.IIF(Condicao: Boolean; RetTrue, RetFalse: Variant): Variant;
begin
  if Condicao then
    Result := RetTrue
  else
    Result := RetFalse;
end;

class function TLib.Numeros(Texto: String): String;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Texto.Length do
  begin
    if CharInSet(Texto[i], ['0'..'9']) then
      Result := Result + Texto[i];
  end;
end;

class function TLib.Perg(sMsg: String): Boolean;
begin
  Result := MessageDlg(sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

class function TLib.ValidarCPF(Texto: String): Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9: Integer;
  d1,d2: Integer;
  digitado, calculado: String;
begin
  Result  := False;
  Texto   := Numeros(Texto);

  if Length(Texto) <> 11 then Exit;

  n1:=StrToInt(Texto[1]);
  n2:=StrToInt(Texto[2]);
  n3:=StrToInt(Texto[3]);
  n4:=StrToInt(Texto[4]);
  n5:=StrToInt(Texto[5]);
  n6:=StrToInt(Texto[6]);
  n7:=StrToInt(Texto[7]);
  n8:=StrToInt(Texto[8]);
  n9:=StrToInt(Texto[9]);
  d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:=11-(d1 mod 11);
  if d1>=10 then d1:=0;
  d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
  d2:=11-(d2 mod 11);
  if d2>=10 then d2:=0;
  calculado:=inttostr(d1)+inttostr(d2);
  digitado:=Texto[10]+Texto[11];

  Result := (calculado = digitado);
end;

class function TLib.ZeroEsq(Texto: String; Qtde: Integer): String;
begin
  Result := StringOfChar('0', Qtde - Texto.Length) + Texto;
end;

end.
