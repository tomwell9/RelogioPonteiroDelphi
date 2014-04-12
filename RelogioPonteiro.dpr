program RelogioPonteiro;

uses
  Forms,
  Circun in 'D:\Estudo Circunferencia\Circun.pas' {Form1},
  Relogio in 'D:\Estudo Circunferencia\Relogio.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
