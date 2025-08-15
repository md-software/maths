unit TsmStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, TsmTypes;

type
  TStatusForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
  public
    procedure UpdateGraph(Fitness: MaxLongintType);
    procedure UpdateValues(Gen, Mut: Word; Dist: MaxLongintType);
  private
    History: array[1..300] of Word;    ///temp!
  end;

var
  StatusForm: TStatusForm;

implementation

{$R *.DFM}

uses
  TsmMain, TsmSim;

{--------------------- TStatusForm --------------------}

procedure TStatusForm.PaintBox1Paint(Sender: TObject);
var
  I: Word;
  Scale: Real;               // Scale of graph depending on size of wnd.
begin
  with PaintBox1.Canvas do
  begin
    FillRect(ClipRect);
    Scale := PaintBox1.Height / History[1];
    for I := 1 to MainForm.Simulation.Population.Generation do
    begin
      MoveTo(10 + I*2, PaintBox1.Height - Round(History[I] * Scale));
      LineTo(10 + I*2, PaintBox1.Height);
    end;
  end;
end;


procedure TStatusForm.UpdateGraph(Fitness: MaxLongintType);
var
  pop: TPopulation;
  map: TMap;
begin
  map := MainForm.Simulation.Map;
  pop := MainForm.Simulation.Population;
  History[MainForm.Simulation.Population.Generation] := Round(Fitness/10000);
///  History[MainForm.Simulation.Population.Generation] := Fitness;
  PaintBox1Paint(Self);
end;


procedure TStatusForm.UpdateValues(Gen, Mut: Word; Dist: MaxLongintType);
begin
  if MainForm.Simulation.Population.Generation = 1 then
  begin
    Label10.Caption := IntToStr(MainForm._Generations);
    Label11.Caption := IntToStr(MainForm._MutationRate);
    Label12.Caption := IntToStr(MainForm._Cities);
    Label13.Caption := IntToStr(MainForm._PopSize);
    Label14.Caption := IntToStr(MainForm._Parents);
    Label15.Caption := IntToStr(Dist);
  end;
  Label16.Caption := IntToStr(Gen);
  Label17.Caption := IntToStr(Mut);
  Label18.Caption := IntToStr(Dist);
end;

end.

