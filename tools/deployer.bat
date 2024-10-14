REM 部署到GitHub

chcp 65001

@echo off
REM 1. 切换到 ./git/blog 目录
cd /d ".\src"
if %errorlevel% neq 0 (
    echo Error: Failed to navigate to ./src directory.
    exit /b 1
)

call hexo deploy
