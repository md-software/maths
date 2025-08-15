//  TRAVELING SALESMAN PROJECT
//  GrMikeD - GrMikeD@usa.net

//Unit of the Exhaustive Algorithm
unit Exhaustive;

interface

uses main, forms, sysutils;

procedure Exhaust;

implementation

var A: array[1..MaxV] of integer;  //a copy of the distance array
    P1,P2: array[1..MaxV+1] of integer;  //arrays of the 2 paths I compare each time

//procedure that compares the two paths T1,T2 and stores the smaller
procedure Compare;
var j,c1,c2:integer;
    Error1,Error2:boolean;
begin
  if Stop then
    exit;
  Error1:= false;
  Error2:= false;
  c1:= 0;
  c2:= 0;
  PathFound:= true;
  for j:=1 to V do
  begin
    if Stop then
      exit;
    Inc(Flop);
    if E[P1[j],P1[j+1]]=-1 then
    begin
      Error1:= true;
      Break;
    end
    else
      c1:= c1 + E[P1[j],P1[j+1]];
  end;
  for j:=1 to V do
  begin
    if Stop then
      exit;
    Inc(Flop);
    if E[P2[j],P2[j+1]]=-1 then
    begin
      Error2:=true;
      Break;
    end
    else
      c2:= c2 + E[P2[j],P2[j+1]];
  end;
  Inc(Flop);
  if ((c1<=c2)or(Error2))and(Error1=false) then
  begin
    Cost:= c1;
    for j:=1 to V+1 do
      P[j]:= P1[j];
  end;
  if ((c1>c2)or(Error1))and(Error2=false) then
  begin
    Cost:= c2;
    for j:=1 to V+1 do
    begin
        P1[j]:=P2[j];
        P[j]:=P2[j];
    end;
  end;
  if Error1 and Error2 then
     PathFound:= false;
  Application.ProcessMessages;
  TSPSolverForm.TourEdit.Clear;
  for j:=1 to V+1 do
      TSPSolverForm.TourEdit.Text:= TSPSolverForm.TourEdit.Text + 'a' + IntToStr(P1[j]);
  TSPSolverForm.TourEdit.Update;
  TSPSolverForm.CostEdit.Text:= IntToStr(Cost);
  TSPSolverForm.CostEdit.Update;
end;

//procedure that initializes the T1,T2 each time
procedure Process;
var j:integer;
begin
  if Stop then
    exit;
  if P1[1]=0 then
  begin
    for j:=1 to V do
      P1[j]:=A[j];
    P1[V+1]:=P1[1];
  end
  else
  begin
    for j:=1 to V do
      P2[j]:= A[j];
    P2[V+1]:= P2[1];
    Compare;
  end;
end;

//A simple swap procedure
procedure Swap(var s1,s2: integer);
var j:integer;
begin
 j:= s1;
 s1:= s2;
 s2:= j;
end;

//procedure for the (n-1)! permutations of the cities
procedure Permute(i: integer);
var j:integer;
begin
  Application.ProcessMessages;
  if Stop then
    exit;
  if i=V then
  begin
     if A[1]=1 then
         process;
  end
  else
  begin
    Permute(i+1);
    if Stop then
      exit;
    for j:=i+1 to V do
    begin
      Swap(A[i],A[j]);
      Permute(i+1);
      if Stop then
        exit;
      Swap(A[i],A[j]);
    end;
  end;
end;


//Main procedure
procedure Exhaust;
var i:integer;
begin
  Counter.StartTimeCount;
  for i:=1 to MaxV do
  begin
    P1[i]:=0;
    A[i]:=i;
  end;
  Permute(1);
  Main.time:= StrToFloat(Counter.ElapsedSecs);
end;

end.