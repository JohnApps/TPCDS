setlocal
set /a num = %1%
set filename = %2%

:loop

set /a num = %num% +1
if %num% equ 10 goto endit
echo ---%num%----%2%_bloggs

goto loop

:endit
echo %num%