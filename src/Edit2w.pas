unit Edit2w;

interface

uses
  System.SysUtils,System.Classes, Vcl.Controls, Vcl.StdCtrls, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Datasnap.DBClient, Datasnap.Provider,Data.DBXCommon, MidasLib, uUtil, uDBXSearch,uFDCSearch;

type
  TEdit2w = class(TEdit)
  private
    FADBConnection : TCustomConnection;
    FATable        : string;
    FAOpenScreen   : string;
    FAFieldsToShow : string;
    FAFilter       : string;
    FResult        : string;
    FText          : string;
    FAFieldToSearch: string;
    FAFieldToResult: string;
    FOnAfterSearch : TNotifyEvent;
    FAConnectionType: string;

    { Private declarations }
    procedure SetFOnAfterSearch(const Value: TNotifyEvent);

  protected
    { Protected declarations }
    procedure KeyPress(var Key: Char); override;
    procedure validateConfiguration;
    procedure SearchDBX;
    procedure SearchFDC;
  public
    { Public declarations }
    procedure Search;
  published
    { Published declarations }
    property ADBConnection:TCustomConnection  read FADBConnection write FADBConnection;
    property ATable: string read FATable write FATable;
    property AFieldsToShow: string read FAFieldsToShow write FAFieldsToShow;
    property AOpenScreen: string read FAOpenScreen write FAOpenScreen;
    property Result: string read FResult write FResult;
    property AFilter: string read FAFilter write FAFilter;
    property AFieldToSearch : string read FAFieldToSearch write FAFieldToSearch;
    property AFieldToResult : string read FAFieldToResult write FAFieldToResult;
    property AConnectionType: string read FAConnectionType write FAConnectionType;
    property OnAfterSearch: TNotifyEvent read FOnAfterSearch write SetFOnAfterSearch;

  end;

procedure Register;

implementation

uses
 uFrmSearch, Vcl.Dialogs ;

var
 Qry:TSqlQuery;
 like:Boolean;
 FieldsToSearch: uUtil.TStringArray;

procedure Register;
begin
  RegisterComponents('Standard', [TEdit2w]);
end;

{ TEdit2w }

procedure TEdit2w.Search;
begin
 if FAConnectionType = 'DBX' then
 begin
  SearchDBX;
 end
 else
 if FAConnectionType = 'FDC' then
 begin
  SearchFDC;
 end;

 if Assigned(FOnAfterSearch) then
  FOnAfterSearch(Self);

end;

procedure TEdit2w.SetFOnAfterSearch(const Value: TNotifyEvent);
begin
  FOnAfterSearch := Value;
end;

procedure TEdit2w.validateConfiguration;
begin
  if not Assigned(FADBConnection) then
  begin
    MessageDlg('Invalid Configuration: Invalid Database Connection!'+ #13 +'Please check if ADBConnection is filled correctly',mtError,[mbOK],0);
    Abort;
  end;

  if FATable = EmptyStr then
  begin
    MessageDlg('Invalid Configuration: Table not Assigned!' + #13 +'Please check if ATable is filled correctly',mtError,[mbOK],0);
    Abort;
  end;

  if FAFieldToSearch = EmptyStr then
  begin
    MessageDlg('Invalid Configuration: Fields to Search not Assigned!' + #13 +'Please check if AFieldToSearch is filled correctly',mtError,[mbOK],0);
    Abort;
  end;

  if FAFieldToResult = EmptyStr then
  begin
    MessageDlg('Invalid Configuration: Fields to Result not Assigned!' + #13 +'Please check if AFieldToResult is filled correctly',mtError,[mbOK],0);
    Abort;
  end;
end;



procedure TEdit2w.SearchDBX;
var
  uResult : TSearchResult;
begin
   FText := Self.Text;
   loadFieldsDBX(FADBConnection,
                 FATable,
                 FAOpenScreen,
                 FAFieldsToShow,
                 FAFilter,
                 FText,
                 FAFieldToSearch,
                 FAFieldToResult);
   componentSetupDBX;
   uResult   := searchDBExpress;
   Self.Text := uResult.Text;
   FResult   := uResult.ResultField;
end;

procedure TEdit2w.SearchFDC;
var
  uResult : TSearchResult;
begin
   FText := Self.Text;
   loadFieldsFDC(FADBConnection,
                 FATable,
                 FAOpenScreen,
                 FAFieldsToShow,
                 FAFilter,
                 FText,
                 FAFieldToSearch,
                 FAFieldToResult);
   componentSetupFDC;
   uResult   := searchFireDAC;
   Self.Text := uResult.Text;
   FResult   := uResult.ResultField;
end;

procedure TEdit2w.KeyPress(var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
   validateConfiguration;
   Search;
  end;
end;


end.
