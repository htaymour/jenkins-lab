date : 01_03_2024_19_18_01 
term len 0
testsandbox# show running-config

!Command: show running-config
!Running configuration last done at: Fri Mar  1 18:55:17 2024
!Time: Fri Mar  1 18:55:24 2024

version 10.3(3) Bios:version  
hostname testsandbox
policy-map type network-qos test
  class type network-qos class-default
policy-map type network-qos jumbo
  class type network-qos class-default
    mtu 9192
install feature-set mpls
install feature-set virtualization
vdc testsandbox id 1
  allow feature-set virtualization
  allow feature-set mpls
  limit-resource vlan minimum 16 maximum 4094
  limit-resource vrf minimum 2 maximum 4096
  limit-resource port-channel minimum 0 maximum 511
  limit-resource m4route-mem minimum 58 maximum 58
  limit-resource m6route-mem minimum 8 maximum 8
feature-set mpls
feature-set virtualization

feature nxapi
feature bash-shell
feature scp-server
feature vrrp
feature tacacs+
cfs eth distribute
feature scheduler
feature ospf
feature bgp
feature pim
feature eigrp
feature rip
feature fabric forwarding
feature netconf
feature restconf
feature grpc
feature openconfig
feature udld
feature interface-vlan
feature hsrp
feature lacp
feature vpc
feature lldp
feature vtp
feature bfd
clock timezone SGP 8 0
clock protocol none vdc 1
feature sla sender
feature nv overlay
feature telemetry
feature app-hosting
feature container-tracker

archive
  path bootflash:myconfig
  time-period 0
  maximum 14
  write-memory

username admin password 5 $5$NLFAEI$idnxSM9ZH.T32.8on80UK2zODdDznSNxyvvaS1G7vRB  role network-admin
username admin role priv-15
username user1 password 5 $5$AGMHHC$7PfZeOhfrfXpSk41ySHZScuP0pnBdECXDvcBj23mwe.  role network-operator
username user1 passphrase  lifetime 99999 warntime 14 gracetime 3
username baykar password 5 $5$HJIBKC$fguFY84O7CHiuBUI0HmWsPQznvy651O1KUyVGpyRgj2  role network-operator
username baykar passphrase  lifetime 99999 warntime 14 gracetime 3
username cisco password 5 $5$JLIPNF$OSmYvhtw4qYXUuO1MWvT6wSYLEeDWFaReC4.ZvhYXFC  role network-operator
username cisco passphrase  lifetime 99999 warntime 14 gracetime 3
username bisto password 5 $5$JPBJIB$C4Fp7edKaYHPLiTovlhHDUmMm2kd6J5TAhOBxuWkI20  role network-operator
username bisto passphrase  lifetime 99999 warntime 14 gracetime 3
username tacuser password 5 $5$FDMIIF$GZTH1iq5ahBEojYTkhOdks7e2SLh8yjUY0dSJV8E1w6 expire 2024-01-20 role network-admin
username tacuser passphrase  lifetime 99999 warntime 14 gracetime 3
username ansible password 5 $5$GGICMM$pFP2mOb6fu0JbtzxQ216fynmsr8m7vdwjPOnsIB1P57  role network-operator
username ansible passphrase  lifetime 99999 warntime 14 gracetime 3
username USER password 5 !  role network-operator
username USER passphrase  lifetime 99999 warntime 14 gracetime 3
username CTESTSS password 5 $1$nqM1njqh$pxjTmv2nIc3u42WFzZuLb1  role network-admin
username CTESTSS passphrase  lifetime 99999 warntime 14 gracetime 3
username test password 5 $1$oEGIC3C1$XIubNDhDEkFYoz4N5jj3f.  role network-admin
username test passphrase  lifetime 99999 warntime 14 gracetime 3
username Test1 password 5 $1$JCWq8B0i$H799hZkaQKzlbjNM0gXmV0  role network-admin
username Test1 passphrase  lifetime 99999 warntime 14 gracetime 3
username test1 password 5 $1$rVA5CoVU$E9Y/yxL07Egj/pnBiW2HL/  role network-admin
username test1 passphrase  lifetime 99999 warntime 14 gracetime 3
username cms password 5 $5$CPLFDH$6c7pFvxgsRrAIQgibaAbaoKDyMieLHcu6rJPaRq5VZB  role priv-15
username cms passphrase  lifetime 99999 warntime 14 gracetime 3
ssh key rsa 2048 

banner motd ^CDE^


banner exec ^ABC^

userpassphrase min-length 15 max-length 127 

userpassphrase default-lifetime 90 

ip domain-lookup
ip name-server 1.1.1.1 8.8.8.8
ip host ddd 10.227.105.20
ip host eee 172.22.175.96
ip host iii 10.120.242.68
tacacs-server key 7 "xsghttvh32201n"
tacacs-server host 88.8.95.93 
tacacs-server host 88.8.95.94 
tacacs-server host ddd key 7 "ABCD" timeout 10 
tacacs-server host eee key 7 "ABCD" timeout 10 
tacacs-server host iii key 7 "ABCD" timeout 10 
aaa group server tacacs+ ISE_TACACS_REG 
    server ddd 
    server eee 
    server iii 
    deadtime 10
aaa group server tacacs+ tacacs 
radius-server host 172.16.1.12 key 7 "VwritosWsgsziGio" authentication accounting 
radius-server host 172.16.1.13 key 7 "VwritosWsgsziGio" authentication accounting 
radius-server host 10.10.10.11 key 7 "wawygvvhanvzs1" authentication accounting 
aaa group server radius AAA-Radius-Group 
    server 172.16.1.12 
    server 172.16.1.13 
    use-vrf management
aaa group server radius TEST 
aaa group server radius Test 
    server 10.10.10.11 
crypto key generate rsa label mytrustpoint exportable modulus 2048
crypto key generate rsa label gnmicert exportable modulus 2048
crypto ca trustpoint mytrustpoint 
     rsakeypair mytrustpoint 
     revocation-check  crl 
crypto ca trustpoint my_client_trustpoint 
     revocation-check  crl 
crypto ca trustpoint gnmicert 
     rsakeypair gnmicert 
     revocation-check  crl 
