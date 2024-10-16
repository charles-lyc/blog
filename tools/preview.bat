chcp 65001

@echo off

REM 1. 复制 文章 文件夹下的所有内容到 ./git/blog/source/_posts 目录
xcopy /s /y ".\文章\*" ".\src\source\_posts"

REM 检查复制操作是否成功
if %errorlevel% neq 0 (
    echo Error: Failed to copy files from ./文章 to ./src\source\_posts.
    exit /b 1
)

REM 1.5 同步相册
del /Q ".\src\source\gallery\images\*.*"
xcopy /s /y ".\相册\*" ".\src\source\gallery\images"

REM 检查复制操作是否成功
if %errorlevel% neq 0 (
    echo Error: Failed to copy files from ./相册 to ./src\source\gallery\images.
    exit /b 1
)

REM 2. 切换到 ./git/blog 目录
cd /d ".\src"
if %errorlevel% neq 0 (
    echo Error: Failed to navigate to ./src directory.
    exit /b 1
)

REM 2.5 执行相册脚本
python .\source\gallery\test.py
echo 相册脚本执行完毕

REM 3. 运行 hexo clean
echo Running hexo clean...
call hexo clean
if %errorlevel% neq 0 (
    echo Error: Failed to execute hexo clean.
    exit /b 1
)

REM 4. 运行 hexo generate
echo Running hexo generate...
call hexo generate
if %errorlevel% neq 0 (
    echo Error: Failed to execute hexo generate.
    exit /b 1
)

REM 6. 打开浏览器，访问 http://localhost:4000
start "" "http://localhost:4000"
if %errorlevel% neq 0 (
    echo Error: Failed to open the browser.
    exit /b 1
)
echo Blog deployed successfully and server is running at http://localhost:4000

REM 5. 运行 hexo server 并确保它同步执行
echo Running hexo server...
call hexo server
if %errorlevel% neq 0 (
    echo Error: Failed to start hexo server.
    exit /b 1
)

