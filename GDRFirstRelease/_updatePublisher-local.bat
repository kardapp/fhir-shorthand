@ECHO OFF
SETLOCAL

SET dlurl=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
SET publisher_jar=publisher.jar
SET input_cache_path=%CD%\input-cache\
SET skipPrompts=false

IF "%~1"=="/f" SET skipPrompts=y

ECHO.
ECHO Checking internet connection...
powershell -Command "try { $r=[System.Net.WebRequest]::Create('https://tx.fhir.org/r4/metadata'); $r.Timeout=4000; $r.GetResponse().Close(); exit 0 } catch { exit 1 }"
IF %ERRORLEVEL% EQU 0 GOTO isonline
ECHO We're offline, nothing to do...
GOTO end

:isonline
ECHO We're online

FOR %%x IN ("%CD%") DO SET upper_path=%%~dpx

ECHO.
IF NOT EXIST "%input_cache_path%%publisher_jar%" (
	IF NOT EXIST "%upper_path%%publisher_jar%" (
		SET jarlocation=%input_cache_path%%publisher_jar%
		SET jarlocationname=Input Cache
		ECHO IG Publisher is not yet in input-cache or parent folder.
		GOTO create
	) ELSE (
		ECHO IG Publisher FOUND in parent folder
		SET jarlocation=%upper_path%%publisher_jar%
		SET jarlocationname=Parent folder
		GOTO upgrade
	)
) ELSE (
	ECHO IG Publisher FOUND in input-cache
	SET jarlocation=%input_cache_path%%publisher_jar%
	SET jarlocationname=Input Cache
	GOTO upgrade
)

:create
IF "%skipPrompts%"=="y" (
	SET create=Y
) ELSE (
	ECHO Will place publisher jar here: %input_cache_path%%publisher_jar%
	SET /p create="Ok? (Y/N) "
)
IF /I "%create%"=="Y" (
	ECHO Will place publisher jar here: %input_cache_path%%publisher_jar%
	MKDIR "%input_cache_path%" 2> NUL
	GOTO download
)
GOTO done

:upgrade
IF "%skipPrompts%"=="y" (
	SET overwrite=Y
) ELSE (
	SET /p overwrite="Overwrite %jarlocation%? (Y/N) "
)

IF /I "%overwrite%"=="Y" (
	GOTO download
)
GOTO done

:download
ECHO Downloading most recent publisher to %jarlocationname% - it's ~100 MB, so this may take a bit
CALL POWERSHELL -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%dlurl%' -OutFile '%jarlocation%'"
IF %ERRORLEVEL% NEQ 0 (
	ECHO Download failed with error code %ERRORLEVEL%.
	GOTO end
)

:done
ECHO.
ECHO Publisher update finished.
ECHO Scripts were NOT updated.

:end
ENDLOCAL