spanning-tree mode mst
object-group ip address connected_route
  10 host 182.162.107.2 
  20 host 182.162.108.2 
  30 host 182.162.107.1 
  40 host 182.162.108.1 
  50 host 110.45.171.66 
  60 host 110.45.171.65 
  70 host 110.45.171.98 
  80 host 110.45.171.97 
  90 host 182.162.74.2 
  100 host 110.45.197.2 
  110 host 182.162.74.1 
  120 host 110.45.197.1 
  130 host 172.30.104.203 
  140 host 61.111.33.2 
  150 host 61.111.33.34 
  160 host 61.111.33.66 
  170 host 61.111.33.98 
  180 host 61.111.33.10 
  190 host 61.111.33.42 
  200 host 61.111.33.70 
  210 host 61.111.33.110 
  220 host 182.162.107.3 
  230 host 182.162.108.3 
  240 host 110.45.171.67 
  250 host 110.45.171.99 
  260 host 182.162.74.3 
  270 host 110.45.197.3 
object-group ip address snmp_server
  10 host 61.111.52.60 
  20 host 211.38.137.33 
  30 host 110.45.166.125 
  40 203.248.244.128/25 
  50 121.254.248.16/28 
  60 211.233.23.0/24 
  70 61.34.79.192/26 
  80 host 110.45.196.97 
  90 host 164.124.106.117 
  100 host 121.254.252.68 
  110 host 203.248.244.166 
  120 host 203.248.244.171 
  130 host 211.233.86.245 
  140 host 211.233.86.252 
  150 host 211.233.86.253 
  160 host 222.231.25.153 
ip access-list 99
  statistics per-entry
  10 permit udp 10.23.60.59/32 eq snmp 172.30.176.49/32 
  20 permit udp 10.23.60.59/32 eq snmp 172.30.176.49/32 log 
  30 permit udp 10.24.141.140/32 10.24.126.169/32 eq snmp log 
ip access-list ACL_TO_CUBRO
  statistics per-entry
ip access-list AutoQos-4.0-wlan-Acl-Bulk-Data
  10 permit tcp any any eq 22 
  20 permit tcp any any eq 465 
  30 permit tcp any any eq 143 
  40 permit tcp any any eq 993 
  50 permit tcp any any eq 995 
  60 permit tcp any any eq 1914 
  70 permit tcp any any eq ftp 
  80 permit tcp any any eq ftp-data 
  90 permit tcp any any eq smtp 
  100 permit tcp any any eq pop3 
ip access-list IPv4-ACL
  10 deny tcp any 198.51.100.0 0.0.0.255 
  20 permit tcp any any 
ip access-list MGMT-IN
ip access-list MGT_ACCESS
  10 permit ip 10.22.166.0 0.0.0.255 any 
  20 permit ip 10.22.205.0 0.0.0.255 any 
  30 permit ip 10.21.110.0 0.0.0.255 any 
  40 permit ip 172.30.240.0 0.0.0.255 any 
  50 permit ip 172.30.199.0 0.0.0.255 any 
  60 permit ip 10.22.168.0 0.0.0.255 any 
  70 permit ip 172.30.198.0 0.0.0.255 any 
  80 permit ip 10.23.40.163/32 any 
  90 permit ip 10.22.84.12/32 any 
  100 permit ip 10.24.141.43/32 any 
  110 permit ip 10.21.107.5/32 any 
  120 permit ip 10.24.134.185/32 any 
  130 permit ip 10.24.134.186/32 any 
  140 permit ip 10.24.134.187/32 any 
  150 permit ip 10.24.134.188/32 any 
  160 permit ip 172.30.130.16/32 any 
  170 permit ip 10.24.142.61/32 any 
  180 permit ip 10.24.142.59/32 any 
  190 permit ip 10.16.64.0 0.0.0.255 any 
  200 permit ip 172.30.64.0 0.0.15.255 any 
  210 permit ip 10.23.68.25/32 any 
  220 permit ip 10.23.68.24/32 any 
  230 permit ip 10.23.68.29/32 any 
  240 permit ip 10.23.68.59/32 any 
  250 permit ip 10.23.55.147/32 any 
  260 permit ip 10.23.55.148/32 any 
  270 permit ip 10.23.55.149/32 any 
  280 permit ip 172.30.89.11/32 any 
  290 permit ip 172.30.89.12/32 any 
  300 permit ip 172.30.160.11/32 any 
  310 permit ip 172.30.89.13/32 any 
  320 permit ip 172.30.89.14/32 any 
  330 permit ip 172.30.89.19/32 any 
  340 permit ip 172.30.89.20/32 any 
  350 permit ip 172.30.89.21/32 any 
  360 permit ip 172.30.160.13/32 any 
  370 permit ip 172.30.160.14/32 any 
  380 permit ip 172.30.160.12/32 any 
  390 permit ip 10.23.55.52/32 any 
  400 permit ip 10.23.51.51/32 any 
  410 permit ip 172.30.251.180/32 any 
  420 permit ip 172.30.251.181/32 any 
  430 permit ip 10.23.55.134/32 any 
  440 permit ip 10.23.55.135/32 any 
  450 permit ip 10.24.131.24/32 any 
  460 permit ip 10.24.131.33/32 any 
  470 permit ip 10.26.172.246/32 any 
  480 permit ip 10.26.170.242/32 any 
  490 permit ip 10.26.170.241/32 any 
  500 permit ip 10.26.138.169/32 any 
  510 permit ip 10.26.171.201/32 any 
  520 permit ip 10.26.171.200/32 any 
  530 permit ip 10.26.171.199/32 any 
  540 permit ip 10.26.171.198/32 any 
  550 permit ip 10.24.131.23/32 any 
  560 permit ip 10.24.131.29/32 any 
  570 permit ip 10.24.131.34/32 any 
  580 permit ip 10.23.35.101/32 any 
ip access-list TEST-VLAN
  10 permit udp any any eq 386 
ip access-list VLAN-TEST
  120 permit ip any 10.10.140.8/32 
  125 permit ip any 10.10.140.32/32 
  130 permit ip any 10.10.140.69/32 
  135 permit ip any 10.10.145.0/24 
  140 permit ip any 10.10.218.0/24 
  145 permit ip any 10.10.219.0/24 
