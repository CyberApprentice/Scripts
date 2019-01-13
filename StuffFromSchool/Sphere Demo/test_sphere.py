# -*- coding: utf-8 -*-
"""
Created on Tue Aug 29 20:16:01 2017

@author: nbt264

    This is a test harness for the Sphere class
"""
import sphere

def main():
    while True:
        start_rad = float (input("What size Sphere do you want?\nEnter 0 to quit.") )
        if start_rad == 0:
            break
        else:
            mySphere = sphere.Sphere(start_rad)
            
            print("The Diameter of your Sphere is",
                  mySphere.diameter() )
            print("The Circumference of your Sphere is", mySphere.circumference())
            print("The Surface Area of your Sphere is", mySphere.surface())
            print("The Volume of your Sphere is", mySphere.volume())
            
main(
)