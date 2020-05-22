#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -- source , --exec --fork
!<<EOF

while read info
do
    echo read from io : $info

done
EOF

function print_usage(){
  echo "Usage: app-daemon.sh (start|stop) <app-command> [<args...>]"
  echo "       where COMMAND is : app"
  echo "       <args...> is "
  echo "-d            start daemon processor"
  # There are also debug commands, but they don't show up in this listing.
}

# if no args specified, show usage
if [ $# -le 1 ]; then
  print_usage
  exit 1
fi

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin"; pwd`

if [ -f "$bin/../etc/app-env.sh" ]; then
  . "$bin/../etc/app-env.sh"
else
  echo "$bin/../etc/app-env.sh not found."
  exit 1
fi

if [ "$APP_LOG_DIR" = "" ]; then
  export APP_LOG_DIR="$APP_HOME/logs"
fi

if [ "$APP_IDENT_STRING" = "" ]; then
  export APP_IDENT_STRING="$USER"
fi

if [ ! -w "$APP_LOG_DIR" ] ; then
  mkdir -p "$APP_LOG_DIR"
  chown $APP_IDENT_STRING $APP_LOG_DIR
fi

if [ "$APP_PID_DIR" = "" ]; then
  APP_PID_DIR=/tmp
fi

# get arguments
startStop=$1
command=$2
daemonFlag=$3

pid=$APP_PID_DIR/app-$APP_IDENT_STRING-$command-$HOSTNAME.pid
daemonPid=$APP_PID_DIR/app-$APP_IDENT_STRING-$command-daemon-$HOSTNAME.pid

APP_STOP_TIMEOUT=${APP_STOP_TIMEOUT:-5}

ALL_JARS=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
for jar in $APP_LIB_DIR/*.jar;do
    ALL_JARS=$jar:${ALL_JARS}
done
APP_CLASSPATH=$ALL_JARS

APP_EXE=$JAVA_HOME/bin/java

case $command in

    app)
    ;;
    *)
        echo "aha,only accept app"
        exit 1
    ;;
esac


case $startStop in
    (start)
        [ -w "$APP_PID_DIR" ] ||  mkdir -p "$APP_PID_DIR"

        if [ -f $pid ]; then
          if kill -0 `cat $pid` > /dev/null 2>&1; then
            echo $command running as process `cat $pid`.  Stop it first.
            exit 1
          fi
        fi

        case $command in
            app)
                echo start app
                APP_MAIN_EXE="nohup ${APP_EXE} -DAPP_NODE=$APP_MAIN_NAME ${APP_OPTS} -DAPP_FINAL_LOG_DIR=$APP_LOG_DIR  -classpath $APP_CONF_DIR:$APP_CLASSPATH $APP_MAIN_CLASS > /dev/null 2>&1 &"
                if [ "$daemonFlag" == "-d" ]; then
                    . $APP_BIN_DIR/monitor.sh $APP_MAIN_NAME "$APP_MAIN_EXE" "$pid" >/dev/null 2>&1 &
                    echo $! > $daemonPid
                    echo start app daemon, pid `cat "$daemonPid"`
                else
                    $APP_MAIN_EXE >/dev/null 2>&1 &
                    echo $! > $pid
                    echo app pid `cat $pid`
                fi
            ;;
            *)
                echo "aha,only accept app"
            ;;
        esac


    ;;

    (stop)

        if [ -f $daemonPid ]; then
          TARGET_PID=`cat $daemonPid`
          if kill -0 $TARGET_PID > /dev/null 2>&1; then
            echo $command running as daemon $TARGET_PID.  Stop it first.
            echo stopping $command daemon
            sleep $APP_STOP_TIMEOUT
            if kill -0 $TARGET_PID > /dev/null 2>&1; then
              echo "$command daemon did not stop gracefully after $APP_STOP_TIMEOUT seconds: killing with kill -9"
              kill -9 $TARGET_PID
            fi
          else
            echo no $command daemon to stop
          fi
          rm -f $daemonPid
        else
          echo no $command daemon to stop
        fi

        if [ -f $pid ]; then
          TARGET_PID=`cat $pid`
          if kill -0 $TARGET_PID > /dev/null 2>&1; then
            echo stopping $command
            kill $TARGET_PID
            sleep $APP_STOP_TIMEOUT
            if kill -0 $TARGET_PID > /dev/null 2>&1; then
              echo "$command did not stop gracefully after $APP_STOP_TIMEOUT seconds: killing with kill -9"
              kill -9 $TARGET_PID
            fi
          else
            echo no $command to stop
          fi
          rm -f $pid
        else
          echo no $command to stop
        fi
    ;;

    (*)
        print_usage
        exit 1
    ;;


esac













