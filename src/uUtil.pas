unit uUtil;

interface
type
 TStringArray = array of string;
 TSearchResult = record
  Text:string ;
  ResultField: string;
 end;
 TErrorMessages = record
   Connection:string;
   Table:string;
   FieldToSearch:string;
   FieldToResult:string;
 end;

 function removeSemicolon(AText, ADelimiter: string):TStringArray;
 function clearInput(AText:string):string;
 function checkForLetters(text: string): Boolean;
 function prepareSearchFields(Text:string): string;
 function getErrorMessages(Language:String):TErrorMessages;

implementation

uses
  System.SysUtils;

function removeSemicolon(AText, ADelimiter: string):TStringArray;
var
  txtFinal: TStringArray;
  pospv,j,i : Integer;
begin
 pospv := 1;
 i := 0;
 SetLength(txtFinal,i + 1);
 repeat
  pospv := 0;
  pospv := Pos(ADelimiter,AText,1);

  if pospv > 0 then
    txtFinal[i] := Copy(AText,0,pospv - 1) // If you want the semicolon you need to remove the - 1 from the copy.
  else
    txtFinal[i] := Copy(AText,0,length(AText));

  AText := Copy(AText,pospv+1,Length(AText));

  Inc(i);
  SetLength(txtFinal,i + 1);
 until (pospv = 0);

 SetLength(txtFinal,Pred(Length(txtFinal)));
 Result :=  txtfinal;
end;

function clearInput(AText:string):string;
begin
 Result :=  StringReplace(AText, ';', '', [rfReplaceAll, rfIgnoreCase]);
end;

function checkForLetters(text: string): Boolean;
const
  letters = ['A'..'Z', 'a'..'z'];
var
  I: Integer;
begin
 result := False;
 for I := 0 to Pred(Length(text)) do
 begin
   if text[i+1] in letters  then
    result := True;
 end;
end;

function prepareSearchFields(Text:string): string;
var
 Search:TStringArray;
  I: Integer;
begin
  if Text = EmptyStr then
  begin
   Result := '*';
  end
  else
  begin
   Search := removeSemicolon(Text,';');
   Result := '';
   for I := 0 to Pred(Length(Search)) do
   begin
    if Search[i] <> EmptyStr then
    begin
      if I = Pred(Length(Search)) then
        Result := Result + Search[i]
      else
        Result := Result + Search[i]+ ', ';
    end;
   end;
  end;
end;

function getErrorMessages(Language:String):TErrorMessages;
begin
  if Language = 'PT' then
  begin
   Result.Connection    := 'Conexão com banco de dados invalida!!' + #13 + 'Por favor verifique o campo ADBConnection';
   Result.Table         := 'Tabela não configurada!' + #13 + 'Por favor verifique o campo ATable';
   Result.FieldToSearch := 'Campo para pesquisar não configurado' + #13 + 'Por favor verifique o campo AFieldToSearch';
   Result.FieldToResult := 'Campo de resultado não configurado' + #13 + 'Por favor verifique o campo AFieldToResult';
  end
  else
  begin
   Result.Connection    := 'Invalid Configuration: Invalid Database Connection!'+ #13 +'Please check if ADBConnection is filled correctly';
   Result.Table         := 'Invalid Configuration: Table not Assigned!' + #13 +'Please check if ATable is filled correctly';
   Result.FieldToSearch := 'Invalid Configuration: Fields to Search not Assigned!' + #13 +'Please check if AFieldToSearch is filled correctly';
   Result.FieldToResult := 'Invalid Configuration: Field to Result not Assigned!' + #13 +'Please check if AFieldToResult is filled correctly';
  end;
end;

end.
