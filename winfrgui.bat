@echo off
cls
echo =========================================
echo Windows File Recovery [Graphic User Interface [not really]]
echo Copyright [c] Microsoft Corporation. All rights reserved
echo Made by: Diep Anh Quan 
echo Current version supported: 0.0.11761.0
echo Current version: 0.1 Alpha
echo ------------------------------------------
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
echo 6. Are you sure want to continue, please check all of you option before continue?
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
if %smode% == 1 (
	set smode=3
) else (
	set smode=2
)
goto confirm

:start
if %smode% == 1 (
	if %mode% == 1 (
	winfr %drive%: %end_path% /r %filter%
	pause	
	)
	if %mode% == 2 (
	echo An fatal error has detected, error detail:"INVALID_OPTION_COMBINATIONS"
	pause
	)
	if %mode% == 3 (
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
	winfr %drive%: %end_path% /r 
	pause
	)
	if %mode% == 2 (
	winfr %drive%: %end_path% /x
	pause	
	)
	if %mode% == 3 (
	winfr %drive%: %end_path%
	pause	
	)
)

