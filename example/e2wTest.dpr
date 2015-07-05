program e2wTest;

uses
  Vcl.Forms,
  ed2Teste in 'ed2Teste.pas' {Form1},
  uFDCSearch in '..\src\uFDCSearch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
