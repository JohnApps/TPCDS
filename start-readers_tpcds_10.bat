rem start-readers_tpcds_10.bat
rem
rem %1 is the type, i.e., HINT or NONE
rem %2 is the startung number for the log files 
rem
echo off
setlocal

rem
set motherduck_logging=
set /a num = %p2%
goto %1

:HINT
set /a rnumber=%random%

rem 1
set /a number=%random%
set /a num = %num% +1
start "mint%num%1" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T1__%1%.log

rem 2
set /a num = %num% +1
start "mint%num%2" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T2__%1%.log

rem 3
set /a num = %num% +1
start "mint%num%3" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T3_%1%.log

rem 4
set /a num = %num% +1
start "mint%num%4" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T4_%1%.log

rem 5
rem set /a num = %num% +1
rem start "mint%num%5" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T5_%1%.log

rem 6
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number% ^> logs\TPC%NUM%_T6_%1%.log

rem 7
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T7_%1%.log

rem 8
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 9
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 10
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

rem 11
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds_64?dbinstance_inactivity_ttl=20,session_hint=%number%  ^> logs\TPC%NUM%_T8_%1%.log

goto end

REM
REM ---------------- begin of no session hint ----------------------------------
REM
:NONE
echo starting run with %1%


set /a rnumber=%random%

rem 1
set /a number=%random%
set /a num = %num% +1
start "mint%num%1" cmd /c %py%  tpcds_read_th.py md:tpcds  	 ^> logs\TPC%NUM%_T1_%1%.log

rem 2
set /a number=%random%
set /a num = %num% +1
start "mint%num%2" cmd /c %py%  tpcds_read_th.py md:tpcds  	 ^> logs\TPC%NUM%_T2.log

rem 
set /a number=%random%
set /a num = %num% +1
start "mint%num%3" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T3.log

rem 4
set /a number=%random%
set /a num = %num% +1
start "mint%num%4" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T4_%1%.log

rem 5
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T5_%1%.log

rem6
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds 	 ^> logs\TPC%NUM%_T6_%1%.log

rem 7
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T7_%1%.log

rem 8
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T8_%1%.log

rem 9
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds  	 ^> logs\TPC%NUM%_T9_%1%.log

rem 10
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T10_%1%.log

rem 11
set /a number=%random%
set /a num = %num% +1
start "mint%num%5" cmd /c %py%  tpcds_read_th.py  md:tpcds 	 ^> logs\TPC%NUM%_T6_%1%.log

rem 12
set /a
number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T7_%1%.log

rem 13
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T8_%1%.log

rem 14
set /a number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds  	 ^> logs\TPC%NUM%_T9_%1%.log

rem 15
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T10_%1%.log

rem 16
set /a number=%random%
set /a num = %num% +1
start "mint%num%6" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T7_%1%.log

rem 17
set /a number=%random%
set /a num = %num% +1
start "mint%num%7" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T8_%1%.log

rem 18
set /a
 number=%random%
set /a num = %num% +1
start "mint%num%8" cmd /c %py%  tpcds_read_th.py  md:tpcds  	 ^> logs\TPC%NUM%_T9_%1%.log

rem 19
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T10_%1%.log

rem 20
set /a number=%random%
set /a num = %num% +1
start "mint%num%9" cmd /c %py%  tpcds_read_th.py md:tpcds	 ^> logs\TPC%NUM%_T11_%1%.log

goto end

:end
echo all %num% finished
endlocal