ip access-list VLAN25-IN
  5 permit ip any 10.10.140.8/32 
  10 permit ip any 10.10.140.32/32 
  15 permit ip any 10.10.140.69/32 
  20 permit ip any 10.10.145.0/24 
  25 permit ip any 10.10.218.0/24 
  30 permit ip any 10.10.219.0/24 
  35 permit ip any 10.10.204.0/23 
  40 permit ip any 10.10.206.0/24 
  45 permit ip any 10.247.25.0/24 
  50 permit tcp any any eq 22 
  55 permit tcp any any eq www 
  60 permit tcp any any eq 443 
  65 permit udp any any eq ntp 
  70 permit udp any eq ntp any 
  75 permit tcp any any eq 135 
  80 permit tcp any any eq 464 
  85 permit udp any any eq 464 
  90 permit udp any eq 464 any 
  95 permit tcp any any eq 3268 
  100 permit tcp any any eq 3269 
  105 permit tcp any eq 445 any 
  110 permit udp any any eq 389 
  115 permit udp any eq 389 any 
  120 permit tcp any any eq 389 
  125 permit udp any any eq 636 
  130 permit tcp any any eq 636 
  135 permit udp any any eq domain 
  140 permit udp any eq domain any 
  145 permit tcp any any eq domain 
  150 permit tcp any eq domain any 
  155 permit udp any any eq 88 
  160 permit udp any eq 88 any 
  165 permit tcp any any eq 88 
  170 permit udp any eq snmp any 
  175 permit udp any any eq snmp 
  180 permit tcp any any range 49152 65535 
  185 permit icmp any any echo-reply 
ip access-list VLAN41-IN
  5 permit ip any 10.157.35.0/24 
  10 permit ip any 10.247.25.0/24 
  15 permit ip any 10.10.204.0/23 
  20 permit ip any 10.10.206.0/24 
  25 permit ip any 10.247.5.0/24 
  30 permit ip any 10.247.41.0/24 
  35 permit ip any 10.247.40.0/24 
  40 permit ip any 10.247.50.0/24 
  45 permit ip any 10.247.55.0/24 
  50 permit ip any 10.247.61.0/24 
  55 permit ip any 10.247.73.0/24 
  60 permit ip any 10.157.41.0/24 
  65 permit ip any 224.0.0.0/8 
  70 permit ip any 10.246.21.0/24 
  75 permit ip any 225.0.0.64/32 
  80 permit ip any 239.193.0.0/24 
  90 permit ip any 239.255.255.250/32 
  100 permit ip any 10.171.33.0/24 
  105 permit ip any 255.255.255.255/32 
  115 permit icmp any any echo-reply 
  120 deny ip any 10.0.0.0/8 
  125 deny ip any 172.16.0.0/12 
  130 deny ip any 192.168.0.0/16 
  135 permit ip any any 
ip access-list VLAN6-IN
  7 permit udp any any eq domain 
  8 permit udp any eq domain any 
  9 permit tcp any any eq domain 
  10 permit tcp any eq domain any 
  11 permit udp any eq ntp any 
  12 permit udp any any eq ntp 
  13 permit tcp any any eq 502 
  14 permit udp any any eq snmp 
  15 permit ip any 10.10.204.0/23 
  20 permit ip any 10.10.206.0/24 
  30 permit ip any 10.247.5.0/24 
  35 permit ip any 10.247.6.0/24 
  105 permit icmp any any echo-reply 
  115 permit udp any eq snmp any 
ip access-list block_port_open
  statistics per-entry
  10 permit udp addrgroup snmp_server addrgroup connected_route eq snmp 
  20 deny udp any addrgroup connected_route eq snmp 
  30 permit ip any any 
ip access-list ipn
  10 permit icmp 10.0.0.1/32 10.0.0.5/32 
ip access-list sccm
  10 permit ip any 10.252.248.36/32 
ip access-list standard
ip access-list standard-test
  10 permit ip 10.0.0.0/8 10.0.0.0/8 
ip access-list test_acl
  10 permit ip 0.0.0.0 255.255.248.255 any 
class-map type qos match-any EMAIL
  match protocol isis
class-map type qos match-all zulqadar_cp
  match access-group name sccm
policy-map type qos DEMO
  class EMAIL
    police cir percent 10 bc 200 ms conform transmit violate drop
policy-map type qos zulqadar_pm
  class zulqadar_cp
    police cir 100 mbps bc 200 ms conform transmit violate drop
system qos
  service-policy type network-qos test
