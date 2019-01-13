# -*- coding: utf-8 -*-
"""
Created on Thu Aug 31 20:13:28 2017

@author: nbt264

Explore some Python data types

BLOCK COMMENT -- three sets of double quotes
"""

#Single line/inline comments use #

reallyReallyLongString = '''This will be a very long string that
will run over serveral lines and I will keep typing 
until I feel like stopping'''

print(reallyReallyLongString)

"""
    Some other data types....
"""

anInterger = 225
aFloat = 39.652     #64 - bit percision
aBoolean = True
aComplexNumber = 1.0359e3

print(anInterger, aFloat, aBoolean, aComplexNumber)

"""
    Type conversions
"""
print("\nType Conversion")
print(int(aBoolean))
print(float(aBoolean))
print(int(aComplexNumber))  #This loses precision

"""
    All python data management is by reference
    
    All assignments of one variable name to another name are direct.
     No copies are made this way!
"""

print("\n\nData Managements in Python if by reference!")
A = [1,2,5]
print("List A: ", A)
B = A
print("List B: ", B)
A.append(4)
print("List A: ", A)
print("List B: ", B)

"""
    Python allows for multiple assignemnt...
     This is a handy shortcut, when it's not confusing
"""

p, q, r = 10,20,30
print(p,q,r)

"""
    Just as in Java, we can ask an object what its type is...
"""

print("\n\nA is: ", type(A))
print("\np is: ", type(p))
print("\naComplexNumber is: ", type(aComplexNumber))

