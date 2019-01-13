# -*- coding: utf-8 -*-
"""
Created on Tue Nov 28 19:43:45 2017

@author: nbt264
"""
#sending email directly from python
import smtplib
from email.message import EmailMessage

#Build an empty emailmessage object
msg = EmailMessage()

#add text to the email
msg.set_content("This is a short email.")

#add the subject
msg["Subject"] = "The contents of our message"

#add the recipent
msg["To"] = "terri.davis@utsa.edu"

#add the sender
msg["From"] = "vto747@my.utsa.edu"

myHost = smtplib.SMTP('localhost')

myHost.send_message(msg)
myHost.quit()