track 1 ip sla 1 reachability
track 2 ip sla 2 reachability
track 123 ip sla 123 reachability
copp profile strict
vtp domain PKBPNB
bfd echo-interface loopback305
snmp-server location Virtual
snmp-server user cms priv-15 auth md5 216477D5628414D111983055ABAEF60B89EC priv aes-128 057A0CB50F9563F435BD5D5AA9BFF021AE99 localizedV2key
snmp-server user USER network-operator 
snmp-server user admin network-admin auth md5 530147755441582455C59CFC7F939C797515 priv aes-128 00514775AB41582455C59CFC7F939C797515 localizedV2key
snmp-server user admin priv-15
snmp-server user bisto network-operator auth md5 3772EA1C042E42160126937CE830B2AE4A34 priv aes-128 5315BA46DBF78CE1F8CF79FA7DE6713B80F8 localizedV2key
snmp-server user cisco network-operator auth md5 041F6365E7999BD48E795E59CA571C88C283 priv aes-128 2164170B96D893C6DE265115825C4A8BB5F8 localizedV2key
snmp-server user user1 network-operator auth md5 206E1E58A2D161359369B5E2CB9FEA92874E priv aes-128 3339793A8DE508619154F8AACDD1E5DAC21A localizedV2key
snmp-server user baykar network-operator auth md5 3742E4107C2EA712816DA07296BE850F929D priv aes-128 177CAB735E76F04ED8708A0B9BEEC05696CC localizedV2key
snmp-server user ansible network-operator auth md5 167B2E29A69663925B94F437C4D56AD35A57 priv aes-128 49627572D99C5ED40AC0F105C8F73893006B localizedV2key
snmp-server user tacuser network-admin auth md5 330989F995C22F2DD1E2DBF27B1F46DEADC3 priv aes-128 0064CBBFC1C963258790BAA868552F8BBDD5 localizedV2key
snmp-server host 192.168.1.1 traps version 2c test
snmp-server host 192.168.110.25 traps version 2c whatsup
snmp-server host 1.1.1.1 traps version 3 priv PRIV
rmon event 1 log trap public description FATAL(1) owner PMON@FATAL
rmon event 2 log trap public description CRITICAL(2) owner PMON@CRITICAL
rmon event 3 log trap public description ERROR(3) owner PMON@ERROR
rmon event 4 log trap public description WARNING(4) owner PMON@WARNING
rmon event 5 log trap public description INFORMATION(5) owner PMON@INFO
snmp-server community ChapelHill group network-admin
snmp-server community S3cur1ty!XL group network-operator
snmp-server community Durham group network-admin
snmp-server community 3Tm0n1t0r!ng group network-operator
snmp-server community Aing group network-operator
snmp-server community 3Tm0n1t0r!ng use-ipv4acl 99
snmp-server community Aing use-ipv4acl 99
snmp-server community S3cur1ty!XL use-ipv4acl 99
ntp server 1.1.1.1 use-vrf default
ntp server 2.2.2.2 use-vrf default
ntp server 10.5.1.1 use-vrf default
ntp server 132.163.97.5 prefer use-vrf default
ntp source-interface loopback0
ntp logging
aaa authentication login default group ISE_TACACS_REG local 
aaa authentication login console group ISE_TACACS_REG local 
aaa authorization config-commands default group ISE_TACACS_REG local 
aaa authorization commands default group ISE_TACACS_REG local 
aaa authorization config-commands console group ISE_TACACS_REG local 
aaa authorization commands console group ISE_TACACS_REG local 
aaa accounting default group ISE_TACACS_REG local 
system jumbomtu 9192
no logging event link-status default
no errdisable detect cause link-flap
no errdisable detect cause loopback

fabric forwarding anycast-gateway-mac 0000.1111.2222
ip route 0.0.0.0/0 10.1.1.23 1
ip route 0.0.0.0/0 10.100.1.1 1
ip pim rp-address 192.168.18.243 group-list 232.0.0.0/8
ip pim ssm range 232.0.0.0/8
mac address-table multicast 03bf.0a29.2029 vlan 113 interface Ethernet1/59
mac address-table multicast 03bf.0a29.2029 vlan 203 interface Ethernet1/32
vlan 1,12,16,42-43,60,64,69-70,77,88-89,98-99,139,200,204,224,300,400,500,1999,2110-2118,3912
vlan 12
  name lili
vlan 16
  name Dmontoya
vlan 42
  name ANSIBLE_VLAN
vlan 43
  name ANSIBLE_VLAN_43
vlan 64
  name Homero83
vlan 69
  name sandina22
vlan 77
  name paco_villa77
vlan 88
  name test-vlan88
vlan 89
  shutdown
  name test-vlan89
vlan 98
  name tatanl99
vlan 99
  name javier99
vlan 139
  name yisus
vlan 200
  name hugo
vlan 204
  name challenge-204
vlan 300
  name wilson
vlan 400
  name andina
vlan 500
  name diplomado
vlan 1999
  name test_rest
vlan 2110
  name challenge-201

spanning-tree pathcost method long
spanning-tree vlan 1-3967 priority 0
ip prefix-list ANB_WAN_Corp seq 101 permit 192.168.11.0/24 
ip prefix-list ANB_WAN_Corp seq 103 permit 192.168.51.0/24 
ip prefix-list ANB_WAN_IOT seq 101 permit 10.10.2.0/24 
ip prefix-list ANB_WAN_IOT seq 103 permit 10.10.5.0/24 
route-map PBR1 permit 10
  match ip address standard-test 
  set ip next-hop verify-availability 10.0.0.1 track 1
route-map TEEST permit 10
route-map bgp-test permit 10
route-map internet_access permit 10
route-map ipn permit 10
  match ip address ipn 
route-map test permit 10
route-map vv permit 1
route-map vv permit 10
vrf context AZPRV
vrf context CONTROL
  address-family ipv4 unicast
vrf context LULU
  address-family ipv4 unicast
vrf context TENANT
vrf context TENANT1
  vni 50000
  address-family ipv4 unicast
vrf context VRFLITE_VC_HARMONIC
  description VRFLITE_VC_HARMONIC
  ip route 0.0.0.0/0 172.16.200.10 name p2p_OOB_lab
vrf context XANDAR
  vni 5000
  rd auto
  address-family ipv4 unicast
vrf context chemi
  ip route 0.0.0.0/0 Null0
  ip route 1.2.3.4/32 1.1.1.1 track 123
  ip mroute 1.2.3.4/32 1.1.1.1
vrf context ipn
vrf context keepalives
vrf context management
  ip route 0.0.0.0/0 10.10.20.254
vrf context rsr_servidores
  ip route 0.0.0.0/0 172.17.254.5
  ip route 172.16.0.0/16 172.17.254.5
  ip route 172.17.8.0/23 172.17.254.6 10
  ip route 172.17.8.0/23 172.17.254.7 track 1
  ip route 172.17.16.0/24 172.17.254.6 10
  ip route 172.17.16.0/24 172.17.254.7 track 1
  ip route 172.17.30.0/24 172.17.254.6 10
  ip route 172.17.30.0/24 172.17.254.7 track 1
  ip route 172.17.196.0/25 172.17.254.9
  ip route 172.17.201.0/24 172.17.254.9
  ip route 172.17.204.0/24 172.17.254.9
  ip route 172.17.206.0/23 172.17.254.9
  ip route 172.17.212.0/24 172.17.254.9
  ip route 172.17.230.0/24 172.17.254.9
  ip route 172.17.233.0/24 172.17.254.9
  ip route 172.17.243.0/24 172.17.254.9
  ip route 172.20.0.0/16 172.17.254.5
  ip route 172.23.0.0/16 172.17.254.5
  ip route 172.25.0.0/16 172.17.254.5
  ip mroute 172.17.189.0/26 172.17.254.5
