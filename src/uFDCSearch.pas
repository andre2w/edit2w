unit uFDCSearch;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uUtil,uFrmSearch;

 procedure loadFieldsFDC(DBConnection : TCustomConnection;
                      Table,OpenScreen,FieldsToShow:string;
                      Filter,Text,FieldToSearch,FieldToResult:string);
 procedure componentSetupFDC;
 function searchFireDAC:uUtil.TSearchResult;

implementation

uses
  System.UITypes;

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
 Qry           : TFDQuery;
 FieldsToSearch: uUtil.TStringArray;
 Like          : Boolean;

procedure loadFieldsFDC(DBConnection : TCustomConnection;Table,OpenScreen,FieldsToShow,Filter,Text,FieldToSearch,FieldToResult:string);
begin
//Seriously I'm very sorry.
 ADBConnection  := DBConnection;
 ATable         := Table;
 AOpenScreen    := OpenScreen;
 AFieldsToShow  := FieldsToShow;
 AFilter        := Filter;
 AText          := Text;
 AFieldToSearch := FieldToSearch;
 AFieldToResult := FieldToResult;
end;

procedure componentSetupFDC;
begin
  Qry            := TFDQuery.Create(nil);
  Qry.Connection := TFDConnection(ADBConnection);
  Like           := checkForLetters(AText);
end;

function searchFireDAC:uUtil.TSearchResult;
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
   FrmSearch.configureQuery(Query,'FDC',ADBConnection);
   if  FrmSearch.Showmodal = mrOk then
   begin
    Result.Text        := FrmSearch.QrySearch.FieldByName(FieldsToSearch[0]).AsString + ' - ' + FrmSearch.QrySearch.FieldByName(FieldsToSearch[1]).AsString;
    Result.ResultField := FrmSearch.QrySearch.FieldByName(AFieldToResult).AsString;
   end;
 end
 else
 begin
  Result.Text        := Qry.FieldByName(FieldsToSearch[0]).AsString + ' - '+ Qry.FieldByName(FieldsToSearch[1]).AsString;
  Result.ResultField := Qry.FieldByName(AFieldToResult).AsString;
 end;

end;

end.
