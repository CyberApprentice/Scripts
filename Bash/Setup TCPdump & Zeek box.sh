#!/bin/bash

# Constants
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Brown='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
LightGray='\033[0;37m'
DarkGray='\033[1;30m'
LightRed='\033[1;31m'
LightGreen='\033[1;32m'
Yellow='\033[1;33m'
LightBlue='\033[1;34m'
LightPurple='\033[1;35m'
LightCyan='\033[1;37m'
White='\033[1;37m'
NC='\033[0m' # No Color

# Setup
echo  -e "${Cyan}Setup...${NC}"
apt install -y acl ntpdate ntp vim
systemctl stop ntp
ntpdate pool.ntp.org
systemctl start ntp
timedatectl set-timezone America/Chicago

# TCPDUMP setup
echo  -e "${Cyan}TCPDUMP setup...${NC}"
mkdir -p /opt/tcpdump/logs
echo -e '#!/bin/bash\n/usr/sbin/tcpdump -i enp2s0 -G 3600 -w /opt/tcpdump/logs/`hostname -s`.%m-%d-%Y.%H:%M:%S.pcap -z bzip2' > /opt/tcpdump/tcpdump-script.sh
chgrp tcpdump /usr/sbin/tcpdump
chmod 0750 /usr/sbin/tcpdump
chown -R tcpdump.tcpdump /opt/tcpdump
chmod -R 0760 /opt/tcpdump/logs
chmod 0750 /opt/tcpdump/tcpdump-script.sh 
sed -i '$i\\n  #enable gzip\n  #/**.[pP][cC][aA][pP].[gG][zZ] rw,\n\n  #enable bzip2\n  /**.[pP][cC][aA][pP].[bB][zZ]2 rw,' /etc/apparmor.d/usr.sbin.tcpdump
apparmor_parser -r /etc/apparmor.d/usr.sbin.tcpdump
setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump


# TCPDUMP service
echo -e "${Cyan}TCPDUMP service...${NC}"
echo -e '[Unit]
Description=TCPDump
Wants=network-online.target

[Service]
Type=simple
EnvironmentFile=-/etc/default/tcpdump

user=tcpdump
Group=tcpdump
NoNewPrivileges=yes
ProtectSystem=strict
PrivateTmp=yes
ProtectHome=yes
ReadWritePaths=/opt/tcpdump
PrivateDevices=yes
ProtectKernelTunables=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
SystemCallFilter=@system-service 
SystemCallErrorNumber=EPERM

WorkingDirectory=/opt/tcpdump
UMask=127
ExecStart=/opt/tcpdump/tcpdump-script.sh

StandardOutput=journal+console

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/tcpdumpd.service

systemctl daemon-reload
systemctl enable tcpdumpd.service

# Zeek Setup
echo  -e "${Cyan}Zeek Setup...${NC}"
apt update && sudo apt install curl cmake make gcc g++ flex bison libpcap-dev libssl-dev python3 python3-dev swig zlib1g-dev python3-git python3-semantic-version -y

echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/security:zeek.list
curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
sudo apt update
sudo apt install zeek-lts -y

echo 'export PATH=/opt/zeek/bin:$PATH' >> /etc/profile
source /etc/profile

adduser zeek --system --no-create-home
addgroup zeek zeek
setcap cap_net_raw,cap_net_admin=eip /opt/zeek/bin/zeek
setcap cap_net_raw,cap_net_admin=eip /opt/zeek/bin/capstats
chown -R zeek.zeek /opt/zeek
chmod -R 0760 /opt/zeek/logs
chmod -R 0760 /opt/zeek/spool
chmod 0750 /opt/zeek/bin/zeek

echo -e 'event zeek_init()
{
if ( Supervisor::is_supervisor() )
    {
    local sn = Supervisor::NodeConfig($name="zeekd", $interface="enp2s0");
    local res = Supervisor::create(sn);

    if ( res == "" )
        print "supervisor created a new node";
    else
        print "supervisor failed to create node", res;
    }
else
    print fmt("supervised node '%s' zeek_init()", Supervisor::node()$name);
}

event zeek_done()
{
if ( Supervisor::is_supervised() )
    print fmt("supervised node '%s' zeek_done()", Supervisor::node()$name);
else
    print "supervisor zeek_done()";
}' > /opt/zeek/etc/simple-supervisor.zeek

echo -e '[Unit]
Description=The Zeek Network Security Monitor
Wants=network-online.target

[Service]
Type=simple
Environment=SUPERVISOR=/opt/zeek/etc/simple-supervisor.zeek
EnvironmentFile=-/etc/default/zeek

Group=zeek
NoNewPrivileges=yes
ProtectSystem=strict
PrivateTmp=yes
ProtectHome=yes
ReadWritePaths=/opt/zeek/logs
PrivateDevices=yes
ProtectKernelTunables=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
SystemCallFilter=@system-service 
SystemCallErrorNumber=EPERM

WorkingDirectory=/opt/zeek/logs
UMask=127
ExecStart=/opt/zeek/bin/zeek -j -C ${SUPERVISOR}

StandardOutput=journal+console

[Install]
WantedBy=multi-user.target ' > /etc/systemd/system/zeekd.service

systemctl daemon-reload
systemctl enable zeekd.service

# Reboot
echo  -e "${Cyan}Rebooting in 10s...${NC}"
sleep 10
reboot