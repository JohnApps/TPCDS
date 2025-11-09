rem start-readers_tpcds_16.bat
rem
rem %1 is the type, i.e., HINT or NONE
rem %2 is the startung number for the log files 
rem
echo off
setlocal

rem
rem
set motherduck_logging=
set /a num = %2%
goto %1

:HINT
set /a rnumber=%random%

rem 1
set /a number=%random%
set /a num = %num% +1
start "mint%num%1" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T1__%1%.log

rem 2 01-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%2" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T2__%1%.log

rem 3 02-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%3" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T3_%1%.log

rem 4 03 - 16
set /a number=%random%
set /a num = %num% +1
start "mint%num%4" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T4_%1%.log

rem 1 05-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T6_%1%.log

rem 2 06-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T7_%1%.log

rem 3 07-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 4 8-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T6_%1%.log

rem 1 09-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T7_%1%.log

rem 2 10-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 3 11-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T9_%1%.log

rem 4 12 - 16
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T10_%1%.log

rem 1 13-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T7_%1%.log

rem 2 14-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 3 15-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T9_%1%.log

rem 4 16-16
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds_32?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T10_%1%.log

goto end

REM
REM ---------------- begin of no session hint ----------------------------------
REM
:NONE
echo starting run with %1%
set /a num = %p2%

rem 1
set /a number=%random%
set /a num = %num% +1
start "mint%num%1" cmd /c %py%  tpcds_read_th.py md:tpcds_128  	 ^> logs\TPC%NUM%_T1_%1%.log

rem 2
set /a number=%random%
set /a num = %num% +1
start "mint%num%2" cmd /c %py%  tpcds_read_th.py md:tpcds_128  	 ^> logs\TPC%NUM%_T2_%1%.log

rem 3
set /a number=%random%
set /a num = %num% +1
start "mint%num%3" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T3_%1%.log

rem 4
set /a number=%random%
set /a num = %num% +1
start "mint%num%4" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T4_%1%.log

rem 5
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T5_%1%.log

rem6
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds_128 	 ^> logs\TPC%NUM%_T6_%1%.log

rem 7
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T7_%1%.log

rem 8
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T8_%1%.log

rem 9
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds_128  	 ^> logs\TPC%NUM%_T9_%1%.log

rem 10
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T10_%1%.log

rem 11
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds_128 	 ^> logs\TPC%NUM%_T6_%1%.log

rem 12
set /a
number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T7_%1%.log

rem 13
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T8_%1%.log

rem 14
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds_128  	 ^> logs\TPC%NUM%_T9_%1%.log

rem 15
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T10_%1%.log

rem 16
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_128	 ^> logs\TPC%NUM%_T7_%1%.log

goto end

:end
echo all %num% finished
endlocal