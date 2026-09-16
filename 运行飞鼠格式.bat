@echo off
setlocal EnableExtensions
chcp 65001 >nul
title 飞鼠格式
cd /d "%~dp0"

set "PATH=C:\Program Files\nodejs;%PATH%"

where node >nul 2>&1
if errorlevel 1 (
  echo 未找到 Node.js。
  echo 请先安装 Node.js 18 或更高版本：https://nodejs.org/
  echo.
  pause
  exit /b 1
)

for /f "tokens=1 delims=v" %%v in ('node -v') do set "NODE_VER=%%v"
echo 飞鼠格式 源码启动
echo 目录：%CD%
echo Node：%NODE_VER%
echo.

if not exist "node_modules\electron\dist\electron.exe" (
  echo 首次运行需要安装依赖，可能要几分钟，请稍候...
  echo.
  call npm install
  if errorlevel 1 (
    echo.
    echo 依赖安装失败。请检查网络后重试。
    echo.
    pause
    exit /b 1
  )
  echo.
)

if not exist "node_modules\electron\dist\electron.exe" (
  echo 未找到 Electron，无法启动桌面版。
  echo.
  pause
  exit /b 1
)

echo 正在启动飞鼠格式...
start "飞鼠格式" "%~dp0node_modules\electron\dist\electron.exe" .
exit /b 0
