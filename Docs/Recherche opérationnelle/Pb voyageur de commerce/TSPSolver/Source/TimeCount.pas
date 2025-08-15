unit TimeCount;

interface

uses
  Windows, SysUtils, Classes;

type
 { TCounter }
 TCounter = class(TComponent)
 private
   FFreq        : TLargeInteger;
   FStart       : TLargeInteger;
   function  GetElapsedSecs:string;
 public
   property ElapsedSecs : string read GetElapsedSecs;
   procedure StartTimeCount;
 end;

implementation

{---------------------------------------------------------------------------------}
procedure TCounter.StartTimeCount;
begin
  QueryPerformanceFrequency(FFreq);
  QueryPerformanceCounter(FStart);
end;
{---------------------------------------------------------------------------------}
function  TCounter.GetElapsedSecs:string;
var
 Stop : TLargeInteger;
begin
  QueryPerformanceCounter(Stop);
  Result := Format('%g', [(Stop - FStart)/ FFreq]);
end;

end.