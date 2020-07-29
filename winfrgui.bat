::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCaDJHSdtGAxPBhcDE/CH2S3C7QS7Kjd5uaCnloUWuQtf5rSlLGWJYA=
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
echo ===========================================================
echo Windows File Recovery [GUI plug-in]
echo Copyright [c] Microsoft Corporation. All rights reserved
echo Made by: Diep Anh Quan 
echo Current version supported: 0.0.11761.0
echo Current version: 0.2 Alpha
echo [NOTE: This is only a plug-in to help you use the winfr tool easier. I will discontinue this after Microsoft introduce an gui version of winfr]
echo ------------------------------------------------------------
echo 1. What drive do you want to recover [enter a valid drive letter, ex:C]
set /p drive=">"
echo 2. What is the destination folder that you want all of your recovered file placed [enter a valid drive letter and a valid path, ex:"C:\Users\%username%\Desktop", with quotes]
set /p end_path=">"
echo 3. What kind of mode do you want to use?
echo [A. Segment mode [NTFS only, recovery using file record segments]]
echo [B. Signature mode [recovery using file headers]]
echo [C. Default mode]
choice /c:abc
if %errorLevel% == 1 (
	set mode=1
)
if %errorLevel% == 2 (
	set mode=2
	goto :extra
)
if %errorLevel% == 3 (
	set mode=3
)
echo 4. Do you want to do a filter search [default or segment mode only]?
choice /c:yn
if %errorLevel% == 1 (
	goto filter
) else (
	set smode=0
)
:extra
echo 5. Do you want to do a specific extension groups recover [signature mode only, comma separated]?
choice /c:yn
if %errorLevel% == 1 (
	goto extension
) else (
	set smode=0
)
:confirm
echo 6. Are you sure want to continue, please check all of your option before continue?
echo Generating report, please wait...
echo ------------------------------------------------------------
echo Source Drive: %drive%:
echo Destination folder: %end_path%
if %mode% == 1 (
	echo Mode: Segment mode
)
if %mode% == 2 (
	echo Mode: Signature mode
)
if %mode% == 3 (
	echo Mode: Default mode
)
if %smode% == 1 (
	echo Filter included: %filter%
)
if %smode% == 2 (
	echo Extenstion groups included: %extension%
)
echo Report generated at: %date% at %time%
echo ------------------------------------------------------------
choice /c:yn
if %errorLevel% == 1 (
	goto start
) else (
	exit
)

:filter
echo Please enter a valid filter format [ex: "/n .png /n .txt", with no quotes] [Quit the program to cancel]
echo "/n <filter>  - Filter search [default or segment mode, wildcards allowed, trailing \ for folder]"
set /p filter=">"
set smode=1
goto confirm

:extension
echo Please enter a valid extension groups [ex: "PDF,PNG,JPEG", with no quotes] [Quit the program to cancel]
echo "/y:<type(s)> - Recover specific extension groups [signature mode only, comma separated]"
set /p extension=">"
	set smode=2
goto confirm

:start
if %smode% == 1 (
	if %mode% == 1 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path% /r %filter%
	pause	
	)
	if %mode% == 2 (
	echo An fatal error has detected, error detail:"INVALID_OPTION_COMBINATIONS"
	pause
	)
	if %mode% == 3 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path% %filter%
	pause		
	)
)
if %smode% == 2 (
	if %mode% == 1 (
	echo An fatal error has detected, error detail:"INVALID_OPTION_COMBINATIONS"
	pause	
	)
	if %mode% == 2 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path% /x /y:%extension%
	pause		
	)
	if %mode% == 3 (
	echo An fatal error has detected, error detail:"INVALID_OPTION_COMBINATIONS"
	pause	
	)
)
if %smode% == 0 (
	if %mode% == 1 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path% /r 
	pause
	)
	if %mode% == 2 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path% /x
	pause	
	)
	if %mode% == 3 (
	echo Executing winfr, please wait...
	winfr %drive%: %end_path%
	pause	
	)
)