vrf context rsr_vn_sda
  ip route 0.0.0.0/0 172.17.250.43
  ip route 1.1.1.1/32 172.17.250.44 10
  ip route 1.1.1.1/32 172.17.250.45 track 2
  ip route 172.17.8.0/21 172.17.250.44 10
  ip route 172.17.8.0/21 172.17.250.45 track 2
  ip route 172.17.189.0/24 172.17.250.44 10
  ip route 172.17.189.0/24 172.17.250.45 track 2
  ip route 172.17.220.0/24 172.17.250.44 10
  ip route 172.17.220.0/24 172.17.250.45 track 2
  ip route 172.17.221.0/24 172.17.250.44 10
  ip route 172.17.221.0/24 172.17.250.45 track 2
lldp reinit 1
port-profile type ethernet Eros
  state enabled
port-profile type ethernet SHUTPORT
  shutdown
  spanning-tree port type normal
port-profile type ethernet sHUTPORT
  state enabled
vlan configuration 113,203
  layer-2 multicast lookup mac

nxapi http port 80


interface Vlan1
  no shutdown
  no ip redirects
  ip address 192.168.250.250/24
  no ipv6 redirects

interface Vlan2
  description TEST_DWDM
  no shutdown

interface Vlan5
  no shutdown

interface Vlan8
  no ip redirects
  no ipv6 redirects

interface Vlan10
  description config con python
  ip address 192.168.10.1/24

interface Vlan11
  description config con python
  no ip redirects
  ip address 192.168.11.1/24
  no ipv6 redirects

interface Vlan12
  description config con python
  ip address 192.168.12.1/24

interface Vlan13
  description config con python
  ip address 192.168.14.1/24

interface Vlan14
  description confg con python
  no shutdown
  no ip redirects
  ip address 192.168.90.1/24
  ipv6 nd managed-config-flag
  no ipv6 redirects

interface Vlan15
  no ip redirects
  no ipv6 redirects

interface Vlan16
  no shutdown
  ip address 192.168.89.23/24

interface Vlan19
  no ip redirects
  no ipv6 redirects

interface Vlan20
  no ip redirects
  no ipv6 redirects

interface Vlan21
  no ip redirects
  no ipv6 redirects

interface Vlan30
  ip router ospf UNDERLAY area 0.0.0.1

interface Vlan33

interface Vlan42
  no ip redirects
  no ipv6 redirects

interface Vlan50
  ip address 172.16.1.111/24

interface Vlan59
  description desde Netmiko VSCode
  no ip redirects
  no ipv6 redirects

interface Vlan77
  no shutdown
  ip address 172.16.1.10/24

interface Vlan88
  description Configured by Ansible
  ip address 10.88.88.88/24

interface Vlan89
  description Configured by Ansible nxos_interfaces
  ip address 10.100.100.89/24

interface Vlan93
  no ip redirects
  no ipv6 redirects

interface Vlan99
  no shutdown
  no autostate
  vrf member LULU
  no ip redirects
  ip address 1.1.1.254/24
  ip address 1.1.1.1/24 secondary use-bia
  fabric forwarding mode anycast-gateway

interface Vlan100

interface Vlan101
  description prod svi - DEMO PLEASE DON'T TOUCH
  no shutdown
  mtu 9192
  vrf member XANDAR
  no ip redirects
  ip address 192.168.23.12/24
  no ipv6 redirects

interface Vlan102
  description dev svi - DEMO PLEASE DON'T TOUCH
  no shutdown
  mtu 9192
  vrf member XANDAR
  no ip redirects
  ip address 10.2.2.1/24 tag 4082018
  no ipv6 redirects

interface Vlan103
  description test svi - DEMO PLEASE DON'T TOUCH
  no shutdown
  mtu 9192
  vrf member XANDAR
  no ip redirects
  ip address 10.2.3.1/24 tag 4082018
  no ipv6 redirects

interface Vlan104
  description security svi - DEMO PLEASE DON'T TOUCH
  no shutdown
  mtu 9192
  vrf member XANDAR
  no ip redirects
  ip address 10.2.4.1/24 tag 4082018
  no ipv6 redirects

interface Vlan105
  description iot svi - DEMO PLEASE DON'T TOUCH
  no ip redirects
  no ipv6 redirects

interface Vlan110
  no ip redirects
  no ipv6 redirects
  hsrp 1 

interface Vlan111
  description TEST_IFname

interface Vlan112
  no ip redirects
  ip address 10.72.240.13/29
  no ipv6 redirects

interface Vlan113
  no ip redirects
  ip address 10.73.148.13/29
  no ipv6 redirects
  vrrp 23
    priority 254
    address 10.73.148.13 

interface Vlan121
  no shutdown
  ip address 10.0.0.1/30

interface Vlan138
  no shutdown
  vrf member VRFLITE_VC_HARMONIC
  no ip redirects
  ip address 172.16.3.225/29
  ip address 172.16.3.233/29 secondary
  vrrp 138

interface Vlan199
  no shutdown
  ip ospf network point-to-point
  ip ospf mtu-ignore
  ip router ospf UNDERLAY area 0.0.0.1

interface Vlan204
  description challenge-204
  no shutdown
  ip address 10.204.204.66/30

interface Vlan300

interface Vlan846
  no ip redirects
  no ipv6 redirects

interface Vlan992
  no ip redirects
  ipv6 address 2001:db8::218:baff:fed8:239d/30
  no ipv6 redirects

interface Vlan2005
  no shutdown
  mtu 9192
  vrf member TENANT1
  no ip redirects
  ip forward
  no ipv6 redirects

interface Vlan2110
  description challenge-201
  no shutdown

interface Vlan3333
  no ip redirects
  ip address 10.1.1.2/29
  ip address 10.1.1.9/29 secondary

interface Vlan3912
  ip address 1.1.1.1/24
  hsrp version 2
  hsrp 3912 
    ip 1.1.1.2
    ip 1.1.1.3 secondary

interface port-channel10
  switchport mode trunk
  spanning-tree guard root

