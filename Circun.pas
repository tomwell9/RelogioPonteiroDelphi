unit Circun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, Relogio, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    clock: TRelogio;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormPaint(Sender: TObject);
begin
  clock.PintarArcoPrincipal;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  clock := TRelogio.Create( Timer1, Self, ClientWidth div 2,
                              ClientHeight div 2, 95, clGreen, clActiveBorder );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  clock.Free;
end;

end.
