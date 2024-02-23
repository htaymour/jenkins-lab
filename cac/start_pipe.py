# start of the CD pipeline which will choose which script to apply in order to complete the deployment of the pipeline.
import sys
import os

print ("HELLO WORLD FROM DOCKER CONTANER DEPLOPY SERVER !")
file_path = str(sys.argv[-1])
if len(sys.argv) > 1 : print ("working change request filename  :" +  file_path)
if not (os.path.isfile(file_path)) : exit

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
ticket = Ticket(
    ticket_number='12345',
    ccrfile='CCR12345.txt',
    device_name='Router01',
    requestor='John Doe',
    configuration='Interface configuration for Router01'
)


f = open (file_path,"r")
data =  f.readlines()
print ("Start parsing change request in pipe to determine the CD script path")




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
conf = []

if "interface" in type :       # interface change request
    print ( "interface change configuration procedure : ")
    for n,info in enumerate(change_data):
        if "name" in info.lower() : conf.append ('interface ' + info.split(':')[1].strip()+'\n')
        # if "parameters" in info.lower() : conf.append ('\n')
        if "type" in info.lower() : conf.append ('switchport mode ' + info.split(':')[1].strip() + '\n')
        if "vlans" in info.lower() : conf.append ('switchtrunk allowed vlans add  ' + info.split(':')[1].strip() + '\n')
        if "speed " in info.lower() : conf.append ('speed ' + info.split(':')[1].strip() + '\n')
        if "vlan " in info.lower() :                        # access type adding vlan and port securty and qos for access interfaces
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

print ("Configuration preparation to apply for the change :\n\n" + "".join(conf))

# Preparing ticket :
ccr = Ticket(ticket_number=ticket,
             ccrfile=file_path,
             device_name=device,
             requestor=requester,
             configuration=conf    )    
        

#   print(' * Preparing ticket information below for entering pipe :  \n' + ccr.__str__)
      
    