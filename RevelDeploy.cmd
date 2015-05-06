@ECHO off

IF DEFINED WEBROOT_PATH (
    ECHO WEBROOT_PATH is %WEBROOT_PATH%
    GOTO :SETUP
)

ECHO set WEBROOT_PATH to D:\home\site\wwwroot
SET WEBROOT_PATH=D:\home\site\wwwroot

:SETUP
SET GOROOT=D:\Program Files\go\1.4.2
SET GOPATH=%WEBROOT_PATH%\gopath
SET GOEXE="%GOROOT%\bin\go.exe"
SET FOLDERNAME=azureapp
SET GOAZUREAPP=%WEBROOT_PATH%\gopath\src\%FOLDERNAME%

IF EXIST %GOPATH% (
    ECHO %GOPATH% already exist

    ECHO Removing %GOAZUREAPP%
    RMDIR /S /Q %GOAZUREAPP%
) else (
    ECHO creating %GOPATH%\bin
    MKDIR "%GOPATH%\bin"
    ECHO creating %GOPATH%\pkg
    MKDIR "%GOPATH%\pkg"
    ECHO creating %GOPATH%\src
    MKDIR "%GOPATH%\src"
)

GOEXE get github.com/revel/revel
GOEXE get github.com/revel/cmd/revel
SET REVELEXE="%GOPATH%\bin\revel.exe"

ECHO creating %GOAZUREAPP%
MKDIR %GOAZUREAPP%

ECHO --------------------------------------------
ECHO GOROOT: %GOROOT%
ECHO GOEXE: %GOEXE%
ECHO GOPATH: %GOPATH%
ECHO GOAZUREAPP: %GOAZUREAPP%
ECHO REVELEXE: %REVELEXE%
ECHO --------------------------------------------
ECHO copying source code to %GOAZUREAPP%
ROBOCOPY "%DEPLOYMENT_SOURCE%" "%GOAZUREAPP%" /E /NFL /NDL /NP /XD .git .hg /XF .deployment deploy.cmd

ECHO Building ...
%REVELEXE% "%GOAZUREAPP%" "%WEBROOT_PATH%\azureapp"

ECHO cleaning up ...
CD %WEBROOT_PATH%
RMDIR /S /Q %GOPATH%

ECHO DONE!
