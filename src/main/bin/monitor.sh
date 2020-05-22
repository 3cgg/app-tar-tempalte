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

#进程名字可修改
PRO_NAME=$1
CMD=$2
PID_FILE=$3

function restart() {
    echo "restart..." >>$APP_TMP/daemon-monitor
    $CMD >/dev/null 2>&1 &
    echo $! > $PID_FILE
}

while true ; do
     #用ps获取$PRO_NAME进程数量
    NUM=`ps aux | grep -w ${PRO_NAME} | grep -v grep |wc -l`
    echo "NUM:"$NUM >>$APP_TMP/daemon-monitor
    #少于1，重启进程
    if [ "${NUM}" -lt "1" ];then
        echo "${PRO_NAME} was killed" >>$APP_TMP/daemon-monitor
        restart
    #大于1，杀掉所有进程，重启
    elif [ "${NUM}" -gt "1" ];then
        echo "more than 1 ${PRO_NAME},killall ${PRO_NAME}" >>$APP_TMP/daemon-monitor
        ps -ef| grep ${PRO_NAME} | grep -v grep | awk '{print $2}' | xargs kill -9
        restart
    fi

    sleep 15s
done

exit 0