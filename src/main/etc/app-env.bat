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

:: The java implementation to use.  Java 1.7+ required.
:: export JAVA_HOME=/usr/java/jdk1.6.0/

:: Extra Java CLASSPATH elements.  Optional.
:: export HBASE_CLASSPATH=

:: The maximum amount of heap to use. Default is left to JVM default.
:: export HBASE_HEAPSIZE=1G

:: Uncomment below if you intend to use off heap cache. For example, to allocate 8G of
:: offheap, set the value to "8G".
:: export HBASE_OFFHEAPSIZE=1G

set APP_OPTS=-XX:+UseConcMarkSweepGC -Dfile.encoding=utf-8

:: Configure PermSize. Only needed in JDK7. You can safely remove it for JDK8+
:: set APP_OPTS=%APP_OPTS% -XX:PermSize=128m -XX:MaxPermSize=128m -XX:ReservedCodeCacheSize=256m

:: Enable remote JDWP debugging of major HBase processes. Meant for Core Developers 
:: export APP_OPTS="APP_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8070"

:: The directory where pid files are stored. /tmp by default.
:: export APP_PID_DIR=/var/hadoop/pids

set JAVA_HOME=%JAVA_HOME%
set APP_HOME=/work/app-api/app
set APP_LOG_DIR=%APP_HOME%/logs
set APP_IDENT_STRING=root
set APP_TMP=%APP_HOME%/tmp
set APP_PID_DIR=%APP_TMP%/pid

set APP_BIN_DIR=%APP_HOME%/bin
set APP_CONF_DIR=%APP_HOME%/etc
set APP_LIB_DIR=%APP_HOME%/lib

set APP_MAIN_CLASS=com.ainobug.tar.TarServiceApplication
set APP_MAIN_NAME=TarServiceApplication

echo %JAVA_HOME%
echo "load env"













