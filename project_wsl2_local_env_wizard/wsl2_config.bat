@ECHO OFF
SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%config\wsl2_ps_config.ps1
PowerShell -noExit -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";
