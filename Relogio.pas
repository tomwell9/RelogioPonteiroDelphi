unit Relogio;

interface
Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, ExtCtrls;

type

  TRelogio = Class
    private
      Xco, Yco  : Integer;
      Fcontexto : TForm;
      FXcor, FYcor, FRaio: Integer;
      FCorArco, FCorDeFundo:TColor;
    procedure ArcoPrincipal( Contexto:TForm; X, Y, Pontos, Raio: Integer; Cor :Tcolor = clBlack;
                                                             CanetaLargura: Integer = 3) ;
    procedure ExecutaRelogio( Contexto:TForm; X, Y, Pontos: Integer; Raio: Double; Cor :Tcolor = clBlack;
                                                             CanetaLargura: Integer = 3) ;
    public
    procedure PintarArcoPrincipal;
    procedure AjustarTempo(Hora:TDateTime);
    procedure IniciarRelogio( Sender: TObject );
    Constructor Create( Timer:TTimer ; Contexto: TForm; X, Y, Raio:Integer; CordoArco, CorDeFundo: TColor);

  end;

implementation

uses DateUtils;

{ TRelogio }

procedure TRelogio.AjustarTempo(Hora: TDateTime);
begin
// NÃO IMPLEMENTADO...
end;

procedure TRelogio.ArcoPrincipal( Contexto:TForm ; X, Y, Pontos , Raio: Integer; Cor: Tcolor = clBlack;
                            CanetaLargura: Integer = 3);
var i, seno, coseno: Integer;
begin
  for i := 1 to Pontos do
  begin
    with Contexto do
    begin
      Canvas.Pen.Width := 3;
      Canvas.Pen.Color := FCorArco;
      coseno := X  - Round(Cos( 2*PI *i/60  ) * FRaio);
      seno   := Y  - Round(Sin( 2*PI *i/60 )  * FRaio);
      Canvas.MoveTo( coseno , seno );
      Canvas.LineTo( coseno , seno );
      Canvas.Pen.Width := CanetaLargura;
      coseno := X  - Round(Cos( 2*PI *i/12  ) * FRaio);
      seno   := Y  - Round(Sin( 2*PI *i/12 )  * FRaio);
      Canvas.MoveTo( coseno , seno );
      Canvas.LineTo( coseno , seno );
    end;
  end;

end;


constructor TRelogio.Create(Timer: TTimer; Contexto: TForm; X, Y,
  Raio: Integer; CordoArco, CorDeFundo: TColor);
begin
  Fcontexto := Contexto;
  FXcor := X;
  FYcor := Y;
  FRaio := Raio;
  FCorArco := CordoArco;
  FCorDeFundo := CorDeFundo;

  Timer.OnTimer := IniciarRelogio;
end;

procedure TRelogio.ExecutaRelogio(Contexto: TForm; X, Y, Pontos:Integer; Raio: Double; Cor: Tcolor; CanetaLargura: Integer);

 procedure MarcarPonteiro(X, Y: Integer; Cor: TColor);
 begin
   with Contexto do
   begin
     Canvas.Pen.Color := Cor;
     Canvas.LineTo(X,Y);
   end;
 end;

 var seno, coseno: Integer;
begin
  Contexto.Canvas.Pen.Width := CanetaLargura;

  // limpador ponteiro segundo
  {   Contexto.Canvas.MoveTo( X , Y );
  MarcarPonteiro(Xco,Yco,clBtnFace);}
  coseno   := X  - Round( Cos( ( 2*PI * SecondOf(Now))/60  + DegToRad(90) ) *70);
  seno     := Y  - Round( Sin( ( 2*PI * SecondOf(Now))/60 + DegToRad(90) )*70);

  Contexto.Canvas.Pen.Width := 1;
  Contexto.Canvas.Brush.Color := FCorDeFundo ;
  Contexto.Canvas.MoveTo( X , Y );
  Contexto.Canvas.Ellipse(X-87,Y-87,X+87,Y+87);

  Contexto.Canvas.Brush.Color := clBlack ;
  Contexto.Canvas.MoveTo( X , Y );
  Contexto.Canvas.Ellipse(X-8,Y-8,X+8,Y+8);


  // PONTEIRO SEGUNDOS

  Contexto.Canvas.MoveTo( X , Y );
  MarcarPonteiro(coseno, seno , clBlack);

  // PONTEIRO MINUTOS
  Contexto.Canvas.Pen.Width := 1;
  coseno   := X  - Round( Cos( ( 2*PI * MinuteOf(Now) + SecondOf(Now)/60 )/60  + DegToRad(90)) *75);
  seno     := Y  - Round( Sin( ( 2*PI * MinuteOf(Now) + SecondOf(Now)/60 )/60  + DegToRad(90)) *75);

  Contexto.Canvas.Pen.Width := 2;
  Contexto.Canvas.MoveTo( X , Y );
  MarcarPonteiro(coseno, seno, clBlack);

  // PONTEIRO HORAS
  coseno   := X  - Round( Cos( ( 2*PI * HourOf(Now) +  MinuteOf(Now)/12  )/12  + DegToRad(90) ) *50);
  seno     := Y  - Round( Sin( ( 2*PI * HourOf(Now) +  MinuteOf(Now)/12  )/12  + DegToRad(90) ) *50);

  Contexto.Canvas.MoveTo( X , Y );
  MarcarPonteiro(coseno, seno, clBlack);

  // EXTENSÃO PONTEIRO SEGUNDOS
  Contexto.Canvas.MoveTo( X  , Y );
  coseno   := X - Round( Cos(( 2*PI * SecondOf(Now))/60 + DegToRad(270) ) *15);
  seno     := Y - Round( Sin(( 2*PI * SecondOf(Now))/60 + DegToRad(270) ) *15);
  MarcarPonteiro(coseno, seno  , clBlack);

  Contexto.Canvas.Pen.Width := 1;
  Contexto.Canvas.Brush.Color := clInactiveBorder;
  Contexto.Canvas.Brush.Style := bsClear;
  Contexto.Canvas.Font.Style := [fsbold, fsUnderline];
  Contexto.Canvas.TextOut(X-25,Y+50, TimeToStr(now) );


  Xco := coseno;
  Yco := seno;
  {   Inc(P);
  Dec(i);
  }
  //  end;
end;

procedure TRelogio.IniciarRelogio(Sender: TObject);
begin
  ExecutaRelogio(Fcontexto, FXcor, FYcor,0,0);
end;

procedure TRelogio.PintarArcoPrincipal;
begin
  ArcoPrincipal( Fcontexto, FXcor, FYcor, 60, FRaio, FCorArco,10);
end;

end.
