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
    FALanguage: string;


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
    property ALanguage : string read FALanguage write FALanguage;

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
var
 Errors : uUtil.TErrorMessages;
begin
  Errors := getErrorMessages(ALanguage);
  if not Assigned(FADBConnection) then
  begin
    MessageDlg(Errors.Connection,mtError,[mbOK],0);
    Abort;
  end;

  if FATable = EmptyStr then
  begin
    MessageDlg(Errors.Table,mtError,[mbOK],0);
    Abort;
  end;

  if FAFieldToSearch = EmptyStr then
  begin
    MessageDlg(Errors.FieldToSearch,mtError,[mbOK],0);
    Abort;
  end;

  if FAFieldToResult = EmptyStr then
  begin
    MessageDlg(Errors.FieldToResult,mtError,[mbOK],0);
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
                 FAFieldToResult,
                 FALanguage);
   componentSetupDBX;
   uResult   := searchDBExpress;

   if (uResult.Text = 'NOT FOUND...') and (ALanguage = 'PT') then
   begin
     Self.Text := 'NAO ENCONTRADO...';
     FResult   := EmptyStr;
   end
   else
   begin
    Self.Text := uResult.Text;
    FResult   := uResult.ResultField;
   end;
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
                 FAFieldToResult,
                 FALanguage);
   componentSetupFDC;
   uResult   := searchFireDAC;

   if (uResult.Text = 'NOT FOUND...') and (ALanguage = 'PT') then
   begin
     Self.Text := 'NAO ENCONTRADO...';
     FResult   := EmptyStr;
   end
   else
   begin
    Self.Text := uResult.Text;
    FResult   := uResult.ResultField;
   end;
end;

procedure TEdit2w.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if key = #13 then
  begin
   validateConfiguration;
   Search;
  end;
end;


end.
