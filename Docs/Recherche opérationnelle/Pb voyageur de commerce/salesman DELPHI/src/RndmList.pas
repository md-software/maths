unit RndmList;

interface

uses
  Classes, SysUtils;

type
  EListEmpty = class(EListError)
    // Raised when list of values is empty
  end;

  TRandomList = class(TList)
  public
    constructor Create(Min, Max: Word);
    destructor Destroy; override;
    function GetValue: Word;
    function DeleteValue(X: Word): Boolean;
  end;

implementation

type
  RandomNr = ^Word;

{-------------------- TRandomList ----------------------}

constructor TRandomList.Create(Min, Max: Word);
var
  P: RandomNr;
  I: Word;
begin
  inherited Create;
  for I := Min to Max do     // Insert records
  begin
    New(P);
    P^ := I;
    Add(P);
  end;
end;


destructor TRandomList.Destroy;
var
  I: Integer;
begin
  // We must clear the contents of the list
  for I := 0 to Count -1 do
    Dispose(Items[I]);
  // The pointers in the list will be destroyed automatically
  inherited Destroy;
end;


function TRandomList.GetValue: Word;
var
  Selected: RandomNr;
begin
  if Count = 0 then          // Generate exception
    EListEmpty.Create('There are no more values')
  else
  begin
    Selected := Items[Random(Count)];
    Result := Selected^;
    Remove(Selected);
  end;
end;


function TRandomList.DeleteValue(X: Word): Boolean;
var
  I: Word;
  Found: Boolean;
begin
  I := 0;
  Found := False;
  while (not Found) and (I < Count) do
    if (Word(Items[I]^) = X) then
      Found := True
    else
      Inc(I);

  Result := Found;
  if Found then
    Delete(I);
end;

end.

