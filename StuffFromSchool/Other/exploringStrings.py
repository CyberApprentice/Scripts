# -*- coding: utf-8 -*-
"""
Created on Thu Aug 31 19:38:38 2017

@author: nbt264
"""

#Continuing a String
myString = "Roses are red \
and Violets are blue."

print(myString)

#Implicit continuation
aListOfNumbers = [25,50,75,100,
                  125,150,175,200,
                  225,250,275,300]
print(aListOfNumbers)

"""
    String are treated as sequences. "Items" in the 
      String (chars) may be accessed by index. Keep
      in mind that indexing starts with zero.
"""

longString = "supercalifragilisticexpialidocious"

print("\nHow long is the string? ",
       len(longString))
print("The tenth letter is: ",
      longString[9])
print("This is the substring from 21 to 30: ",
      longString[20:30])
print("The first five characters: ",
      longString[:5])
print("The last five characters: ",
      longString[len(longString)-5:])

"""
    We can concatenate String in Python
"""

newLongString = myString + longString
print(newLongString)

"""
    We can repeat data to build a String
"""
muchLonger = longString*3
print(muchLonger)

"""
