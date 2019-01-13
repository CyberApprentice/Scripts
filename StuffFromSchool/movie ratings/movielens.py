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

print("\n\n",total_data.info())

#We no longer need serveral of the DF we created. It's time to release that storage back to the OS or "the heap"

del users
del movies
del ratings
del users_ratings
"""
   Now, all of our data is in one dataFrame, so doing analysis on it will be simple
   Lets start by calculating the mean rating per movie, by reviewer's gender
"""

mean_ratings = pd.pivot_table(total_data, values='rating', index='title', columns='gender', aggfunc='mean')

"""
    mean_ratings is a DF structures as a PivoetTable
    Each movie title is a row, each row has two columns
    (gender). In each column is the mean rating value, by gender,
    for that movie.
"""
 
print("\n\nMean Ratings by Gender")
print(mean_ratings)

"""
Let's concentrate on more reviewed movies...
We'll really look into the differences when mvoies have 250+ reviews
"""

#create series containing count of reviews by title
cnt_ratings_title = total_data.groupby('title').size()

#create a new series containing only review counts >= 250
pop_titles = cnt_ratings_title.index[cnt_ratings_title >= 250]

# Use po-titles to SELECT movie titles from mean_ratings
#this function creates a new, slimmer DF

pop_mean_ratings = mean_ratings.ix[pop_titles]

print("""

Mean Ratings by Gender, Highly Review Movies
""", pop_mean_ratings)

"""
Let's start by asking which highly reviewed movies were favorites with women. (high mean ratings value)
"""

top_women_movies = pop_mean_ratings.sort_values(by = 'F', ascending=False)

print("""

Women's Favorite Movies
""", top_women_movies[:25])

"""
Now let's look for th emovies with the biggest differences in mean ratings (M v F)

1) Calculate the difference in means for each movie
2) We have to add that result to the DF
3) Sort by the new field (Descending)
4) Output the top rows
"""

pop_mean_ratings["diff"] = abs(pop_mean_ratings['M'] - pop_mean_ratings['F'])

#Sort by the new column

sorted_by_diff = pop_mean_ratings.sort_values(by='diff', ascending=False)

print("""

Largest Differences in Ratings
""", sorted_by_diff[:25])
