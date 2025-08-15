unit TsmTypes;

interface

uses
  RndmList, Classes;

type
  MaxLongintType = 0..MaxLongint;
  TMaxCity = Word;
  TMaxPop =  Word;

  PCityRec = ^TCityRec;
  TCityRec = record
    X, Y: 0..400;                      // City's (x,y) coordinates
  end;
                                     
  TMap = class
  public
    City: TList;                       // List of all cities
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure PlaceCities;
    procedure InitCityTable;
    function Pythagoras(City1, City2: TMaxCity): Real;
  end;

  PChromRec = ^TChromRec;
  TChromRec = record
///    Tour: array[TMaxCity] of TMaxCity; // The proposed route to travel
    Tour: Variant;                     // The proposed route to travel
    Fitness: MaxLongintType;           // = length of proposed route * 10000
    Parent: Boolean;
    Child: Boolean;
  end;

  TPopulation = class
  public
    Chrom: TList;                      // List of the population
    BestFit: TMaxPop;                  // The fittest chromosome
    Generation: Word;                  // # generations so far
    Mutations: Word;                   // # mutations so far
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure CalculateFitnesses;
    procedure SelectParents;
    procedure Crossover;
  private
    function RandomCity: TMaxCity;
  end;

implementation

uses
  SysUtils, TsmMain;

var
///  CityTable: array[TMaxCity, TMaxCity] of MaxLongintType;
  CityTable: Variant;

{----------------------- TMap -------------------------}

constructor TMap.Create;
begin
  inherited Create;
  City := TList.Create;
end;


destructor TMap.Destroy;
begin
  Clear;                               // Dispose data
  City.Free;
  inherited Destroy;
end;


procedure TMap.Clear;
var
  I: Integer;
begin
  // Remove elements from list
  for I := 0 to City.Count -1 do
    Dispose(PCityRec(City[I]));
  // Clear the list itself
  City.Clear;
end;

{
procedure TMap.PlaceCities;
// Position cities circularly on map
var
  J: TMaxCity;
  C: PCityRec;
begin
  for J := 0 to MainForm._Cities -1 do
  begin
    New(C);                       // New city
    C.X := Round( Cos(J/MainForm._Cities*2*Pi)*200 ) + 200;
    C.Y := Round( Sin(J/MainForm._Cities*2*Pi)*200 ) + 200;
    City.Add(C);                  // Add the city to list of cities
  end;
end;
}

procedure TMap.PlaceCities;
// Position cities randomly on map
var
  J: TMaxCity;
  C: PCityRec;
begin
  if MainForm.RandomizeCities then
    Randomize;
  for J := 1 to MainForm._Cities do
  begin
    New(C);                       // New city
    C.X := Random(400);
    C.Y := Random(400);
    City.Add(C);                  // Add the city to list of cities
  end;
end;


procedure TMap.InitCityTable;
var
  J, K: TMaxCity;
begin
  CityTable := VarArrayCreate([1, MainForm._Cities, 1, MainForm._Cities], varInteger);
  for J := 1 to MainForm._Cities do
    for K := 1 to MainForm._Cities do
    begin
//      CityTable[J,K] := Round(Pythagoras(J,K) * 10000);   { 4 sign. digits }
      CityTable[J,K] := (Pythagoras(J,K) * 10000);   { 4 sign. digits }
    end;
end;


function TMap.Pythagoras(City1, City2: TMaxCity): Real;
var
  DeltaX, DeltaY: Real;
  C1, C2: PCityRec;
begin
  C1 := City[City1 -1];
  C2 := City[City2 -1];
  DeltaX := C1.X - C2.X;
  DeltaY := C1.Y - C2.Y;
  Result := Sqrt( Sqr(DeltaX) + Sqr(DeltaY) );
end;

{-------------------- TPopulation ---------------------}

constructor TPopulation.Create;
// Create a random start-population
var
  I: TMaxPop;
  J: TMaxCity;
  SmartList: TRandomList;
  C: PChromRec;
