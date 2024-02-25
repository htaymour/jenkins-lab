# start of the CD pipeline which will choose which script to apply in order to complete the deployment of the pipeline.
import sys
import os
import time
import paramiko
import difflib
# import conf_control
conf = []

class Ticket:
    def __init__(self, ticket_number, ccrfile, device_name, requestor, configuration):
        self.ticket_number = ticket_number
        self.ccrfile = ccrfile
        self.device_name = device_name
        self.requestor = requestor
        self.configuration = configuration
    def prt(self):
            print ("Ticket Number: " + self.ticket_number +
            "\nCCR File: " + self.ccrfile +
            "\nDevice Name: " + self.device_name +
            "\nRequestor: " + self.requestor +
            "\nConfiguration: " + "".join(self.configuration))
    def __str__(self):
            print ("Ticket Number: " + self.ticket_number +
            "\nCCR File: " + self.ccrfile +
            "\nDevice Name: " + self.device_name +
            "\nRequestor: " + self.requestor +
            "\nConfiguration: " + "".join(self.configuration))
    # Example usage:
    # CCR = Ticket(
    #     ticket_number='12345',
    #     ccrfile='CCR12345.txt',
    #     device_name='Router01',
    #     requestor='John Doe',
    #     configuration='Interface configuration for Router01'
    # )

class connector:
    def __init__(self, ticket):
        self.ticket = ticket
        self.hostname = ticket.device_name
        self.username = 'admin'  # Replace with the appropriate username
        self.password = 'Admin_1234!'  # Replace with the appropriate password
        self.client = paramiko.SSHClient()
        self.client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    def connect(self):
        try:
            self.client.connect(hostname=self.hostname, username=self.username, password=self.password)
            self.ssh_shell = self.client.invoke_shell()
            time.sleep(1)  # Wait for the shell to be ready
            self.ssh_shell.send('\n')
            time.sleep(1)  # Wait for the initial prompt
            print (self.ssh_shell.recv(65535).decode('utf-8'))
            return True
        except paramiko.SSHException as e:
            print(f"Connection failed: {e}")
            return False

    def apply_configuration(self):
        if self.ssh_shell :
            try:
                configuration = ["conf t\n"] + self.ticket.configuration + ["end\n", "wr\n"]
                for command in configuration:
                    self.ssh_shell.send(command)
                    time.sleep(1)  # Wait for the command to be processed
                    while not self.ssh_shell.recv_ready():
                        time.sleep(1)
                    output = self.ssh_shell.recv(65535).decode('utf-8')
                    print(output)  # Optionally print the output
                return True
            except paramiko.SSHException as e:
                print(f"Failed to apply configuration: {e}")
                return False


    def show_run(self):
        if self.ssh_shell :
            try:
                self.ssh_shell.send('term len 0\n')
                time.sleep(1)  # Wait for the command to be processed
                self.ssh_shell.send('show running-config\n')
                time.sleep(5)  # Wait for the command to be processed
                output = ""
                while not self.ssh_shell.recv_ready():
                    time.sleep(1)
                while self.ssh_shell.recv_ready():
                    output += self.ssh_shell.recv(65535).decode('utf-8')
                    time.sleep(0.5)  # Wait for more data
                # print(output)  # Optionally print the output
                return output
            except paramiko.SSHException as e:
                print(f"Failed to retrieve running configuration: {e}")
                return None


# Example usage:
# ... (create a Ticket object and pass it to the connector)


# Example usage:
# ... (existing code)

# connector = NetworkDeviceConnector(ccr)
# running_config = connector.show_running_config()
# if running_config:
#     print("Running Configuration:\n", running_config)




# Example usage:
# ccr = Ticket(
#     ticket_number='12345',
#     ccrfile='path/to/config/file.txt',
#     device_name='192.168.1.1',
#     requestor='John Doe',
#     configuration=['conf t', 'interface GigabitEthernet0/1', 'description Configured by script', 'end']
# )





def compare_configs(config1, config2):
    config1_lines = config1.splitlines(keepends=True)
    config2_lines = config2.splitlines(keepends=True)
    
    diff = difflib.unified_diff(config1_lines, config2_lines, fromfile='config1', tofile='config2', lineterm='')
    
    return ''.join(diff)
    # Example usage:
    # config_a = """interface GigabitEthernet0/1
    #  description Configured by script
    #  ip address 192.168.1.1 255.255.255.0
    # """

    # config_b = """interface GigabitEthernet0/1
    #  description Updated by script
    #  ip address 192.168.1.2 255.255.255.0
    # """



