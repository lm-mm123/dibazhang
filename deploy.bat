@echo off
chcp 65001 >nul
title 第8章 GitHub Pages 一键部署工具

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                第8章数据可视化 GitHub Pages 部署工具         ║
echo ║                     Chapter8 Visualization Deploy          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: 检查Git是否安装
echo [1/5] 检查系统环境...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: 未检测到Git，请先安装Git
    echo 📥 下载地址: https://git-scm.com/download/win
    pause
    exit /b 1
)
echo ✅ Git环境检查通过

:: 获取用户输入
echo.
echo [2/5] 获取部署信息...
set /p username=请输入GitHub用户名: 
if "%username%"=="" (
    echo ❌ 错误: 用户名不能为空
    pause
    exit /b 1
)

set /p reponame=请输入仓库名称 (chapter8-visualization): 
if "%reponame%"=="" set reponame=chapter8-visualization

echo 📋 部署信息确认:
echo    用户名: %username%
echo    仓库名: %reponame%
echo    仓库地址: https://github.com/%username%/%reponame%
echo.

:: 确认继续
set /p confirm=确认信息无误并继续部署? (Y/N): 
if /i not "%confirm%"=="Y" (
    echo ❌ 用户取消部署
    pause
    exit /b 0
)

:: 初始化Git仓库
echo.
echo [3/5] 初始化Git仓库...
git init >nul 2>&1
git add . >nul 2>&1
git commit -m "📊 部署第8章完整数据可视化平台" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git初始化失败
    pause
    exit /b 1
)
echo ✅ Git仓库初始化完成

:: 添加远程仓库
echo.
echo [4/5] 配置远程仓库...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/%username%/%reponame%.git >nul 2>&1
git branch -M main >nul 2>&1
echo ✅ 远程仓库配置完成

:: 推送到GitHub
echo.
echo [5/5] 推送到GitHub...
echo 📤 正在推送文件，请稍候...
git push -u origin main 2>nul
if %errorlevel% neq 0 (
    echo.
    echo ❌ 推送失败！可能的原因:
    echo    1. GitHub仓库不存在
    echo    2. 网络连接问题
    echo    3. 认证失败 (需要配置Git凭据)
    echo.
    echo 💡 解决方案:
    echo    1. 访问 https://github.com/%username%/%reponame% 确认仓库存在
    echo    2. 配置Git认证: git config --global user.name "你的名字"
    echo                       git config --global user.email "你的邮箱"
    echo    3. 使用Personal Access Token进行认证
    pause
    exit /b 1
)
echo ✅ 推送成功！

:: 显示结果
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                        🎉 部署成功！                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📊 仓库地址: https://github.com/%username%/%reponame%
echo 🌐 网站地址: https://%username%.github.io/%reponame%/
echo.
echo 📋 下一步操作:
echo    1. 访问仓库地址确认文件已上传
echo    2. 进入 Settings → Pages 启用GitHub Pages
echo    3. 选择 Deploy from a branch → main → /(root)
echo    4. 等待2-10分钟部署完成
echo.
echo 💡 提示: 如果遇到问题，请查看 GITHUB_PAGES_DEPLOY_GUIDE.md 文件
echo.

:: 询问是否打开仓库页面
set /p open=是否打开仓库页面? (Y/N): 
if /i "%open%"=="Y" (
    start https://github.com/%username%/%reponame%
)

echo.
echo 🚀 第8章数据可视化平台部署完成！
pause