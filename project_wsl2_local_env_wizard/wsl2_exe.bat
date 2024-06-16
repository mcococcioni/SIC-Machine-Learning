@ECHO OFF
SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%config\wsl2_ps_executable.ps1
PowerShell -NoExit -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";
