cd C:\Users\Public\scripts

for %%f in (*.bat) do (
    call "%%f" >nul 2>&1
)
