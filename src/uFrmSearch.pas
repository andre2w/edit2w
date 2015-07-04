unit uFrmSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  Data.SqlExpr, Data.FMTBcd, System.Actions, Vcl.ActnList;

type
  TStringArray = array of string;
  TFrmSearch = class(TForm)
    Panel1: TPanel;
    edSearch: TLabeledEdit;
    btnSearch: TBitBtn;
    GridSearch: TDBGrid;
    dsSearch: TDataSource;
    cdsSearch: TClientDataSet;
    dspSearch: TDataSetProvider;
    sdsSearch: TSQLDataSet;
    ActionList1: TActionList;
    Action1: TAction;
    procedure configureQuery(Stmt:string;DBConnection:TSQLConnection);
    procedure GridSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
    function removeSemicolon(AText, ADelimiter: string):TStringArray;
    procedure search;
    function checkForLetters(text:string):Boolean;
  public
    { Public declarations }
    Table,FieldsToShow,FieldsToSearch1,FieldsToSearch2:string;
    like:Boolean;
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

function TFrmSearch.checkForLetters(text: string): Boolean;
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

procedure TFrmSearch.configureQuery(Stmt: string; DBConnection: TSQLConnection);
begin
 sdsSearch.SQLConnection := DBConnection;
 cdsSearch.CommandText := Stmt;
 cdsSearch.Open;
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

function TFrmSearch.removeSemicolon(AText, ADelimiter: string): TStringArray;
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

procedure TFrmSearch.search;
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

end.
