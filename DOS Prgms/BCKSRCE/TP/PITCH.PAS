program PitchShifter;

uses
 Crt, Std;

const
 VerNum = '1.0';
 StartPitch = 220;
 StartDelay = 15;

var
 Key   : char;
 x, y  : integer;
 Pitch : integer;
 Delay : integer;

procedure Init;
 begin
  MouseOn;
  Pitch := StartPitch;
  Delay := StartDelay;
 end;

begin
 BlackLotusIntro;
 Init;
end.

