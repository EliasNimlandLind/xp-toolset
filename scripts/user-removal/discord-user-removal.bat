@echo off

taskkill /IM discord.exe /F >nul 2>&1

for /d %%u in (C:\Users\*) do (
    if exist "%%u\AppData\Roaming\discord\Local Storage\leveldb" (
        RMDIR /S /Q "%%u\AppData\Roaming\discord\Local Storage\leveldb"
    )
)