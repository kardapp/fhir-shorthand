@ECHO OFF
SET publisher_jar=publisher.jar
REM Resolve the IG root relative to this script, not the caller's current directory.
SET "ig_root=%~dp0"
IF "%ig_root:~-1%"=="\" SET "ig_root=%ig_root:~0,-1%"
SET "input_cache_path=%ig_root%\input-cache"
 
PUSHD "%ig_root%" >NUL
 
ECHO Checking internet connection...
powershell -Command "try { $r=[System.Net.WebRequest]::Create('https://tx.fhir.org/r4/metadata'); $r.Timeout=4000; $r.GetResponse().Close(); exit 0 } catch { exit 1 }"
IF %ERRORLEVEL% EQU 0 GOTO isonline
ECHO We're offline...
SET txoption=-tx n/a
GOTO igpublish
 
:isonline
ECHO We're online
SET txoption=
 
:igpublish
 
SET JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
 
IF EXIST "%input_cache_path%\%publisher_jar%" (
    JAVA -jar "%input_cache_path%\%publisher_jar%" -ig "%ig_root%" %txoption% %*
) ELSE If exist "%ig_root%\%publisher_jar%" (
    JAVA -jar "%ig_root%\%publisher_jar%" -ig "%ig_root%" %txoption% %*
) ELSE (
    ECHO IG Publisher NOT FOUND in input-cache or parent folder.  Please run _updatePublisher.  Aborting...
)
 
POPD >NUL
PAUSE
 