@echo off
SET THEFILE=C:\Users\lenovo\Desktop\ARCHIVOS DE PRACTICOS DE PROGRAMAN 1\APP3-2026-2-INF120\project1.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o "C:\Users\lenovo\Desktop\ARCHIVOS DE PRACTICOS DE PROGRAMAN 1\APP3-2026-2-INF120\project1.exe" "C:\Users\lenovo\Desktop\ARCHIVOS DE PRACTICOS DE PROGRAMAN 1\APP3-2026-2-INF120\link9080.res"
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
