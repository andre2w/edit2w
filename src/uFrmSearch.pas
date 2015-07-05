unit uFrmSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  Data.SqlExpr, Data.FMTBcd, System.Actions, Vcl.ActnList,uUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type

  TFrmSearch = class(TForm)
    Panel1: TPanel;
    edSearch: TLabeledEdit;
    btnSearch: TBitBtn;
    GridSearch: TDBGrid;
    dsDBX: TDataSource;
    cdsSearch: TClientDataSet;
    dspSearch: TDataSetProvider;
    sdsSearch: TSQLDataSet;
    ActionList1: TActionList;
    Action1: TAction;
    QrySearch: TFDQuery;
    dsFDC: TDataSource;
    procedure configureQueryDBX(Stmt:string;DBConnection:TCustomConnection);
    procedure configureQueryFDC(Stmt:string;DBConnection:TCustomConnection);
    procedure GridSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
    procedure searchDBX;
    procedure search;
    procedure searchFDC;
  public
    { Public declarations }
    Table,FieldsToShow,FieldsToSearch1,FieldsToSearch2,ConnectionType:string;
    like:Boolean;
    procedure configureQuery(Stmt,ConType:string;DBConnection:TCustomConnection);
  end;

var
  FrmSearch: TFrmSearch;

implementation

{$R *.dfm}

{ TFrmSearch }

procedure TFrmSearch.Action1Execute(Sender: TObject);
begin
 Self.search;
end;

procedure TFrmSearch.configureQuery(Stmt, ConType: string;
  DBConnection: TCustomConnection);
begin
 ConnectionType := ConType;
 if ConnectionType = 'DBX' then
  configureQueryDBX(Stmt,DBConnection)
 else
 if ConnectionType = 'FDC' then
 begin
  configureQueryFDC(Stmt,DBConnection);
 end;
end;

procedure TFrmSearch.configureQueryDBX(Stmt: string; DBConnection: TCustomConnection);
begin
 GridSearch.DataSource := dsDBX;
 sdsSearch.SQLConnection := TSQLConnection(DBConnection);
 cdsSearch.CommandText := Stmt;
 cdsSearch.Open;
end;

procedure TFrmSearch.configureQueryFDC(Stmt: string;
  DBConnection: TCustomConnection);
begin
 GridSearch.DataSource := dsFDC;
 QrySearch.Connection := TFDConnection(DBConnection);
 QrySearch.SQL.Add(Stmt);
 QrySearch.Open;
end;

procedure TFrmSearch.FormShow(Sender: TObject);
begin
 GridSearch.SetFocus;
end;

procedure TFrmSearch.GridSearchKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  ModalResult := mrOk;
end;

procedure TFrmSearch.search;
begin
  if ConnectionType = 'DBX' then
  begin
    Self.searchDBX;
  end
  else
  if ConnectionType = 'FDC' then
  begin
    Self.searchFDC;
  end;
end;

procedure TFrmSearch.searchDBX;
var
 Query: string;
begin
 like := checkForLetters(edSearch.Text);
 Query := 'select '+ FieldsToShow +' from '+ Table;
 if edSearch.Text <> EmptyStr then
 begin
   if like then
    Query := Query + ' where '+ FieldsToSearch1 + ' like ' + QuotedStr('%'+edSearch.Text+'%')
   else
    Query := Query + ' where '+ FieldsToSearch2 + ' = ' + edSearch.Text;
 end;

 cdsSearch.Close;
 cdsSearch.CommandText := Query;
 cdsSearch.Open;
end;

procedure TFrmSearch.searchFDC;
var
 Query: string;
begin
 like := checkForLetters(edSearch.Text);
 Query := 'select '+ FieldsToShow +' from '+ Table;
 if edSearch.Text <> EmptyStr then
 begin
   if like then
    Query := Query + ' where '+ FieldsToSearch1 + ' like ' + QuotedStr('%'+edSearch.Text+'%')
   else
    Query := Query + ' where '+ FieldsToSearch2 + ' = ' + edSearch.Text;
 end;

 with QrySearch do
 begin
   SQL.Clear;
   Close;
   SQL.Add(Query);
   Open;
 end;
end;

end.
