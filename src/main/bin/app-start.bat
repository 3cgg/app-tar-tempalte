:: Licensed to the Apache Software Foundation (ASF) under one or more
:: contributor license agreements.  See the NOTICE file distributed with
:: this work for additional information regarding copyright ownership.
:: The ASF licenses this file to You under the Apache License, Version 2.0
:: (the "License"); you may not use this file except in compliance with
:: the License.  You may obtain a copy of the License at
::
::     http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.

@echo off
:: hide bat window
if "%1"=="h" goto begin

start mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit

:begin

call ../etc/app-env.bat

call app-stop.bat

echo %CD%

:: set ALL_JARS=.;"%JAVA_HOME%/lib/dt.jar";"%JAVA_HOME%/lib/tools.jar"
:: setlocal enabledelayedexpansion
:: for %%i in ("%APP_LIB_DIR%\*.jar") do (
  :: echo !ALL_JARS!
  :: set ALL_JARS =!ALL_JARS!;%%i

:: )
:: set APP_CLASSPATH=!ALL_JARS!

set APP_EXE="%JAVA_HOME%/bin/java"

set APP_MAIN_EXE=%APP_EXE% -DAPP_NODE=%APP_MAIN_NAME% %APP_OPTS% -DAPP_FINAL_LOG_DIR=%APP_LOG_DIR%  -classpath %APP_CONF_DIR%;%APP_LIB_DIR%/* %APP_MAIN_CLASS%

start /b app-check.bat

echo %APP_MAIN_EXE%

%APP_MAIN_EXE%
