unit uUtil;

interface
type
 TStringArray = array of string;
 TSearchResult = record
  Text:string ; ResultField: string;
 end;

 function removeSemicolon(AText, ADelimiter: string):TStringArray;
 function clearInput(AText:string):string;
 function checkForLetters(text: string): Boolean;
 function prepareSearchFields(Text:string): string;

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
   if text[i] in letters  then
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


end.
