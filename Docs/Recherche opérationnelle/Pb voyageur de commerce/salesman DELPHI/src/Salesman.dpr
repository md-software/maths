program Salesman;

uses
  Forms,
  TsmMain in 'TsmMain.pas' {MainForm},
  TsmStat in 'TsmStat.pas' {StatusForm},
  TsmTypes in 'TsmTypes.pas',
  TsmSim in 'TsmSim.pas',
  TsmRoute in 'TsmRoute.pas' {RouteForm},
  TsmAbout in 'TsmAbout.pas' {AboutBox},
  RndmList in '..\RndmList.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Travelling Salesman';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TStatusForm, StatusForm);
  Application.CreateForm(TRouteForm, RouteForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
