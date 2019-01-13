# -*- coding: utf-8 -*-
"""
Created on Tue Nov 28 19:57:47 2017

@author: nbt264

This code will do some simple analysis of a single email
"""
from email.parser import BytesParser
from email.policy import default

#open the file containing the raw email
with open("TestEmail.txt", 'rb') as inFile: # rb= read bytes
    headers = BytesParser(policy=default).parse(inFile)
    
#Extract the recipient's email address
print("To: {}".format(headers["to"]))

#Extract the sender's email
print("From: {}".format(headers["from"]))

#extract the subject
print("Subject: {}".format(headers["subject"]))

