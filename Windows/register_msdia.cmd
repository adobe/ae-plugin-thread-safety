::Copyright 2020 Adobe. All rights reserved.
::This file is licensed to you under the Apache License, Version 2.0 (the "License"); 
::you may not use this file except in compliance with the License. You may obtain a copy
::of the License at http://www.apache.org/licenses/LICENSE-2.0

::Unless required by applicable law or agreed to in writing, software distributed under
::the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS 
::OF ANY KIND, either express or implied. See the License for the specific language
::governing permissions and limitations under the License.

@echo off
setlocal

set _clsid=e6756135-1e65-4d17-8576-610761398c3c

:: Set this to amd64 for 64-bit Windows
set _platform=amd64

if /i "%_platform%" == "x86" (
	set _reg_root=HKCR\WOW6432Node
	set _suffix=
) else (
	if /i "%_platform%" == "amd64" (
		set _reg_root=HKCR
		set _suffix=\amd64
	) else (
		@echo Bad platform
		goto :eof
	)
)

:: Check if msdia140.dll is already registered
reg query %_reg_root%\{%_clsid%} 1>nul 2>nul
if errorlevel 1 goto not_registered

@echo msdia140.dll is already registered - no further action required

:not_registered

:: Find DIA SDK in the path
set _devenv=
for %%e in (%PATHEXT%) do @for %%i in ("devenv.exe") do (
	if NOT "%%~$PATH:i"=="" (
		set _devenv=%%~$PATH:i
	)
	if defined _devenv goto found_devenv
)
if not defined _devenv goto run_vcvars32
:found_devenv

:: Extract the base path
for /f "tokens=1-4 delims=\" %%i in ("%_devenv%") do set _msdia_root=%%i\%%j\%%k\%%l

:: Now find the DIA SDK
for /f "delims=" %%i in ('dir /s /b /ad "%_msdia_root%\DIA SDK" ^| findstr bin') do (
	set _msdia_path=%%i%_suffix%
	goto got_bin_path
)
:got_bin_path
set _msdia=%_msdia_path%\msdia140.dll

::Make sure the file exists
if not exist "%_msdia%" goto dll_not_found

:: Now register msdia140.dll
regsvr32 /s "%_msdia%"
if errorlevel 1 goto error_registering

@echo Registered %_msdia%

goto :eof

:run_vcvars32
echo Unable to find devenv.exe in the path. Please run vcvars32.cmd and try again
goto :eof

:dll_not_found
@echo Could not find msdia140.dll in the expected location. Please contact anlewis@adobe.com
goto :eof

:error_registering
@echo An error occurred registering msdia140.dll. Please run this script in an elevated prompt.
goto :eof
