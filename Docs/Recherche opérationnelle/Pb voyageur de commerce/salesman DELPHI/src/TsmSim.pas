unit TsmSim;

interface

uses
  Classes, TsmTypes;

type
  TSimulation = class(TThread)
  public
    Map: TMap;
    Population: TPopulation;
    constructor Create;
    destructor Destroy; override;
  private
    procedure DoUpdateStatus;
  protected
    procedure Execute; override;
    procedure UpdateStatus;
  end;

implementation

uses
  TsmStat, TsmRoute, TsmMain;

{-------------------- TSimulation ---------------------}

constructor TSimulation.Create;
begin
  inherited Create(False);
//  FreeOnTerminate := True;
  Suspend;         // Necessary because of time-consuming initialization

  Map := TMap.Create;
  Map.PlaceCities;
  Map.InitCityTable;
  Population := TPopulation.Create;
  Population.CalculateFitnesses;  // Calculate fitness values of gen. #1
///  UpdateStatus;

{  // Dispose old data (if any)
  Map.Clear;
  Population.Clear; }

  Resume;          // Resume execution of the thread
end;


destructor TSimulation.Destroy;
begin
  Map.Free;
  Population.Free;
  inherited Destroy;
end;


procedure TSimulation.DoUpdateStatus;
var
  C: PChromRec;
begin
  with Population do
  begin
    // Select fittest chrom for status update
    C := Chrom[BestFit];
    StatusForm.UpdateGraph(C.Fitness);
    StatusForm.UpdateValues(Generation, Mutations, Round(C.Fitness / 10000));
    RouteForm.UpdateIt(C^);
  end;
end;


procedure TSimulation.UpdateStatus;
begin
  Synchronize(DoUpdateStatus);
end;


procedure TSimulation.Execute;
begin
  UpdateStatus;
  StatusForm.Show;
  RouteForm.Show;
  MainForm.Show;             // Just called to give form focus

  // Run simulation for MaxGenerations rounds or until user stops/exits
  with Population do
    while Generation < MainForm._Generations do
    begin
      SelectParents;         // Select fittest chroms. as parents for next gen.
      Crossover;             // Cross the parents to make next gen.
      CalculateFitnesses;    // Calc. fitness values of child chroms.
      UpdateStatus;

      if Terminated then
        Exit;
    end;
end;

end.

