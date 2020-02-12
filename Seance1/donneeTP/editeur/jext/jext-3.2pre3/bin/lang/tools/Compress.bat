@echo off
REM Note: on DOS REM is for comments

REM Same that on Unix
cd new_tr
REM "Jarring" files
jar cvMf Italiano_pack.jar *
REM Same as mv: this command moves the file "Italiano_pack.jar"
REM to the upper directory without asking confirmation to substitute the
REM existing one (due to /Y)
move /Y Italiano_pack.jar ..

