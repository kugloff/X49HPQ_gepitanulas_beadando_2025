@echo off
chcp 65001

set /p "input=Szeretnél virtuális környezetet létrehozni? y/n: "

if /i "%input%"=="y" (
    if not exist "venv\Scripts\activate.bat" (
        echo Virtuális környezet nem található. Létrehozás...
        py -3 -m venv venv
        if errorlevel 1 (
            echo ERROR: Nem sikerült létrehozni a virtuális környezetet.
            pause
            exit /b 1
        )
    ) else (
        echo Már létezik a virtuális környezet.
    )

    call venv\Scripts\activate.bat

    echo Ellenőrzés: requirements.txt csomagok telepítve vannak-e...
    pip install -r requirements.txt

    echo.
    echo A virtuális környezet elkészült és a csomagok telepítve.
)

echo.
pause