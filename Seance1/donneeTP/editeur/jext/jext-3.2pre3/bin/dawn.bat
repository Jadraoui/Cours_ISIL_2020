@echo off

REM ==================================
REM Batch for starting Dawn on Windows
REM ==================================

java -classpath "%CLASSPATH%";..\lib\dawn.jar;..\lib\jext.jar org.jext.dawn.Dawn %1 %2
