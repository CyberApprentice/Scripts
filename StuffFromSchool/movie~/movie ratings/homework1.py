# -*- coding: utf-8 -*-
"""
Created on Thu Oct  5 14:32:36 2017

@author: Trevon
"""

"""
This python script will read in three related, comma separated value files,
merge the three files on common data values, and the print out the 
first few lines of the resulting (merged) DataFrame.
"""

import pandas as pd
import csv
"""
Create a DataFrame to hold base order info
"""
# build a List of column names for the dataset
order_cols = [ 'order_nbr', 'cust_nbr', 'order_dt'  ]

# read the data into a DataFrame, specify separators & assign
#   the List order_cols for the column names
orders = pd.read_table( 'orders.csv', sep=',', 
                       header=None, names = order_cols,
                       engine= 'python' )

"""
Create a DataFrame to hold order line item info
"""
order_lines_cols = [ 'order_nbr', 'isbn', 'qty', 'cost' ]
order_lines = pd.read_table( 'order_lines.csv', sep=',', 
                            header=None, names =  order_lines_cols, engine='python')

"""
Create a DataFrame to hold book info
"""                
books_cols = [ 'isbn', 'author', 'title', 'publisher', 'pub_yr' ]
books = pd.read_table( 'books.csv', sep=',', 
                      header=None, names=books_cols,engine='python')

"""
Let's check to be sure each DataFrame was created properly....
"""             
print( orders.info( ) )
print( order_lines.info( ))
print( books.info( ) )
print("hi-------------------")
orders_order_lines = pd.merge(orders, order_lines)
xtnd_orders = pd.merge(orders_order_lines, books)
print("\n\nMerged Data info")
print("\n\n", xtnd_orders.info())
print("hi-------------------")
#print("\n\n", xtnd_orders)
print("hi-------------------")