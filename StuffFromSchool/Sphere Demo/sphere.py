# -*- coding: utf-8 -*-
"""
This is a simple class describing a sphere
"""
class Sphere:
    #radius = 0.0
    def __init__(self, size):
        #Contructor for the Sphere class
        self.radius = size
    
    def diameter(self):
        return self.radius * 2
    
    def circumference(self):
       return 2*3.14159* (self.radius**2)
       
    def surface(self):
        return 4*3.14159*(self.radius**4)
    
    def volume(self):
        return (4/3)*3.14159*(self.radius**3)
        
       
    
