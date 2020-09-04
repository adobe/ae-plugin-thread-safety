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
set _reg_root=HKCR

:: Check if msdia140.dll is already registered
reg query %_reg_root%\{%_clsid%} 1>nul 2>nul
if errorlevel 1 goto not_registered

@echo msdia140.dll is already registered - no further action required
goto :eof

:not_registered

:: Find devenv.exe in the path
set _devenv=
for %%i in ("devenv.exe") do (
	if NOT "%%~$PATH:i"=="" (
		set _devenv=%%~$PATH:i
	)
	if defined _devenv goto found_devenv
)
if not defined _devenv goto run_vcvars64
:found_devenv

:: Extract the base path
for /f "tokens=1-4 delims=\" %%i in ("%_devenv%") do set _msdia_root=%%i\%%j\%%k\%%l

:: Now find the DIA SDK
set _vs_sku=
if not exist "%_msdia_root%\DIA SDK" (
	for %%e in (Community,Professional,Enterprise) do (
		if exist "%_msdia_root%\%%e\DIA SDK" (
			set _vs_sku=\%%e
			goto got_suffix
		)
	)
	goto dll_not_found
)
:got_suffix

set _msdia=
for /f "delims=" %%i in ('dir /s /b "%_msdia_root%%_vs_sku%\DIA SDK\msdia140.dll" ^| findstr -i amd64') do (
	set _msdia=%%i
	goto got_bin_path
)
if "%_msdia" == "" goto dll_not_found
:got_bin_path

:: Now register msdia140.dll
regsvr32 /s "%_msdia%"
if errorlevel 1 goto error_registering

@echo Registered %_msdia%

goto :eof

:run_vcvars64
echo Unable to find devenv.exe in the path. Please run vcvars64.cmd and try again
goto :eof

:dll_not_found
@echo Could not find msdia140.dll in the expected location. Please contact anlewis@adobe.com
goto :eof

:error_registering
@echo An error occurred registering msdia140.dll. Please run this script in an elevated prompt.
goto :eof