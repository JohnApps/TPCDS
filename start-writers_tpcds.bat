rem start-writers_tpcds.bat
echo off
setlocal
rem
set motherduck_logging=

set /a num = 0

set /a num = %num% +1
set /a number=%random%
start "mint%num1" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%2" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%3" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%4" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%4" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%4" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%4" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%4" cmd /c %py% tpcds_update_store_sales.PY md:tpcds_64   ^> logs\SS_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%5" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%6" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%7" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%8" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%8" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%8" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%8" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

set /a num = %num% +1
set /a number=%random%
start "mint%num%8" cmd /c %py% tpcds_update_store_returns.PY md:tpcds_64  ^> logs\SR_%num%_%number%.log

echo %num% sessions started at %time%
:end
endlocal