interface port-channel11
  switchport mode trunk
  switchport trunk allowed vlan 100-110

interface port-channel20
  switchport monitor

interface port-channel30
  switchport mode trunk
  switchport trunk native vlan 99
  switchport trunk allowed vlan 99,101

interface port-channel33
  switchport mode trunk
  switchport trunk native vlan 138
  switchport trunk allowed vlan 138-139

interface port-channel100
  switchport mode trunk
  switchport trunk allowed vlan 100-105
  spanning-tree port type edge trunk
  speed 1000

interface port-channel101
  description ***Connection to PKBPNB-SADMZ02 (172.30.177.12) *** 
  switchport mode trunk
  switchport trunk allowed vlan 176-184

interface port-channel119
  switchport access vlan 130

interface port-channel120

interface port-channel153
  switchport mode trunk
  switchport trunk allowed vlan 2

interface port-channel161
  switchport mode trunk
  spanning-tree port type edge trunk

interface port-channel200
  switchport mode trunk
  switchport trunk allowed vlan 100-105
  spanning-tree port type edge trunk
  speed 1000

interface Ethernet1/1
  description Connected to test server
  switchport mode trunk
  spanning-tree port type edge
  service-policy type qos output DEMO
  switchport trunk native vlan 60
  inherit port-profile Eros

interface Ethernet1/2
  description Connected to Router
  switchport access vlan 204
  switchport trunk allowed vlan 2-15
  spanning-tree port type edge
  switchport mode trunk
  inherit port-profile Eros

interface Ethernet1/3

interface Ethernet1/4
  description SLO-BT-DIA
  shutdown
  switchport mode trunk
  switchport access vlan 11
  spanning-tree port type edge

interface Ethernet1/5
  description SLO-BT-DIA
  shutdown
  switchport mode trunk
  switchport trunk native vlan 138
  switchport trunk allowed vlan 138-139
  channel-group 33 mode active

interface Ethernet1/6

interface Ethernet1/7
  description DC1-PA52-FW  (INT)
  no cdp enable
  switchport mode trunk

interface Ethernet1/8
  shutdown
  switchport access vlan 50
  udld aggressive

interface Ethernet1/9
  description config con python
  switchport mode trunk
  switchport trunk allowed vlan 100-105
  spanning-tree port type edge
  speed 1000
  udld aggressive
  channel-group 200 mode active

interface Ethernet1/10
  description config con python
  shutdown
  switchport access vlan 10
  spanning-tree port type edge

interface Ethernet1/11
  switchport mode trunk
  switchport trunk allowed vlan 20

interface Ethernet1/12
  description prueba1902
  switchport mode trunk
  channel-group 10 mode active

interface Ethernet1/13
  description programabilidad
  switchport mode trunk
  channel-group 10 mode active

interface Ethernet1/14
  description prueba1902
  switchport monitor
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/15
  description prueba1902
  switchport monitor
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/16
  description prueba1902
  switchport access vlan 12

interface Ethernet1/17
  description prueba1902
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/18
  description prueba1902
  switchport mode trunk
  switchport trunk native vlan 99
  switchport trunk allowed vlan 99,101
  logging event port link-status
  logging event port trunk-status
  channel-group 30 mode passive

interface Ethernet1/19
  description prueba1902
  switchport mode trunk
  switchport trunk native vlan 99
  switchport trunk allowed vlan 99,101
  logging event port link-status
  logging event port trunk-status
  channel-group 30 mode passive

interface Ethernet1/20
  description prueba1902
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/21
  description prueba1902
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/22
  description prueba1902
  switchport access vlan 12
  spanning-tree port type edge

interface Ethernet1/23
  description eSentire 
  switchport mode trunk
  switchport trunk allowed vlan 176-184

interface Ethernet1/24
  description VERITAS APPLIANCE (Bugno)
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/25
  description Python dude was here
  spanning-tree port type edge

interface Ethernet1/26
  description Bryant- Virtual Connect
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/27
  description DC2-LB
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/28
  description DC2-LB
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/29
  description DC2-LB
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/30
  description Dmytro's description 1

interface Ethernet1/31
  description Dmytro's description 2

interface Ethernet1/32
  description Dmytro's description 3
  spanning-tree port type edge

interface Ethernet1/33
  description Dmytro's description 4
  spanning-tree port type edge

interface Ethernet1/34
  description Dmytro's description 5
  spanning-tree port type edge

interface Ethernet1/35
  description Dmytro's description 6
  spanning-tree port type edge

interface Ethernet1/36
  description Dmytro's description 7
  spanning-tree port type edge

interface Ethernet1/37
  description Dmytro's description 8
  spanning-tree port type edge

interface Ethernet1/38
  description CADIZ-CORP1
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/39
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/40
  switchport mode trunk

interface Ethernet1/41
  description DC1-ACCSW01
  switchport mode trunk

interface Ethernet1/42
  description DC1-ACCSW02
  switchport mode trunk

interface Ethernet1/43
  description DC1-ACCSW03
  switchport mode trunk

interface Ethernet1/44
  description DC1-ACCSW04
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/45
  description DC1-ACCSW05
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/46
  description DC1-ACCSW06
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/47
  description DC1-ACCSW07
  switchport mode trunk
  spanning-tree port type edge

interface Ethernet1/48
  description *** PKBPNB-FW02A Eth1-03 (DMZ) *** 
  shutdown
  switchport mode trunk
  switchport trunk allowed vlan 176
  spanning-tree port type edge
  spanning-tree bpduguard enable
  storm-control broadcast level 0.01

interface Ethernet1/49
  description Mellanox Switches  
  switchport mode trunk

interface Ethernet1/50
  description Mellanox Switches  
  switchport mode trunk

interface Ethernet1/51
  description DC1-CORE02
  switchport mode trunk

interface Ethernet1/52
  description DC1-CORE02
  switchport mode trunk

interface Ethernet1/53
  switchport mode trunk
  switchport trunk allowed vlan 2
  channel-group 153 mode active

interface Ethernet1/54
  switchport mode trunk
  switchport trunk allowed vlan 2
  channel-group 153 mode active

interface Ethernet1/55
  no switchport
  no shutdown

