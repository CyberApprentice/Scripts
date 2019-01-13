# -*- coding: utf-8 -*-
"""
Created on Thu Nov  2 19:47:40 2017

@author: nbt264

What about missing data items?
"""

import pandas as pd
from pandas import Series, DataFrame
import numpy as np

string_data = Series(['aardvark', 'artichoke', np.nan, 'avocado'])

print(string_data, "\n")

string_data[0] = None

print(string_data.isnull(), "\n")

"""
One of our options for missing data is to drop the missing data...
we can remove individual entries, or rows, or columsn (in a DF)
"""

from numpy import nan as NA

data = Series([1, NA, 3.5, NA , 7])

print(data, "\n")

print(data.dropna(), "\n")

data2 = data.dropna()
print(data2, "\n")

"""
in DF, we need to decide what/how much we want to drop for null values.
the defautlt is drop whole rows for even individual NaN values
"""

dataf= DataFrame([[1.0, 6.5, 3], [1.0, NA, NA],
                   [NA, NA, NA], [NA, 6.5, 3.0]])
print(dataf, "\n")                   

cleaned = dataf.dropna()
print(cleaned, "\n")

cleaned2 = dataf.dropna(how='all')
print(cleaned2, "\n")