begin
  inherited Create;
  Chrom := TList.Create;
  Generation := 1;                // This generations is the first
  Mutations  := 0;                // No mutations yet
  if MainForm.RandomizeInitPop then
    Randomize;
  for I := 1 to MainForm._PopSize do   // Generate chromosomes
  begin
    New(C);                       // New chromosome in population
    C.Tour := VarArrayCreate([1, MainForm._Cities], varInteger);
    SmartList := TRandomList.Create(1, MainForm._Cities);
    for J := 1 to MainForm._Cities do
      C.Tour[J] := SmartList.GetValue;  // Get a "random" city
    Chrom.Add(C);                 // Add new chrom. to list
    SmartList.Free;
  end;
end;


destructor TPopulation.Destroy;
begin
  Clear;                               // Dispose data
  Chrom.Free;
  inherited Destroy;
end;


procedure TPopulation.Clear;
var
  I: Integer;
begin
  // Remove elements from list
  for I := 0 to Chrom.Count -1 do
    Dispose(PChromRec(Chrom[I]));
  // Clear the list itself
  Chrom.Clear;
end;


function TPopulation.RandomCity: TMaxCity;
// Return a random city from the city list
begin
  Result := Random(MainForm._Cities)+1;
end;


procedure TPopulation.CalculateFitnesses;
// Calculate fitness value of each chromosome
var
  City1, City2: TMaxCity;
  I: TMaxPop;
  J: TMaxCity;
  C, Cit, C1, C2: PChromRec;
begin
  for I := 0 to MainForm._PopSize -1 do    // For each chromosome
  begin
    C := Chrom[I];
    C.Fitness := 0;          // Zero fitness-value of the chrom.
    for J := 2 to MainForm._Cities do      // For each of the cities
    begin
      Cit := Chrom[I];
      City1 := Cit.Tour[J];
      City2 := Cit.Tour[J-1];
      C.Fitness := C.Fitness + CityTable[City1, City2];
    end;
    City1 := Cit.Tour[MainForm._Cities];
    City2 := Cit.Tour[1];
    C.Fitness := C.Fitness + CityTable[City1, City2];
  end;

  // Now determine the fittest chrom. - for statistical use
  BestFit := 0;
  for I := 0 to MainForm._PopSize -1 do
  begin
    C1 := Chrom[I];
    C2 := Chrom[BestFit];
    if C1.Fitness < C2.Fitness then
      BestFit := I;               // Save number of best-fit chrom.
  end;
end;


procedure TPopulation.SelectParents;
// Select the fittest chromosomes to be parents
var
///  AntalParents: 0..MaxParents;    // For selecting the best chrom.
  AntalParents: Word;    // For selecting the best chrom.
  MinFit: MaxLongintType;         // Min. fitness-value
  Q: TMaxPop;
  I: TMaxPop;
  C: PChromRec;
begin
  AntalParents := 0;              // So far none selected
  for I := 0 to MainForm._PopSize -1 do
  begin
    C := Chrom[I];
    C.Parent := False;     // So far no parents selected
    C.Child := False;      // So far no children selected
  end;
  repeat
    MinFit := MaxLongint;
    BestFit := 0;
    for I := 0 to MainForm._PopSize -1 do   // MinFit := smallest fitness-value
    begin
      C := Chrom[I];
      if not C.Parent then        // The selected chroms. are left out
        if C.Fitness < MinFit then
        begin
          MinFit := C.Fitness;
          Q := I;                 // Save number of best-fit chrom.
        end;
    end;
    Inc(AntalParents);            // Another chrom. has been selected
    PChromRec(Chrom[Q]).Parent := True;    // Flag that the chrom. is selected
  until AntalParents = MainForm._Parents;  // Best-fit chroms. now selected
end;


procedure TPopulation.Crossover;

  procedure ChooseParents(var Nr1, Nr2: TMaxPop);
  var
    C: PChromRec;
  begin
    repeat
      Nr1 := Random(MainForm._PopSize);    // Chrom. can only be a parent..
      C := Chrom[Nr1];
    until C.Parent;                        // ..if Chrom[I].Parent = True
    repeat
      Nr2 := Random(MainForm._PopSize);    // Two different parents
      C := Chrom[Nr2];
    until (C.Parent) and (Nr1 <> Nr2);
  end;

var
  I: TMaxPop;

  procedure Inversion;
  var
