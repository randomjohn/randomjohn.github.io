REM set R version
set RVERSION=3.4.1patched

REM you should not need to edit
set RBIN=%PROGRAMFILES%\R\R-%RVERSION%\bin
set RSCRIPT="%RBIN%\Rscript.exe"
set BUILDSCR="%USERPROFILE%\OneDrive\Documents\Github\randomjohn.github.io\Rmd2md.R"

%RSCRIPT% %BUILDSCR%
