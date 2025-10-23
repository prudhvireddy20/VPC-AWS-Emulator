from netmiko import ConnectHandler

device = {
    'device_type': 'cisco_ios',
    'ip': '192.168.56.101',
    'username': 'admin',
    'password': 'admin'
}

conn = ConnectHandler(**device)
output = conn.send_command("show ip bgp summary")
print(output)
