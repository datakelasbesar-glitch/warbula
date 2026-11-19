@echo off
setlocal
cd /d "%~dp0"
start "WARBULA localhost" /min "%ComSpec%" /c "cd /d ""%~dp0"" ^&^& py -m http.server 8000 --bind 127.0.0.1"
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:8000/"
endlocal
