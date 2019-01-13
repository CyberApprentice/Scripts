# -*- coding: utf-8 -*-
"""
Created on Thu Nov 30 19:31:13 2017

@author: nbt264

Pull tweet text from twitter. does not include infinte scrolling but can be done through beautiful soup. Also does not include gifs, pics, etc. ONLY TEXT
"""

import requests
from bs4 import BeautifulSoup
import re

#Let's start by grabbing the current NASA twitter feed
rqst = requests.get("https://twitter.com/NASA")

#parse the HTML doc into something manageable
soup = BeautifulSoup(rqst.text, 'html.parser')

#for each tweet in our corpus--large body of data we want to look at 
#we'll extract the text (ignoring any photos, videos, or GIFS), and add
#each text string to a List of tweets
tweets = [item.text for item in soup.findAll('p',class_='tweet-text')]

#How many tweets did we get??
print("There are %d tweets in our List\n" % len(tweets))

#let's look at the text of one tweet...
print("\nA single full text tweet: ", tweets[2]  )

"""
Now that we've extracted 20 tweets, and isolated the text for each, 
we can do some anaylsis on the contents of that text

Let's start by looking at the hyper links included...
"""
#Start with regex for locating URLs
regexlinks = r"http[s]?://[\w./]+"

#place to keep hyperlinks--build an empty list for holding links we find
allLinks = []

#for each item in the tweets list, search for a hyperlink, if found, extract and add
# to allLinks

for item in tweets:
    #select hyperlinks
    linksList = re.findall(regexlinks, item)
    
    for link in linksList:
        allLinks.append(link)
        
#view complete corpus leve list
print("\n\nAll Hyperlinks Found")
for item in allLinks:   
    print(item)

"""
Now, let's look for twitter handles, indicating another twitter user has been referenced or
spoken to in a tweet
"""
#start with a regex to find twitter account handles
regexTH = r"@\w{1,15}"

#place to keep hyperlinks--build an empty list for holding links we find
allHandles = []

#for each item in the tweets list, search for a handle, if found, extract and add
# to allHandles

for item in tweets:
    #select hyperlinks
    handlesList = re.findall(regexTH, item)
    
    for handle in handlesList:
        allHandles.append(handle)
        
#view complete corpus leve list
print("\n\nAll Twitter Handles Found")
for item in allHandles:   
    print(item)
    
