@echo off
setlocal

rem ホスト名取得
for /F %%i in ('hostname') DO @SET host_name=%%i


rem フォルダの存在確認
set Folder=%~dp0\%host_name%
if not exist "%Folder%\" (
    rem 無い場合は、フォルダ作成
    md %Folder%
)

rem システム情報取得
systeminfo > %Folder%\_systeminfo.txt

rem レジストリからプログラム一覧取得
for /f "tokens=2,*" %%I in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

for /f "tokens=2,*" %%I in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

rem 32bit の場合は以下をコメントアウト
for /f "tokens=2,*" %%I in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

echo.
echo 取得しました。
echo %Folder% を確認してください。
echo.
echo 何かキーを押してください。
echo.
pause >nul
 
endlocal
exit
