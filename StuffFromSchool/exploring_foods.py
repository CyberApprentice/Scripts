# -*- coding: utf-8 -*-
"""
Created on Thu Sep  7 19:46:55 2017

@author: nbt264

Use JSON to work with data extracted from the USDA Foods Database
"""

import json
from pandas import DataFrame

# pull the raw data into a database using json
db = json.load(open("foods-2011-10-03.json"))

# Let's look at some of the data
print("\nDatabase contains:", len(db), "rows")

"""
    Each row in our database is a dictionary structure.
    The nutrients field is a list of dictionaries
     one dictionary set/pair for every nutrient listed
"""
#list dictionary keys for entry 0
print ("\n\n", db[0].keys())

# list dictionary at 0 from the nutrients group
print ("\n\n", db[0]["nutrients"] )

#create a Dataframe of the nutrient group of dictionaries from entry 0
nutrients = DataFrame(db[0]["nutrients"])

print ("\n\n The nutrients DataFrame for", 
       db[0]["description"] )
print (nutrients)

"""
    We don't need all that info for 6k+ entries
    So, let's build a new sleeker DataFrame
"""

# Create a list of the keys we want to extract

info_keys = ["description", "group", "id", "manufacturer"]

# Use the list of keys to extract the 'columns'

info = DataFrame(db, columns=info_keys)
print("\n\nSelected columns, all db Entries")
print(info)