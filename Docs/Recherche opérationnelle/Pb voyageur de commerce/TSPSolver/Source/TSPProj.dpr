program TSPProj;

uses
  Forms,
  Main in 'Main.pas' {TSPSolverForm},
  TimeCount in 'TimeCount.pas',
  Exhaustive in 'Exhaustive.pas',
  Heuristic in 'Heuristic.pas';

{$R *.RES}
{$R Graphic.RES}

begin
  Application.Initialize;
  Application.Title := 'TSP Solver';
  Application.CreateForm(TTSPSolverForm, TSPSolverForm);
  Application.Run;
end.
