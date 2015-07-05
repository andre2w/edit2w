unit uDBXSearch;

interface

uses
  System.SysUtils,System.Classes, Vcl.Controls, Vcl.StdCtrls, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Datasnap.DBClient, Datasnap.Provider,Data.DBXCommon, MidasLib, uUtil, uFrmSearch;

 procedure loadFieldsDBX(DBConnection : TCustomConnection;
                      Table,OpenScreen,FieldsToShow:string;
                      Filter,Text,FieldToSearch,FieldToResult:string);
 procedure componentSetupDBX;
 function searchDBExpress:uUtil.TSearchResult;

implementation

uses
  Vcl.Dialogs;

var
 ADBConnection : TCustomConnection;
 ATable        : string;
 AOpenScreen   : string;
 AFieldsToShow : string;
 AFilter       : string;
 Result        : string;
 AText         : string;
 AFieldToSearch: string;
 AFieldToResult: string;
 Qry           : TSQLQuery;
 FieldsToSearch: uUtil.TStringArray;
 Like          : Boolean;

procedure loadFieldsDBX(DBConnection:TCustomConnection;Table,OpenScreen,FieldsToShow,Filter,Text,FieldToSearch,FieldToResult:string);
begin
//Sorry
 ADBConnection  := DBConnection;
 ATable         := Table;
 AOpenScreen    := OpenScreen;
 AFieldsToShow  := FieldsToShow;
 AFilter        := Filter;
 AText          := Text;
 AFieldToSearch := FieldToSearch;
 AFieldToResult := FieldToResult;
end;

procedure componentSetupDBX;
begin
  Qry := TSQLQuery.Create(nil);
  Qry.SQLConnection := TSQLConnection(ADBConnection);
  like := checkForLetters(AText);
end;

function searchDBExpress:uUtil.TSearchResult;
var
 Query : string;
begin
 AText  := clearInput(AText);
 FieldsToSearch := removeSemicolon(AFieldToSearch,';');
 AFieldsToShow := prepareSearchFields(AFieldsToShow);

 Query := 'select '+ AFieldsToShow +' from '+ ATable + ' where 1=1';
 if AText <> EmptyStr then
 BEGIN
   if like then
    Query := Query + ' and '+ FieldsToSearch[1]+ ' like ' + QuotedStr('%'+AText+'%')
   else
    Query := Query + ' and '+ FieldsToSearch[0]+ ' = ' + AText;
 END;
 if AFilter <> EmptyStr then
 begin
   AFilter := clearInput(AFilter);
   Query := Query + ' and ' + AFilter;
 end;

 with Qry,sql do
 begin
   Clear;
   Close;
   Add(Query);
   Open;
 end;

 if Qry.IsEmpty then
 begin
  Result.Text := 'NOT FOUND!';
  Result.ResultField := EmptyStr;
 end
 else
 if Qry.RecordCount > 1 then
 begin
   FrmSearch := TFrmSearch.Create(nil);
   FrmSearch.Table := ATable;
   FrmSearch.FieldsToShow := AFieldsToShow;
   FrmSearch.like := like;
   FrmSearch.FieldsToSearch1 := FieldsToSearch[1];
   FrmSearch.FieldsToSearch2 := FieldsToSearch[0];
   FrmSearch.configureQuery(Query,'DBX',ADBConnection);
   if  FrmSearch.Showmodal = mrOk then
   begin
    Result.Text        := FrmSearch.cdsSearch.FieldByName(FieldsToSearch[0]).AsString + ' - ' + FrmSearch.cdsSearch.FieldByName(FieldsToSearch[1]).AsString;
    Result.ResultField := FrmSearch.cdsSearch.FieldByName(AFieldToResult).AsString;
   end;
 end
 else
 begin
  Result.Text        := Qry.FieldByName(FieldsToSearch[0]).AsString + ' - '+ Qry.FieldByName(FieldsToSearch[1]).AsString;
  Result.ResultField :=  Qry.FieldByName(AFieldToResult).AsString;
 end;
end;

end.
