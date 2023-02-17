@echo off
echo ===================================================
echo Lumanagi Fantasy Project Setup Script
echo ===================================================
echo.

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Git is not installed or not in PATH.
    echo Please install Git from https://git-scm.com/downloads
    echo.
    pause
    exit /b 1
)

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed or not in PATH.
    echo Please install Node.js from https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo Checking Node.js version...
for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo Current Node.js version: %NODE_VERSION%

REM Check if Yarn is installed
where yarn >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Yarn is not installed or not in PATH.
    echo Installing Yarn...
    call npm install -g yarn
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Yarn.
        echo Please install Yarn manually from https://yarnpkg.com/
        echo.
        pause
        exit /b 1
    )
)

echo.
echo ===================================================
echo Setting up environment...
echo ===================================================
echo.

REM Navigate to project directory
cd lumanagi-fantasy

REM Create .env file
echo Creating .env file...
(
echo REACT_APP_INFURA_KEY=9aa3d95b3bc440fa88ea12eaa4456161
echo REACT_APP_ALCHEMY_KEY=demo
) > .env

echo.
echo ===================================================
echo Installing dependencies...
echo ===================================================
echo.

REM Install dependencies
call yarn
if %ERRORLEVEL% neq 0 (
    echo Failed to install dependencies.
    pause
    exit /b 1
)

echo.
echo ===================================================
echo Setup complete!
echo ===================================================
echo.
echo To start the development server, run:
echo yarn start
echo.
echo Make sure to:
echo 1. Have MetaMask installed
echo 2. Connect to the Mumbai testnet
echo 3. Get some test MATIC from the faucet
echo.
echo Mumbai Testnet Details:
echo - Network Name: Mumbai Testnet
echo - RPC URL: https://polygon-mumbai.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161
echo - Chain ID: 80001
echo - Currency Symbol: MATIC
echo - Block Explorer URL: https://mumbai.polygonscan.com
echo.
echo Mumbai Faucet: https://faucet.polygon.technology/
echo.
set /p START_NOW=Do you want to start the development server now? (y/n): 
if /i "%START_NOW%"=="y" (
    echo Starting development server...
    call yarn start
) else (
    echo You can start the server later by running 'yarn start' in the lumanagi-fantasy directory.
)

pause 