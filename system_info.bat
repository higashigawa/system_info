@echo off
setlocal

rem �z�X�g���擾
for /F %%i in ('hostname') DO @SET host_name=%%i


rem �t�H���_�̑��݊m�F
set Folder=%~dp0\%host_name%
if not exist "%Folder%\" (
    rem �����ꍇ�́A�t�H���_�쐬
    md %Folder%
)

rem �V�X�e�����擾
systeminfo > %Folder%\_systeminfo.txt

rem ���W�X�g������v���O�����ꗗ�擾
for /f "tokens=2,*" %%I in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

for /f "tokens=2,*" %%I in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

rem 32bit �̏ꍇ�͈ȉ����R�����g�A�E�g
for /f "tokens=2,*" %%I in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| find "DisplayName"') do (
    echo %%J >>%Folder%\app.txt
)

echo.
echo �擾���܂����B
echo %Folder% ���m�F���Ă��������B
echo.
echo �����L�[�������Ă��������B
echo.
pause >nul
 
endlocal
exit
