# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 19:35:35 2017

@author: nbt264

Interacting with Databases
"""

import pandas as pd
from pandas import DataFrame
import sqlite3

query = """
CREATE TABLE test
(City VARCHAR(20), State VARCHAR(20),
Pop REAL, Code INTEGER
); """

con = sqlite3.connect(":memory:")
con.execute(query)
con.commit()

"""
Insert a few rows of data
"""
data = [("Atlanta", "Georgia", 1.25, 13),
        ("Tallahassee", "Florida", 2.6, 12),
        ("Sacramento", "California", 1.7, 6)]
stmt = "INSERT INTO test VALUES(?,?,?,?)"

con.executemany(stmt, data)
con.commit()

"""
Data from a DB table is usually returned as a tuple - immutable data - when selecting.
"""

cursor = con.execute("select * from test")
rows = cursor.fetchall()

for one in rows: 
    print(one)
    
"""
We can load the returned tuples into a DF for processing
But we'll need column names
"""

print(cursor.description)

allNames = cursor.description
collNames = []

for name in allNames:
    print(name[0])
    collNames.append(name[0])
print('\n\n', collNames) #Just to check

df_test = DataFrame(rows, columns=collNames)
print('\n\nThe rows in the DF')
print(df_test)

"""
There's a shorter way
"""

df_easy = pd.read_sql("select * from test", con )
print('\n\nTable read directly into DF')
print(df_easy)

