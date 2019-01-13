# -*- coding: utf-8 -*-
"""
Created on Tue Sep  5 20:28:38 2017

@author: nbt264

An introduction to the "Wayback machine"
"""

import webbrowser # class that holds/describes a browser
import json       # JavaScript Object Notation
from urllib.request import urlopen

print("Let's find an old website" )
site = input("Type a website URL: ")
era = input("Type a year, month, and day like: 20170905")

# combine the user inputs into a full url for the Wayback machine
url = "http://archive.org/wayback/available?url=%s&timestamp=%s" % (site,era)

# create a 'response' object to hold the answer to our request

response = urlopen(url) 
# create a content object using the results of read
contents = response.read()
#create a test object based on the method decode
text = contents.decode("utf-8")
# Use those results to create a data object
data = json.loads(text)

# Begin a 'try' block
try:
    #try to open the archived site
    old_site = data["archived_snapshots"]["closest"]["url"]
    print("Found it: ", old_site)
    print("It should appear in the default browser now")
    webbrowser.open(old_site)
except:
    # if there was an issue with finding or opening the old site
    print("Sorry, no luck finding that site.")
    
    