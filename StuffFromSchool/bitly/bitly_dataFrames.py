# -*- coding: utf-8 -*-
"""
Created on Tue Sep 19 20:00:30 2017

@author: nbt264

Import the bitly data and do some analysis of its contents
"""

#import JavaScript Object Notation
import json

#Provide a relative path to the input file
path = "usagov_bitly_data.txt"

#Create a handle for the input file, open and prep to read
fileIn = open(path)

"""
The following is a list comprehension -- a method of applying an action across all items in a collection of objects

Iterating over the open file handle produces a sequence of lines. Those lines are then created as objects and stored as a list collection of dictionaries 
"""
records = [json.loads(line) for line in fileIn]

print("Just one record to check:\n", records[:1],"\n")

"""
We have data, now we need to be able to work with it.
We'll create a DF from the records List collection
"""

from pandas import DataFrame, Series
import pandas as pd

"""
We'll use pandas to do computations like counting/tallying
pandas relies on vector-processing for its speed.
"""

frame = DataFrame(records) # build the DF from the input


#Let's see what we have now

print("\n", frame.info())

#Let's look at timezones(tz) for the first 10 objects in the DF

print("\n\nFirst 10 Time Zone Values")
print(frame['tz'][:10])

"""
Let's count up the occurrences of the various values for the 'tz' key
The result of this will be a series -- a 1-D array with axis labels. The axis label will be 'tz' and the count of each will be the 'data' portion
"""

tz_counts = frame['tz'].value_counts() #produced a series
print("\n\nFrom the Time Zone Series")
print(tz_counts)

print("\n\nThe occurrence count for Warsaw:", tz_counts['Europe/Warsaw'])

"""
Let's produce a plot for the most-used time zones. The 'blank' zone falls into this group - we need to do something with them. So, we're going to replcae those values. This will produce cleaner data and allow for an accurate analysis
"""

clean_tz = frame ['tz'].fillna('Missing') #replaces NaN entries
print("\n\nFirst Pass\n", clean_tz, "\n")

"""
We fixed the "NaN" entries. Now we need to clean the blank String values.
"""

clean_tz[clean_tz == ''] = "Unknown"

print("Second Pass:\n", clean_tz, "\n")

"""
Now, we want to re-count occurrences with the scrubbed data
"""
tz_counts = clean_tz.value_counts()

print(tz_counts[:10])

"""
Now that the data has been scrubbed, and recounted, we can create a plot to help visualize what it all may mean.
We'll use a simple horizontal bar plot...
"""
tz_counts[:10].plot(kind="barh", rot=0)

print("""
This is a test
that I want you to know""")