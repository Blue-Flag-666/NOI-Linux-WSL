@echo off

set _MSBUILD_TARGET=Build
set _MSBUILD_CONFIG=Release

:ARGS_LOOP
if (%1) == () goto :POST_ARGS_LOOP
if (%1) == (clean) (
    set _MSBUILD_TARGET=Clean,Build
)
if (%1) == (debug) (
    set _MSBUILD_CONFIG=Debug
)
shift
goto :ARGS_LOOP

:POST_ARGS_LOOP
msbuild %~dp0\DistroLauncher.sln /t:%_MSBUILD_TARGET% /m /nr:true /p:Configuration=%_MSBUILD_CONFIG%;Platform=x64 /verbosity:minimal

if (%ERRORLEVEL%) == (0) (
    echo.
    echo Created appx in %~dp0x64\%_MSBUILD_CONFIG%\DistroLauncher-Appx\
    echo.
)

:EXIT
pause