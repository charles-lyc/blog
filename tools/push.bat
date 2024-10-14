REM 用于提交src（其实没必要）

chcp 65001

@echo off
REM 1. 切换到 ./git/blog 目录
cd /d ".\src"
if %errorlevel% neq 0 (
    echo Error: Failed to navigate to ./src directory.
    exit /b 1
)

REM 2. 检查 git 状态
echo Checking git status...
git status
if %errorlevel% neq 0 (
    echo Error: Git is not initialized in this directory or GitHub is unreachable.
    exit /b 1
)

REM 3. 添加所有更改到 git
echo Adding changes to git...
git add .
if %errorlevel% neq 0 (
    echo Error: Failed to add changes to git.
    exit /b 1
)

REM 4. 提交更改，带有时间戳的提交信息
echo Committing changes...
set commit_msg="Auto commit on %date% at %time%"
git commit -m %commit_msg%
if %errorlevel% neq 0 (
    echo Error: No changes to commit or failed to commit.
    exit /b 1
)

REM 5. 推送更改到 GitHub
echo Pushing changes to GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo Error: Failed to push changes to GitHub. Please check your credentials or network.
    exit /b 1
)

echo Changes pushed to GitHub successfully!
