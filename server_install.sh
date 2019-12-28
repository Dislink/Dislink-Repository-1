#!/bin/bash
# Author: Dislink Sforza
wd=`pwd`
touch $wd/Version.dat
chmod -R 777 $wd/Version.dat
ConnectionChecks=0
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
        if [ $ConnectionChecks -lt 2 ]
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
wget -q -O Update_Server_Version.txt https://minecraft.net/en-us/download/server/bedrock/
if [ $? != 0 ]
then
	echo -e "\033[1;31mUnable to connect to update website,please check your Internet connection.\033[0m"
else
	URL=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' Update_Server_Version.txt)
	FILENAME=${URL##*/}
	VERSION=${FILENAME%.*}
	if [ ${VERSION}a = `cat $wd/Version.dat`a ]
	then
		echo -e "\033[1;32mThe Minecraft Server on your device is already the latest!\033[0m"
	else
	echo -e "\033[1;34mNew version of Minecraft Server $VERSION is available.\033[0m"
	echo -e "\033[1;33mStart downloading Minecraft Server\033[0m\c"
        sleep 1s
        echo -e  "\033[1;33m.\033[0m\c"
        sleep 1s
        echo -e  "\033[1;33m.\033[0m\c"
        sleep 1s
        echo -e  "\033[1;33m.\033[0m\c"
	wget -q -O $FILENAME $URL
	if [ $? = 0 ]
	then
		echo -e "\033[1;32m    [Done!]\033[0m"
		if [ -d $wd/bedrock-server ]
		then
			echo -e "\033[1;33mChanging directory\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
			cd $wd/bedrock-server
			if [ $? = 0 ]
			then
			echo -e  "\033[1;32m     [Done!]\033[0m"
			echo $VERSION > $wd/Version.dat
			else
				echo -e "\033[1;31m    [Failed!]\033[0m"
                       		echo -e "\033[1;31mConnot change working directory(permission denied?)\033[0m"
			fi
			echo -e "\033[1;33mUnpacking $FILENAME\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
			unzip -q -o "$wd/$FILENAME" -x "*server.properties*" "*permissions.json*" "*whitelist.json*"
			if [ $? = 0 ]
                        then
                        echo -e  "\033[1;32m     [Done!]\033[0m"
#  			 echo -e "\033[1;33mStarting Minecraft Server\033[0m\c"
#                        sleep 1s
#                        echo -e  "\033[1;33m.\033[0m\c"
#                        sleep 1s
#                        echo -e  "\033[1;33m.\033[0m\c"
#                        sleep 1s
#                        echo -e  "\033[1;33m.\033[0m\c"
#			 LD_LIBRARY_PATH=. ./bedrock_server
#			if [ $? = 0 ]
#                        then
#                        echo -e  "\033[1;32m     [Done!]\033[0m"
#                        else
#                                echo -e "\033[1;31m    [Failed!]\033[0m"
#                                echo -e "\033[1;31m`LD_LIBRARY_PATH=. ./bedrock_server`\033[0m"
#                        fi
                        else
                                echo -e "\033[1;31m    [Failed!]\033[0m"
                                echo -e "\033[1;31mUnable to unpack $FILENAME\033[0m"
                        fi

		else
			echo -e "\033[1;33mCreating directory\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
			mkdir -p $wd/bedrock-server
			if [ $? = 0 ]
                        then
                        echo -e  "\033[1;32m     [Done!]\033[0m"
                        else
                                echo -e "\033[1;31m    [Failed!]\033[0m"
				echo -e "\033[1;31mUnable to creat directory(permission denied?)\033[0m"
                        fi
			echo -e "\033[1;33mChanging directory\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
			cd $wd/bedrock-server
			if [ $? = 0 ]
                        then
                        echo -e  "\033[1;32m     [Done!]\033[0m"
			echo $VERSION > $wd/Version.dat
                        else
                                echo -e "\033[1;31m    [Failed!]\033[0m"
                                echo -e "\033[1;31mConnot change working directory(permission denied?)\033[0m"
                        fi
			echo -e "\033[1;33mUnpacking $FILENAME\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
                        sleep 1s
                        echo -e  "\033[1;33m.\033[0m\c"
			unzip -q -o "$wd/$FILENAME"
			if [ $? = 0 ]
                        then
                        echo -e  "\033[1;32m     [Done!]\033[0m"
#                        LD_LIBRARY_PATH=. ./bedrock_server
#                        if [ $? = 0 ]
#                        then
#                        echo -e  "\033[1;32m     [Done!]\033[0m"
#                        else
#                                echo -e "\033[1;31m    [Failed!]\033[0m"
#                                echo -e "\033[1;31m`LD_LIBRARY_PATH=. ./bedrock_server`\033[0m"
#                        fi
			else
                                echo -e "\033[1;31m    [Failed!]\033[0m"
                                echo -e "\033[1;31mUnable to unpack $FILENAME\033[0m"
                        fi
		fi
	else
		echo -e "\033[1;31m    [Failed!]\033[0m"
		echo -e "\033[1;31mFailed downloading Minecarft Server,please check your Internet connection.\033[0m"
	fi
fi 
fi
fi
if [ -f $wd/$FILENAME ]
then
rm -rf $wd/$FILENAME
fi
if [ -f $wd/Update_Server_Version.txt ]
then
rm -rf $wd/Update_Server_Version.txt
fi
if [ -d $wd/bedrock-server ]
then
chmod -R 777 $wd/bedrock-server
fi

