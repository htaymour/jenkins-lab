import paramiko
import time
import sys
import subprocess
from getpass import getpass
from datetime import datetime


paramiko.util.log_to_file("connection.log")

file_path = r"./psatlog.dll"
directory = os.path.dirname(file_path)
fileexist = os.path.isfile(file_path)
#print directory
#print os.path.exists(directory)
#print fileexist

def clear_buffer(connection):
    buff = ""
    while connection.recv_ready():
        buff = buff + connection.recv(99)
    return(buff)
        
         
            