library(RColorBrewer)
library(wordcloud)
library(tm)
library(twitteR)
library(ROAuth)
library(plyr)
library(stringr)
library(base64enc)

download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
# Set constant requestURL
requestURL <- "https://api.twitter.com/oauth/request_token"
# Set constant accessURL
accessURL <- "https://api.twitter.com/oauth/access_token"
# Set constant authURL
authURL <- "https://api.twitter.com/oauth/authorize"

consumer_key <- 'pUrg1s4COrjiZUbFHFdRJpVEH'
consumer_secret <- 'wINyJ4nV1zYb6392voR1HskrBJBeQxYQcNHcr5icoJvRdUJDoY'
access_token <- '3073142365-NQ9YNpahGuZTxqeMNFrJE7ynYOW65t6cuGNuSyL'
access_secret <- 'h8XW6D7ZoI3GPLbpjBK1JwFOZwnN2VistZVLA2A4GpmtZ'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret) 
tweets_g <- searchTwitter("#google", n=100,lang = "en")
google_tweets <- twListToDF(tweets_g)
View(google_tweets)















