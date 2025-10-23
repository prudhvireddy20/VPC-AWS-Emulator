from netmiko import ConnectHandler

r1 = {
    'device_type': 'cisco_ios',
    'ip': '192.168.56.101',  # EVE/GNS3 R1 IP
    'username': 'admin',
    'password': 'admin'
}

r2 = {
    'device_type': 'cisco_ios',
    'ip': '192.168.56.102',  # R2 IP
    'username': 'admin',
    'password': 'admin'
}

commands_r1 = [
    "conf t",
    "int g0/0",
    "ip address 10.1.1.1 255.255.255.252",
    "no shut",
    "router bgp 65001",
    "neighbor 10.1.1.2 remote-as 65002",
    "end"
]

commands_r2 = [
    "conf t",
    "int g0/0",
    "ip address 10.1.1.2 255.255.255.252",
    "no shut",
    "router bgp 65002",
    "neighbor 10.1.1.1 remote-as 65001",
    "end"
]

for dev, cmds in zip([r1, r2], [commands_r1, commands_r2]):
    net_connect = ConnectHandler(**dev)
    output = net_connect.send_config_set(cmds)
    print(f"\nConfiguration for {dev['ip']}:\n", output)