def parse_ccr(data):
    global ticket,device,requester,type,conf
    for n,info in enumerate(data):
        if "change request" in info.lower() : 
            print ("Change file title      : Configuration chnage request")
        if "ticket" in info.lower() : 
            ticket = info.split(':')[1].strip()
            print ("ticket number          : " + str(ticket ))        
        if "requester" in info.lower() : 
            requester = str(info.split(':')[1].strip().lower())
            print ("Change requestor name  : " + requester )
        if "device" in info.lower() : 
            device = str(info.split(':')[1].strip().lower())
            print ("device name            : " + device )
        if "change type" in info.lower() : 
            type = str(info.split(':')[1].strip().lower())
            print ("Change type            : " + type )
            change_data = data[n+1:]
            break
        

    # print (change_data.split('interface name : '))

    if "interface" in type :       # interface change request
        print ( "interface change configuration procedure : ")
        for n,info in enumerate(change_data):
            if "name" in info.lower() : conf.append ('interface ' + info.split(':')[1].strip()+'\n')
            # if "parameters" in info.lower() : conf.append ('\n')
            if "type" in info.lower() : conf.append ('switchport mode ' + info.split(':')[1].strip() + '\n')
            if "vlans" in info.lower() : conf.append ('switchtrunk allowed vlans add  ' + info.split(':')[1].strip() + '\n')
            if "speed " in info.lower() : conf.append ('speed ' + info.split(':')[1].strip() + '\n')
            if "description " in info.lower() : conf.append ('description ' + info.split(':')[1].strip() )
            if "ip address" in info.lower() : conf.append ('ip address ' + info.split(':')[1].strip() + '\n')
            if "vlan " in info.lower() :                        # access type adding vlan and port securty and qos for access interfaces
                conf.append ('switchport ' + '\n')
                conf.append ('switchport mode access vlan ' + info.split(':')[1].strip() + '\n')
                conf.append ('switchport port-security ' + '\n')
                conf.append ('switchport port-security maximum 3' + '\n')
                conf.append ('switchport port-security maximum 2 vlan access' + '\n')
                conf.append ('switchport port-security aging time 2' + '\n')
                conf.append ('switchport port-security violation restrict' + '\n')
                conf.append ('priority-queue out ' + '\n')
                conf.append ('mls qos cos override ' + '\n')
                conf.append ('spanning-tree portfast ' + '\n')
                conf.append ('spanning-tree bpduguard enable' + '\n')

    elif "vlan add" in type :      # vlan addition change request
        print ( "vlan addition procedure : ")
        for n,info in enumerate(change_data):
            if "vlan" in info.lower() : conf.append ('vlan ' + info.split(':')[1].strip()+'\n')
            if "name" in info.lower() : 
                conf.append ('name  ' + info.split(':')[1].strip() + '\n')
                conf.append ('exit  ' + '\n')

            
    if len(conf) == 0 : 
        print ('no config matching change aborting ')
        exit

        # Another way
        # conf = []
        # command_mapping = {
        #     "name": "interface {}",
        #     "type": "switchport mode {}",
        #     "vlans ": "switchtrunk allowed vlans add {}",
        #     "speed": "speed {}",
        #     "description": "description {}",
        #     "ip address ": "ip address {}",
        #     "vlan ": [
        #         "switchport",
        #         "switchport mode access vlan {}",
        #         "switchport port-security",
        #         "switchport port-security maximum 3",
        #         "switchport port-security maximum 2 vlan access",
        #         "switchport port-security aging time 2",
        #         "switchport port-security violation restrict",
        #         "priority-queue out",
        #         "mls qos cos override",
        #         "spanning-tree portfast",
        #         "spanning-tree bpduguard enable"
        #     ]
        # }

        # for info in change_data:
        #     info_lower = info.lower()
        #     for keyword, command in command_mapping.items():
        #         if keyword in info_lower:
        #             value = info.split(':')[1].strip()
        #             if isinstance(command, list):
        #                 for cmd in command:
        #                     conf.append(cmd.format(value) if '{}' in cmd else cmd + '\n')
        #             else:
        #                 conf.append(command.format(value) + '\n')

        # # The 'conf' list now contains the formatted configuration commands
        #print ("Configuration preparation to apply for the change :\n\n" + "".join(conf)+'\n\n\n\n')
        return ()


print ("HELLO WORLD FROM DOCKER CONTANER DEPLOPY SERVER !")
file_path = str(sys.argv[-1])
if len(sys.argv) > 1 : print ("working change request filename  :" +  file_path)
if not (os.path.isfile(file_path)) : exit
f = open (file_path,"r")
data =  f.readlines()
print ("Start parsing change request in pipe to determine the CD script path")
x = parse_ccr (data)

# Preparing ticket :
ccr = Ticket(ticket_number=ticket,
            ccrfile=file_path,
            device_name=device,
            requestor=requester,
            configuration=conf    )    
        

print(' * Preparing ticket information below for entering pipe :  \n' )
ccr.prt()
conn = connector(ccr)                 # Init 
conn.connect()                        # Connect to device
pre_config = conn.show_run()          # Get current configuration
success = conn.apply_configuration()  # Apply configuration to device
post_config = conn.show_run()
diff_result = compare_configs(pre_config, post_config)
print('\n\n\n\n\n\n ================ CHANGE IN CONFIGURATION BEFORE AND AFTER COMMIT ' + diff_result)



# Prechecks : 





      
    