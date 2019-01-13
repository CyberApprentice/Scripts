# -*- coding: utf-8 -*-
"""
Created on Thu Nov  2 19:34:56 2017

@author: nbt264
"""

import pandas as pd
from pandas import Series, DataFrame
import numpy as np

"""
A series is similar to a 1D array

It contains an array of data (any numpy) and an associated array of data labels - an index
"""

string_data = Series(['aardvark', 'artichoke', 'asymetrical', 'avocado'])

print(string_data, "\n")
print(string_data[1], "\n")

#Add definitions for index values
string_data = Series([ 'aardvark', 'artichoke', 'asymetrical', 'avocado'], index = ['one', 'two', 'three', 'four'])
print(string_data, "\n")
print(string_data['three'], "\n")


"""
Series are similar to dicts. we can use a dictionary to create a Series
"""

state_dict= {'Ohio': 35000, 
             'Texas': 71000,
             'Oregon': 16000,
             'Utah':5000}
state_Series = Series(state_dict)

print(state_Series, '\n')
print(state_Series['Texas'], "\n")
