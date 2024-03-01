import sys
import os
import shutil


print ("Start copy task in preparing container ")
file_path = str(sys.argv[-1])
if len(sys.argv) > 1 : print ("working change request filename  :" +  file_path)
if not (os.path.isfile(file_path)) : exit
print (" coping required files needed" + file_path)
path = os.system('pwd')
print (path)
os.system('\ncd ..\ncd ccr')
shutil.copy(file_path , path + file_path)

# source_file_path = path 
# source_file = open(source_file_path, 'rb')
# destination_file_path = '/Users/nikpi/Desktop/file.py'
# destination_file = open(source_file_path, 'wb')

# shutil.copyfileobj(source_file, destination_file) 
