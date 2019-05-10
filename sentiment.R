

library(twitteR)
library(ROAuth)
library(syuzhet)
#download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
# Set constant requestURL
#requestURL <- "https://api.twitter.com/oauth/request_token"
# Set constant accessURL
#accessURL <- "https://api.twitter.com/oauth/access_token"
# Set constant authURL
#authURL <- "https://api.twitter.com/oauth/authorize"

consumer_key <- 'qMWWFyU7xv9XJN9AtcplgsFGk'
consumer_secret <- 'vc4LZT2n5SjkDgsPjZXMeU6H2ONWwBl23ayDnHUdsCQNusfPTZ'
access_token <- '3073142365-OYdilxIAZxFkimdHWiqJ9kSO4Zt8diyDkQmtCVr'
access_secret <- '3Zp65DsH1rB6bH1SylaecOGtOzc0PGR0c4j4F2sGkOdP4'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret) 

tweets_g <- searchTwitter("#CSKvDC", n=100,lang = "en")
tweet <- twListToDF(tweets_g)

cleaned_data <- lapply(tweet$text, function(tweets.df2){
  tweets.df2 = gsub('http\\S+\\s*','',tweets.df2)
  tweets.df2 = gsub('\\b+RT','',tweets.df2)
  tweets.df2 = gsub('#\\S+','',tweets.df2)
  tweets.df2 = gsub('@\\S+','',tweets.df2)
  tweets.df2 = gsub('[[:cntrl:]]', '', tweets.df2)
  tweets.df2 = gsub('\\d', '', tweets.df2)
  tweets.df2 = gsub('[[:punct:]]', '', tweets.df2)
  tweets.df2 = gsub('^[[:space:]]*', '', tweets.df2)
  tweets.df2 = gsub("[[:space:]]*$","",tweets.df2)
  tweets.df2 = gsub(' +',' ',tweets.df2)
})

View(cleaned_data)
as.numeric(unlist(tweet$text))
cleaned_data<-as.character(cleaned_data)
View(tweet$text)
word.df <-as.vector((cleaned_data))
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(word.df,emotion.df)
sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]
most.negative <-word.df[sent.value == min(sent.value)]
positive.tweets<-word.df[sent.value>0]
negative.tweets<-word.df[sent.value<0]
neutral.tweets<-word.df[sent.value==0]
category_senti<-ifelse(sent.value<0,"Negative",ifelse(sent.value>0,"Positive","Neutral"))
s<-data.frame(category_senti,sent.value)
View(s)
dataf <- data.frame(cleaned_data,category_senti)
View(dataf)
