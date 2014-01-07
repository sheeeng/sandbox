:TOP

:: Get ISO date time from Windows Command Prompt.
:: http://stackoverflow.com/a/203116
@echo off
:: WMIC OS GET LocalDateTime
:: WMIC Path Win32_LocalTime Get Day,Hour,Minute,Month,Second,Year /Format:table
for /F "usebackq tokens=1,2 delims==" %%i in (`WMIC OS GET LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo Local date is [%ldt%].

ping -n 4 80.203.47.1
@echo:
GOTO TOP