@echo off 
set /p var= <build_number 
set /a var= %var%+1 
echo %var% >build_number
echo %var%