interface Ethernet1/56
  spanning-tree port type edge

interface Ethernet1/57
  spanning-tree port type edge

interface Ethernet1/58
  spanning-tree port type edge

interface Ethernet1/59
  description TO R03
  no switchport
  ip address 198.51.100.1/24
  ip ospf authentication
  ip ospf authentication-key 3 f21a81ab39eff52c
  ip ospf cost 7
  ip ospf network broadcast
  ip router ospf 1 area 0.0.0.0
  no shutdown

interface Ethernet1/60
  no switchport
  ip address 10.0.30.3/24
  no shutdown

interface Ethernet1/61
  switchport mode trunk
  channel-group 161 mode active

interface Ethernet1/62
  switchport mode trunk
  channel-group 161 mode active

interface Ethernet1/63
  description config con python
  spanning-tree port type edge

interface Ethernet1/64
  description config con python
  lacp rate fast
  spanning-tree port type edge

interface mgmt0
  description DO NOT TOUCH CONFIG ON THIS INTERFACE
  vrf member management
  ip address 10.10.20.95/24

interface loopback0
  description tet
  ip address 10.1.2.3/24
  ip address 10.56.72.1/32 secondary

interface loopback1
  description tettest
  ip address 25.25.25.1/32

interface loopback2
  ip address 25.25.25.2/32

interface loopback3
  ip address 25.25.25.3/32

interface loopback4
  ip address 25.25.25.4/32

interface loopback5
  ip address 25.25.25.5/32

interface loopback6
  description config con python
  ip address 6.6.6.6/32

interface loopback7
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback8
  ip address 8.8.8.8/32

interface loopback9
  ip address 9.9.9.9/32

interface loopback10
  ip address 10.10.10.10/32

interface loopback11
  ip address 11.11.11.11/32

interface loopback12
  ip address 12.12.12.12/32

interface loopback13
  ip address 13.13.13.13/32

interface loopback14
  ip address 14.14.14.14/32

interface loopback15
  ip address 15.15.15.15/32

interface loopback16
  ip address 16.16.16.16/32

interface loopback17
  ip address 17.17.17.17/32

interface loopback18
  description TEST_SESSION_LOG

interface loopback19
  ip address 1.2.3.4/24

interface loopback20
  ip address 10.167.223.20/32

interface loopback21
  description My Learning Lab Loopback
  ip address 10.167.223.21/32

interface loopback22
  ip address 22.22.22.22/32

interface loopback23
  ip address 23.23.23.23/32

interface loopback24
  ip address 3.3.3.3/32

interface loopback25
  description Lback 14-2-24
  ip address 25.25.25.25/32

interface loopback26
  ip address 26.26.26.26/32

interface loopback27
  ip address 29.26.26.26/32

interface loopback28
  ip address 1.1.1.28/32

interface loopback30
  description My Learning Lab Loopback YAYAYAYA
  ip address 172.16.30.1/32
  ip router ospf UNDERLAY area 0.0.0.1

interface loopback32
  ip address 1.1.1.32/32

interface loopback33
  description My Learning Lab Loopback33
  ip address 33.99.99.1/24

interface loopback34
  description Full intf config via NETCONF
  ip address 34.99.99.1/24

interface loopback35
  ip address 35.35.35.35/32

interface loopback40
  description *** Created from Netmiko ***
  ip address 10.20.30.5/32

interface loopback43
  description CREATED_BY_ANSIBLE_ROLE

interface loopback44
  ip address 192.168.1.1/24

interface loopback45
  description CONFIGURED_WITH_ANSIBLE_ROLE

interface loopback50
  description My Learning Lab Loopback

interface loopback52
  vrf member ipn
  ip address 10.0.0.5/30

interface loopback53

interface loopback55
  description Full intf config via NETCONF
  ip address 55.55.55.55/32

interface loopback56
  ip address 56.56.56.56/32

interface loopback57
  ip address 57.57.57.57/32

interface loopback58
  ip address 58.58.58.58/32

interface loopback59
  description desde Netmiko VSCode
  ip address 59.59.59.59/32

interface loopback61
  vrf member ipn
  ip address 10.0.0.1/30

interface loopback66
  description Test description for Jenkins test CICD , 3ed ip 80
  ip address 10.66.66.1/24

interface loopback68
  description Test description for Jenkins test CICD , 3ed ip 80

interface loopback70
  vrf member rsr_servidores
  ip address 172.17.254.1/24

interface loopback71
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback73
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback78
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback79
  description Test description for Jenkins test CICD , 3ed ip 81
  ip address 79.79.79.79/32

interface loopback80
  ip address 80.80.80.80/32

interface loopback81
  description My Learning Lab Loopback

interface loopback87
  description ALIONA
  ip address 87.87.87.87/24

interface loopback88
  description Full intf config via NETCONF
  ip address 88.88.88.88/32

interface loopback99
  description Full intf config via NETCONF
  ip address 10.99.99.1/24

interface loopback100
  description DONOT DELETE!! AwesomeSauce
  ip address 192.168.45.1/24

interface loopback101
  ip address 101.101.101.101/24

interface loopback105

interface loopback109

interface loopback110
  ip address 1.1.1.125/32

interface loopback111

interface loopback114

interface loopback115
  ip address 20.1.1.100/24

interface loopback120

interface loopback122

interface loopback123
  description Intf configured via NETCONF
  ip address 123.123.123.123/32

interface loopback125

interface loopback126
  ip address 1.1.1.88/32

interface loopback127
  ip address 10.30.40.3/32

interface loopback130
  ip address 130.130.130.130/32

interface loopback131
  ip address 131.131.131.131/32

interface loopback132
  ip address 132.132.132.132/32

interface loopback133
  ip address 133.133.133.133/32

interface loopback134
  ip address 134.134.134.134/32

interface loopback135
  ip address 135.135.135.135/32

interface loopback136
  ip address 136.136.136.136/32

interface loopback137
  ip address 137.137.137.137/32

interface loopback138
  ip address 138.138.138.138/32

interface loopback139
  ip address 139.139.139.139/32

interface loopback140
  ip address 140.140.140.140/32

