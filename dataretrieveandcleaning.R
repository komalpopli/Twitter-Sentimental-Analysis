library(RColorBrewer)
library(wordcloud)
library(tm)
library(twitteR)
library(ROAuth)
library(NLP)
library(plyr)
library(stringr)
library(base64enc)
library(ggplot2)
library(stringi)
library(httr)
library(RCurl)
library(syuzhet)



download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
# Set constant requestURL
requestURL <- "https://api.twitter.com/oauth/request_token"
# Set constant accessURL
accessURL <- "https://api.twitter.com/oauth/access_token"
# Set constant authURL
authURL <- "https://api.twitter.com/oauth/authorize"

consumer_key <- 'XXXXX'
consumer_secret <- 'XXXXX'
access_token <- 'XXXXX'
access_secret <- 'XXXXX'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret) 

tweets_g <- searchTwitter("google", n=100,lang = "en")
tweets <- twListToDF(tweets_g)
View(tweets)

tweet <- tweets$text
tweet <- tolower(tweet)
tweet <- gsub("rt","",tweet)
tweet <- gsub("@\\w+","",tweet)
tweet <- gsub("[[:punct:]]","",tweet)
tweet <- gsub("http\\w+","",tweet)
tweet <- gsub("[ |\t]{2,}","",tweet)
tweet <- gsub("^ ","",tweet)
tweet <- gsub(" $","",tweet)

#wordcloud(tweet.text.corpus,min.freq = 10,random.color = TRUE,max.words = 500)

tweet_corpus <- Corpus(VectorSource(as.vector(tweet))) 
tweet_corpus <- tm_map(tweet_corpus, removeWords, stopwords("english"))
tweet_DTM <- DocumentTermMatrix(tweet_corpus, control = list(wordLengths = c(2, Inf)))
wordcloud(tweet_corpus,min.freq = 2,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)





