#!/bin/bash
serverRoot="/opt/dotnet/"
logfile="/home/ec2-user/user-data.error.log"
dotnet_version="dotnet-sdk-2.1.300-preview1-008174-linux-x64"
user="dotnet"
NAME="agapes-demo"
useradd $user

touch $logfile
yum update -y >> $logfile
yum install -y libunwind libicu >> $logfile
yum install -y gcc make >> $logfile

# Install Nginx 
yum install -y nginx >> $logfile
#yum install -y dotnet-sdk-2.1 >> $logfile
# DOTNET SDK 2.1.3 Install
mkdir -p $serverRoot >> $logfile

wget https://download.microsoft.com/download/D/7/8/D788D3CD-44C4-487D-829B-413E914FB1C3/$dotnet_version.tar.gz >> $logfile
tar zxf $dotnet_version.tar.gz -C /$serverRoot >> $logfile
export PATH=$PATH:$serverRoot

mkdir /home/$user/agapes-demo


echo "${init_script}" > /etc/init.d/agapes-demo
chmod +x /etc/init.d/agapes-demo

sed -ri '/location \//,/.*\}/d' /etc/nginx/nginx.conf

echo "
location / {
		proxy_pass http://localhost:5000;
		proxy_http_version 1.1;
		proxy_set_header Upgrade \$http_upgrade;
		proxy_set_header Connection keep-alive;
		proxy_set_header Host \$http_host;
		proxy_cache_bypass \$http_upgrade;
}
" > /etc/nginx/default.d/server.conf


mkdir /home/$user/agapes-demo/src
cd /home/$user/agapes-demo/src

dotnet new webapi -n $NAME  >> $logfile
cd /home/$user/agapes-demo/src/$NAME

dotnet publish -o /home/$user/agapes-demo  >> $logfile


# mkdir /home/$user/agent/
# cd /home/$user/agent/

# wget https://vstsagentpackage.azureedge.net/agent/2.131.0/vsts-agent-linux-x64-2.131.0.tar.gz
# tar zxvf vsts-agent-linux-x64-2.131.0.tar.gz
 
#  ./config.sh --agent AWS --acceptteeeula --url https://ineat-itms.visualstudio.com/ --work _work --pool Local --auth PAT --token o4legqawguxa7bstafjgcgi6giemdieiu7anyhjsc2nar4srmzna --runasservice >> $logfile
# ./run.sh >> $logfile

chown $user:ec2-user /home/$user -R
chgrp $user:ec2-user /home/$user -R
chmod 775 /home/$user/ -R


service nginx start  >> $logfile
chkconfig nginx on  >> $logfile

service agapes-demo start  >> $logfile
chkconfig agapes-demo on  >> $logfile