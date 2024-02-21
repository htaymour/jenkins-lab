# start of the CD pipeline which will choose which script to apply in order to complete the deployment of the pipeline.
import sys

print ("HELLO WORLD FROM DOCKER CONTANER DEPLOPY SERVER !")
if len(sys.argv) > 1 : print (sys.argv[-1]) 