# -*- coding: utf-8 -*-
"""
Created on Tue Sep  5 19:53:27 2017

@author: nbt264

Explore List structures

    Lists are mutable - meaning they can be changed
     Items can be added, removed, or altered
      Within the list

    Lists are similar to arrays in Java, but aren't quite the same...
    A List does not have to contain homogenous types
"""

listOne = [3073, 33, "BB 3.02.06", 3, "TR", 19.5, "Terri"]

# Individual items can be accessed by index
print(listOne[2])

#We can check the number of items in the List....
print("There are", len(listOne), "items in the list.")

"""
    We can add, delete, or change items in the List, as we choose
"""

listOne[3] = 3.0

print("The new type of sub 3 is: ", type(listOne[3]))

# Let's sort a List

listTwo = [2004, 13.6, 0, -8524, 42, 0.00005]
listTwo.sort()
print("\n\n", listTwo)
listTwo.reverse()
print("\n\nDescending Order: \n",listTwo)

# Let's remove something from listTwo
listTwo.remove(0)
print(listTwo)