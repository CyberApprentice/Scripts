# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 20:16:54 2017

@author: nbt264

Demonstrate direct read of an excel sheet
"""

import pandas as pd

xlsx_file = pd.ExcelFile('NW_Customers.xlsx')

#Pull the specific sheet into a DF 
cust_df = xlsx_file.parse('Customers')

print(cust_df, "\n\n")

print(cust_df.info(), "\n\n")

print(cust_df['Company'])

print('\n\n', cust_df[:1])