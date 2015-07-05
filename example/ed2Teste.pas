unit ed2Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXFirebird, Vcl.StdCtrls, Edit2w,
  Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    Edit2w1: TEdit2w;
    Label1: TLabel;
    Button1: TButton;
    FDConnection1: TFDConnection;
    Edit2w2: TEdit2w;
    procedure Button1Click(Sender: TObject);
    procedure Edit2w1AfterSearch(Sender: TObject);
    procedure Edit2w2AfterSearch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 Label1.Caption := Edit2w1.Result;
end;

procedure TForm1.Edit2w1AfterSearch(Sender: TObject);
begin
 label1.caption := Edit2w1.result;
end;

procedure TForm1.Edit2w2AfterSearch(Sender: TObject);
begin
 label1.caption := Edit2w2.result;
end;

end.
