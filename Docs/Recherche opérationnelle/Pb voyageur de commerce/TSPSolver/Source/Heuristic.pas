//  TRAVELING SALESMAN PROJECT
//  GrMikeD - GrMikeD@usa.net

//Unit of the heuristic algorithm
Unit Heuristic;

interface

uses main,sysutils,forms;

procedure Heurist;

var Q:array[1..MaxV,1..MaxV] of integer;  //a copy of the distance array

implementation

//procedure that finds the city with the smaller distance
function Smaller(a:integer):integer; 
var i,temp:integer;
begin
  Result:= -1;
  Application.ProcessMessages;
  if Stop then
    exit;
  temp:= 1;
  PathFound:= false;
  for i:=1 to V do
  begin
    if Stop then
      exit;
    if i<>a then
    begin
      Inc(flop);
      if ((Q[a,i]<>-1)and((Q[a,temp]=-1)or(Q[a,i]<=Q[a,temp]))) then
      begin
        temp:= i;
        PathFound:= true;
      end;
    end;
  end;
  Result:= temp;
  Inc(flop);
  cost:= cost + Q[a,temp];
  Q[a,temp]:= -1;
  for i:=1 to V do
      Q[i,a]:= -1;
end;

//Main procedure
procedure Heurist;
var i,k,a,b:integer;
begin
  Counter.StartTimeCount;
  for a:=1 to V do
    for b:=1 to V do
      Q[a,b]:= E[a,b];
  P[1]:= 1;
  i:= 2;
  k:= 1;
  while i<=V do
  begin
    if Stop then
      exit;
    P[i]:= Smaller(k);
    k:= P[i];
    if i=V then
    begin
      if E[P[i],1]<>-1 then
      begin
        cost:= cost + E[P[i],1];
        P[i+1]:= 1;
        Application.ProcessMessages;
        TSPSolverForm.TourEdit.Clear;
        for a:=1 to V+1 do
          TSPSolverForm.TourEdit.Text:= TSPSOlverForm.TourEdit.Text + 'a' + IntToStr(P[a]);
        TSPSolverForm.TourEdit.Update;
        TSPSolverForm.CostEdit.Text:= IntToStr(cost);
        TSPSolverForm.CostEdit.Update;
      end
      else
        PathFound:= false;
    end;
    Inc(i);
  end;
  Main.time:= StrToFloat(Counter.ElapsedSecs);
end;

end.