@echo off
REM Script to change EOL to Windows format for all .csv files in the current directory

REM Loop through all .csv files in the current directory
for %%f in (*.csv) do (
    echo Processing file: %%f
    REM Create a temporary file to hold the converted content
    more /P "%%f" > "%%~nf_converted.csv"
    
    REM Replace the original file with the converted one
    move /Y "%%~nf_converted.csv" "%%f"
    echo Done processing: %%f
)

echo All files processed.