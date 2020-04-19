program SetUserWallPaper_2;

uses
 Crt, Std, Dos;

const
 VerNum = '2.0';

var
 OnFile    : text;
 BatFile   : text;
 FName1    : string;
 FName2    : string;
 UsrName   : string;

procedure Init;
 begin
  BackGround_I(true);
  assign(OnFile, 'C:\WINDOWS\SYSTEM\USER.ON');
  assign(BatFile, 'C:\WINDOWS\LOGIN\_SETWALL.BAT');
 end;

begin
 BlackLotusIntro;
 Init;
 if paramstr(1) <> '' then
  FName1 := paramstr(1)
 else
  begin
   DrawWindow(24,10,55,13,1,'Filename');
   gotoxy(26,11);
   write('Enter full path/name of BMP:');
   FName1 := GetString(26,12,28,unlock,visable,upper);
  end;
 if FName1 = '' then FName1 := '#ESC#';
 if (FName1 = '#ESC#') or (not Exist(FName1)) then
  begin
   DrawWindow(30,14,50,17,4,'Error');
   textcolor(yellow);
   gotoxy(32,15);
   write('Path not correct.');
   gotoxy(32,16);
   write('Halting program.');
   Cursor;
   Pause;
   FadeOut;
   Halt(1);
  end;
 reset(OnFile);
 read(OnFile, UsrName);
 close(OnFile);
 UsrName := DeScramble(UsrName);
 FName2 := 'C:\WINDOWS\LOGIN\' + UsrName + '.BMP';
 rewrite(BatFile);
 writeln(BatFile, '@echo off');
 writeln(BatFile, 'if exist c:\windows\login\last.bmp del c:\windows\login\last.bmp');
 writeln(BatFile, 'copy ', FName2, ' c:\windows\login\last.bmp');
 writeln(BatFile, 'if exist ', FName2, ' del ', FName2);
 writeln(BatFile, 'copy ', FName1, ' ', FName2);
 close(BatFile);
 BackGround_I(false);
 DrawWindow(26,10,52,16,4,'Info');
 textcolor(yellow);
 gotoxy(28,11);
 write('Specified file saved as');
 gotoxy(28,12);
 write(UsrName, '''s wallpaper.');
 textcolor(white);
 gotoxy(28,14);
 write('Remember to restart for');
 gotoxy(28,15);
 write('changes to take place.');
 Cursor;
 Pause;
 FadeOut;
end.