///    InvertedChrom: array[TMaxCity] of TMaxCity;
    InvertedChrom: Variant;
    XO1, XO2: TMaxCity;           // Cross-over sites
    J: TMaxCity;
    C: PChromRec;
  begin
    InvertedChrom := VarArrayCreate([1, MainForm._Cities], varInteger);
    if Random(100) < MainForm._MutationRate then  // Then mutate
    begin
      repeat
        XO1 := RandomCity;
        XO2 := RandomCity;
      until XO1 < XO2;
      for J := XO1 to XO2 do
        InvertedChrom[J] := PChromRec(Chrom[I]).Tour[J];
      for J := XO1 to XO2 do
        PChromRec(Chrom[I]).Tour[J] := InvertedChrom[XO2+XO1-J];
      Inc(Mutations);
    end;
  end;

  procedure GXO(Parent1, Parent2: TMaxPop);
  var
    StartCity: TMaxCity;
    SubTour: array[1..4] of TMaxCity;
    Q, K: TMaxCity;
    S: array[1..4] of TMaxCity;
    MinFit: MaxLongintType;
    D: 1..4;
///    UsedBefore: array[TMaxCity] of Boolean;
    UsedBefore: Variant;
    J: TMaxCity;
    C: PChromRec;
  begin
    I := 0;
    while (PChromRec(Chrom[I]).Parent) or (PChromRec(Chrom[I]).Child) do
      Inc(I);
    PChromRec(Chrom[I]).Child := True;       // Ensures Chrom[I] is not overwritten

    UsedBefore := VarArrayCreate([1, MainForm._Cities], varBoolean);
    for J := 1 to MainForm._Cities do
      UsedBefore[J] := False;

    StartCity := RandomCity;
    C := Chrom[I];
    C.Tour[1] := StartCity;
    UsedBefore[StartCity] := True;

    for J := 2 to MainForm._Cities do
    begin
      K := 1;
      while PChromRec(Chrom[Parent1]).Tour[K] <> PChromRec(Chrom[I]).Tour[J-1] do
        Inc(K);
      if K > 1 then
        S[1] := K-1
      else
        S[1] := MainForm._Cities;
      if K < MainForm._Cities then
        S[2] := K+1
      else
        S[2] := 1;

      K := 1;
      while PChromRec(Chrom[Parent2]).Tour[K] <> PChromRec(Chrom[I]).Tour[J-1] do
        Inc(K);
      if K > 1 then
        S[3] := K-1
      else
        S[3] := MainForm._Cities;
      if K < MainForm._Cities then
        S[4] := K+1
      else
        S[4] := 1;

      SubTour[1] := PChromRec(Chrom[Parent1]).Tour[S[1]];
      SubTour[2] := PChromRec(Chrom[Parent1]).Tour[S[2]];
      SubTour[3] := PChromRec(Chrom[Parent2]).Tour[S[3]];
      SubTour[4] := PChromRec(Chrom[Parent2]).Tour[S[4]];

      if UsedBefore[ SubTour[1] ] and
         UsedBefore[ SubTour[2] ] and
         UsedBefore[ SubTour[3] ] and
         UsedBefore[ SubTour[4] ] then
      begin
        repeat
          C := Chrom[I];
          C.Tour[J] := RandomCity;
        until not UsedBefore[ TVarData(C.Tour[J]).VInteger ];
        UsedBefore[ TVarData(C.Tour[J]).VInteger ] := True;
      end
      else
      begin
        MinFit := MaxLongint;
        for D := 1 to 4 do      // MinFit := smallest fitness-value
          if not UsedBefore[ SubTour[D] ] then
            if CityTable[C.Tour[J-1], SubTour[D]] < MinFit then
            begin
              MinFit := CityTable[C.Tour[J-1], SubTour[D]];
              Q := D;           // Save number of best-fit chrom.
            end;

        C.Tour[J] := SubTour[Q];
        UsedBefore[ SubTour[Q] ] := True;
      end;
    end;
  end;

var
  Nr1, Nr2: TMaxPop;              // No.s of 2 currently selected parents
  Children: Word;
begin         // Crossover
  Children := 0;
  repeat
    ChooseParents(Nr1, Nr2);      // Selection of two parents
    GXO(Nr1, Nr2);                // Reproduction / mating
    Inversion;                    // Mutation
    Inc(Children);                // Another child is born by GXO
  until Children = MainForm._PopSize - MainForm._Parents;
  Inc(Generation);                // Another generation is born
end;

end.

