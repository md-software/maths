unit TsmRoute;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TsmTypes;

type
  TRouteForm = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure UpdateIt(ChromRec: TChromRec);
  private
    BestChrom: TChromRec;
  end;

var
  RouteForm: TRouteForm;

implementation

uses
  TsmMain;

{$R *.DFM}

{-------------------- TRouteForm ----------------------}

procedure TRouteForm.PaintBox1Paint(Sender: TObject);
var
  J: TMaxCity;
  C: PCityRec;
begin
  with PaintBox1.Canvas do
  begin
    FillRect(ClipRect);
    with MainForm.Simulation.Map do
    begin
      // Draw all cities using small circles
      for J := 0 to MainForm._Cities -1 do
      begin
        C := City[J];
///        C := TCityRec(TVarData(City[BestChrom.Tour[J]]).VUnknown^);
        Ellipse(C.X +10-2, C.Y +10-2, C.X +10+3, C.Y +10+3);
        TextOut(C.X +10+5, C.Y +10+5, IntToStr(J +1));
      end;
      // Draw lines between the cities using the best chromosome
      for J := 1 to MainForm._Cities -1 do
      begin
        C := City[ BestChrom.Tour[J] -1 ];
///        C := TCityRec(TVarData(City[BestChrom.Tour[J-1]]).VUnknown^);
        MoveTo(C.X +10, C.Y +10);
        C := City[ BestChrom.Tour[J+1] -1 ];
        LineTo(C.X +10, C.Y +10);
      end;
      C := City[ BestChrom.Tour[MainForm._Cities] -1 ];
      MoveTo(C.X +10, C.Y +10);
      C := City[ BestChrom.Tour[1] -1 ];
      LineTo(C.X +10, C.Y +10);
    end;
  end;
end;


procedure TRouteForm.UpdateIt(ChromRec: TChromRec);
begin
  BestChrom := ChromRec;
///  Show;
  PaintBox1Paint(Self);
end;


procedure TRouteForm.FormCreate(Sender: TObject);
begin
  PaintBox1.Canvas.Brush.Color := clSilver;
end;

end.

