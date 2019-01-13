# -*- coding: utf-8 -*-
"""
Created on Thu Sep 14 19:43:06 2017

@author: nbt264
"""

from pandas import DataFrame
import pandas as pd
import numpy as np

#a dict (dictionary) of 3 equal-length lists
data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada'], 
        'year': [2000, 2001,2002,2001,2002] ,
        'pop': [1.5, 1.7, 3.6, 2.4, 2.9]
        }

# build a dataframe based on the dict

frame = DataFrame(data)
print(frame)          

"""
    We can specify the order of the columns in the DF
"""
reordered = DataFrame(data, columns=['state', 'year', 'pop', 'debt'],
                      index=['one', 'two', 'three', 'four', 'five'] )
                      
print ("\n\nReordered DF based on data")
print(reordered)

"""
The data in a column can be retreived as a series using either 'dict' notation or by attribute
"""

print("\n\ndict Notation: ")
print(reordered['state'])

print("\nBy Attribute: ")
print(reordered.year)


"""
We can also extract individual rows of data
"""
print("\nIndex 'three'") 
print(reordered.ix['three'])

"""
We can alter the data in the DF
"""

reordered['debt'] = 16.5 

print("\n", reordered)

reordered['debt'] = np.arange(5.)
print("\n", reordered)

"""
We will recreate the DataFrame using a slightly different structure - this will be a dict containing dicts
"""

dict_of_dicts = {'Nevada': {2001:2.4, 2002:2.9},
                 'Ohio': {2000:1.5, 2001:1.7, 2002:3.6} }

frame2 = DataFrame(dict_of_dicts)
print ("\n\nDF from a Dictionary of Dictionaries")
print(frame2)

print("\nThe DataFrame Transposed")
print(frame2.T)

frame2.index.name = 'year'
frame2.columns.name = 'state'
print("\n\n")
print(frame2)                   

print(frame2.values) 

