#!/bin/bash
# Author: Dislink Sforza
ConnectionChecks=0
wd=`pwd`
cd $wd/bedrock-server
echo -e "\033[1;33mChecking Network Connection\033[0m\c"
sleep 1s
echo -e  "\033[1;33m.\033[0m\c"
sleep 1s
echo -e  "\033[1;33m.\033[0m\c"
sleep 1s
echo -e  "\033[1;33m.\033[0m\c"
function ConnectionCheck(){
        ConnectionChecks=$((${ConnectionChecks}+1))
ping -c 1 minecraft.net > /dev/null 2>&1
if [ $? = 0  ]
        then
        Connection=Connected
        echo -e  "\033[1;32m     [Done!]\033[0m"
else
        if [ $ConnectionChecks -lt 4 ]
                then
                        echo -e "\033[1;33mNetwork disconnected,will try again in 1 seconds. \033[0m"
                        sleep 1s
                        ConnectionCheck
                else
                        Connection=Disconnected
                        echo -e "\033[1;31m    [Failed!]\033[0m"
                        echo -e "\033[1;31mNetwork disconnected,please check your Internet connection. \033[0m"
        fi
fi

}
ConnectionCheck
if [ $Connection = Connected ]
then
	echo -e "\033[1;33mStarting Minecraft Server\033[0m\c"
	sleep 1s
        echo -e  "\033[1;33m.\033[0m\c"
        sleep 1s
        echo -e  "\033[1;33m.\033[0m\c"
        sleep 1s
        echo -e  "\033[1;33m.\033[0m"
        LD_LIBRARY_PATH=. ./bedrock_server
        if [ $? != 0 ]
        then
                echo -e "\033[1;31m    [Failed!]\033[0m"
        fi
else
	echo -e "\033[1;31mNetwork disconnected!\033[0m"
fi
