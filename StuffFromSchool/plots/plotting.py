# -*- coding: utf-8 -*-
"""
Created on Tue Oct 24 19:39:39 2017

@author: nbt264

Introduction to plotting in Python
"""

import numpy as np, numpy.random as randn, matplotlib.pyplot as plt

#Just to begin
plt.plot(np.arange(10,21))

"""
For most charts, we need to begin with a figure object - that's
just a container for our chart or plot

Some of the options availabe: 
figsize - size of the figure & relationship to display
dpi - resolution of the figure and plots within

You can have multiple figure objects, each with unique plots
A reference to active figure using matplotlib.gcf() - get current figure

in order to actually disply, a plot must be added to the figure. Use
sub_plot to add a plot to a figure.
"""
fig = plt.figure() # create a figure container
ax1 =  fig.add_subplot(2, 2, 1) # add aplot at position 1 of a 2x2 grid
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(223) # add plot at position 3 of 2x2

print(np.arange(10))

#Let's add some data to plot
plt.plot(np.random.rand(50).cumsum(), 'k--')

ax1.hist(np.random.rand(100), bins=20, color='k',
         
axe2.scatter(np.arange(30), nparange(30)+3*np.random
fig, axes = plt.subplots(2,3)

print(axes)

print(figs)