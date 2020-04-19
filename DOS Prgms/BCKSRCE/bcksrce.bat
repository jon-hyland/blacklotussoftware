@echo off
echo Backing up all source files...
xcopy c:\tp\bin\*.pas c:\personal\prgms\bcksrce\tp      /y  > nul
xcopy c:\bc5\bin\*.cpp c:\personal\prgms\bcksrce\bc5    /y  > nul
xcopy c:\bc5\bin\*.c c:\personal\prgms\bcksrce\bc5      /y  > nul
xcopy c:\bc5\bin\*.h c:\personal\prgms\bcksrce\bc5      /y  > nul
xcopy c:\bc5\jons\*.cpp c:\personal\prgms\bcksrce\bc5   /y  > nul
xcopy c:\bc5\jons\*.c c:\personal\prgms\bcksrce\bc5     /y  > nul
xcopy c:\bc5\jons\*.h c:\personal\prgms\bcksrce\bc5     /y  > nul
xcopy c:\vb5\*.vbw c:\personal\prgms\bcksrce\vb5        /y  > nul
xcopy c:\vb5\*.vbp c:\personal\prgms\bcksrce\vb5        /y  > nul
xcopy c:\vb5\*.frm c:\personal\prgms\bcksrce\vb5        /y  > nul
xcopy c:\vb5\jons\*.vbw c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\vb5\jons\*.vbp c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\vb5\jons\*.frm c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\vb5\slide2\*.vbw c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\vb5\slide2\*.vbp c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\vb5\slide2\*.frm c:\personal\prgms\bcksrce\vb5   /y  > nul
xcopy c:\tc\*.c c:\personal\prgms\bcksrce\tc            /y  > nul
echo Source files copied to C:\PERSONAL\PRGMS\BCKSRCE\dir.
echo.


