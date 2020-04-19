{Put this program in the directory of the application you wish to
 password protect. }

program StandardPassword;

uses
 Crt, Std;

var
 PFile : file of string;
 Pass  : string;


procedure DisplayHelp;
 begin
  writeln('Basic Program Password Protection  -  v1.0);
  writeln('(c) 1997  Black Lotus Productions');
  writeln('command line syntax : ');
  writeln(' /h : what you see');
  writeln(' /c : create new password setup');
  wrietln(' /d : delete setup

procedure Init;
 begin
  if InParamStr(StrLower('/h')) then DisplayHelp;
  if InParamStr(StrLower('/c')) then CreateNewSetup;
 end;