interface loopback150
  ip address 150.150.167.14/32

interface loopback151
  ip address 151.151.167.14/32

interface loopback152
  ip address 152.152.167.14/32

interface loopback153
  ip address 153.153.167.14/32

interface loopback154
  ip address 154.154.167.14/32

interface loopback155
  ip address 155.155.167.14/32

interface loopback159
  description Test159

interface loopback160
  description Test 160

interface loopback200
  ip address 192.200.200.200/24

interface loopback201

interface loopback202
  description My Learning Lab Loopback202

interface loopback254
  ip address 10.0.10.2/29
  ip pim sparse-mode

interface loopback300
  description new int 300

interface loopback301
  description got it

interface loopback303
  description My Learning Lab Loopback

interface loopback333
  description Interface added via NETCONF

interface loopback337
  ip address 1.1.1.37/32

interface loopback402

interface loopback552
  ip address 1.1.87.87/32

interface loopback652
  ip address 1.1.1.65/32

interface loopback665
  description My Learning Lab Loopback

interface loopback701
  description lab change

interface loopback707
  description labchange7

interface loopback709

interface loopback722
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback771
  ip address 10.1.1.42/24

interface loopback777
  description Test description for Jenkins test CICD , 3ed ip 80
  ip address 10.12.80.33/24

interface loopback780
  description Test description for Jenkins test CICD , 3ed ip 80
  ip address 10.11.80.33/24

interface loopback781
  description Test description for Jenkins test CICD , 3ed ip 81
  ip address 10.11.81.33/24

interface loopback782
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback788
  description Test description for Jenkins test CICD , 3ed ip 81

interface loopback789
  description Test description for Jenkins test CICD , 3ed ip 81
  ip address 7.7.7.7/32

interface loopback801

interface loopback888
  shutdown
  ip address 8.8.8.8/32

interface loopback996
  ip address 206.206.206.206/32

interface loopback999
  description ABA
  vrf member LULU
  ip address 10.10.10.10/32

interface loopback1000
  ip address 100.100.10.100/32

interface loopback1001
  ip address 1.1.1.1/32

interface loopback1002
  ip address 10.167.223.15/32

interface loopback1003

interface loopback1004

interface loopback1005

interface loopback1006

interface loopback1007

interface loopback1011
  description ABA
  ip address 192.168.11.1/32

interface loopback1013
  ip address 1.1.1.13/32

interface loopback1021
  ip address 1.1.1.236/32

interface loopback1022
  ip address 1.1.1.4/32

interface loopback1023
  ip address 1.1.1.254/32
icam monitor scale

cli alias name sir sh ip int br
line console
  exec-timeout 0
  terminal width  511
line vty
  session-limit 15
boot nxos bootflash:/nxos64-cs.10.3.3.F.bin 
router eigrp 10
router ospf 1
  router-id 192.0.2.1
  area 0.0.0.3 stub no-summary
router ospf 10
router ospf 100
router ospf 1010
router ospf 12
  router-id 12.12.12.12
router ospf 2028
router ospf 204
router ospf 26
router ospf 34
  router-id 33.44.85.21
router ospf 999
  router-id 9.9.9.9
router ospf CONTROL
  vrf CONTROL
    bfd
router ospf UNDERLAY
  area 0.0.0.1 range 172.16.30.0/24
router bgp 65535
  router-id 172.16.0.1
  timers prefix-peer-timeout 30
  address-family ipv4 unicast
    network 172.16.0.0/16
  neighbor 172.16.0.2
    remote-as 65535
  vrf AZPRV
    neighbor 169.254.10.26
      bfd
      remote-as 12076
      description test
      address-family ipv4 unicast
        soft-reconfiguration inbound always
  vrf LULU
    address-family ipv4 unicast
      network 1.1.1.0/24
      network 1.1.1.1/32
grpc gnmi max-concurrent-calls 16
grpc gnmi subscription query-condition keep-data-timestamp
grpc use-vrf default
grpc certificate gnmicert
grpc client root certificate my_client_trustpoint
event manager applet Backup
  action 1.0 syslog msg copy run to server
  action 1.1 cli enable
  action 2.0 cli copy runn tftp://10.1.1.19/sw-config
event manager applet myapp
  event cli match "sh int lo300"
  action 1 cli command " sh int lo1"
monitor session 1 
  source interface Ethernet1/52 both
  destination interface Ethernet1/14
  no shut
monitor session 2 
  source interface Ethernet1/52 both
  destination interface Ethernet1/15
  no shut
monitor session 10 
  source interface Ethernet1/50 both
  source interface Ethernet1/51 both
  destination interface port-channel20

ip sla 1
  icmp-echo 169.254.10.26 source-interface Ethernet1/11.11
ip sla schedule 1 life forever start-time now
ip sla 2
  icmp-echo 172.17.250.45
    vrf rsr_vn_sda
    frequency 10
ip sla schedule 2 life forever start-time now
ip sla 3
  icmp-echo 172.17.250.46
    vrf rsr_vn_sda
    frequency 10
ip sla schedule 3 life forever start-time now
ip sla 61
  icmp-echo 10.0.0.5 source-ip 10.0.0.1
    request-data-size 9122
    vrf ipn
    tag ipn
    frequency 5
ip sla schedule 61 life forever start-time now
ip sla 123
  icmp-echo 1.1.1.1
    vrf chemi
    frequency 10
ip sla schedule 123 life forever start-time now
logging server 1.1.1.1 use-vrf management
logging server 10.10.20.175
logging server 2.2.2.3 7 port 25199
logging source-interface loopback0
no logging console


scheduler job name Testing_Ansible
  python bootflash:/test
  
end-job

telemetry
  destination-group DST-GRP
    ip address 10.10.20.51 port 57000 protocol gRPC encoding GPB 
    use-vrf management
  sensor-group SNSR-GRP
    data-source YANG
    path Cisco-NX-OS-device:System/procsys-items
  sensor-group sensor-group-name
  subscription 101
    dst-grp DST-GRP
    snsr-grp SNSR-GRP sample-interval 10000
  subscription 102
    dst-grp DST-GRP
    snsr-grp SNSR-GRP sample-interval 10000

testsandbox# 