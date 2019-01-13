# -*- coding: utf-8 -*-
"""
Created on Tue Sep 26 19:49:01 2017

@author: nbt264

We're going to take a look at movie ratings to see what intellgience we can derive 
"""
import pandas as pd

#Let's bring the data into three separate DataFrame strcutres

#define headings for the volumns in user.dat
users_cols = ['user_id', 'gender', 'age', 'occupation', 'zip']


users = pd.read_table('users.dat', sep='::', header= None, names=users_cols, engine='python')

#define headings for the columns in movie.dat
movies_cols = ['movie_id', 'title', 'genre']

movies = pd.read_table('movies.dat', sep='::', header=None, names=movies_cols, engine='python')

#define headings for the columns in rating.dat
ratings_cols = ['user_id', 'movie_id', 'rating', 'timestamp']

ratings = pd.read_table('ratings.dat', sep='::', header= None, names=ratings_cols, engine='python')

#We now have three DataFrames, one for each input file
#Next, we want to verify that this worked.

print(users[:5], "\n", users.info())
print(movies[:5], "\n", movies.info())
print(ratings[:5], "\n", ratings.info())
"""
    The next step is to tie the individual frames together into a single whole

    users.user_id = ratings.user_id
    ratings.movie_id = movies.movie_id

    Using the column heading relationships, we can merge the three DF into a single DF
    containing all the data from all three files
"""

users_ratings = pd.merge(ratings, users)
total_data = pd.merge(users_ratings, movies)

#Lets check the results...
print("hi-------------------------------------------")
#print("\n\n",total_data[:5])
print("hi-------------------------------------------")