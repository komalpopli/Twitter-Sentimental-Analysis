source(twitter_data.R)
sentimental_data <- function(){
library(twitteR)
library(ROAuth)
library(syuzhet)
tweet <- data("#Monday",100)
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

cleaned_data<-as.character(cleaned_data)
word.df <-as.vector((cleaned_data))
sent.value <- get_sentiment(word.df)
positive.tweets<-word.df[sent.value>0]
negative.tweets<-word.df[sent.value<0]
neutral.tweets<-word.df[sent.value==0]
category_senti<-ifelse(sent.value<0,"Negative",ifelse(sent.value>0,"Positive","Neutral"))
s<-data.frame(category_senti,sent.value)
data <- data.frame(cleaned_data,category_senti)
tweet_info <- cbind(tweet,data)
keeps <- c("cleaned_data", "category_senti","created","screenName","latitude","longitude","id")
tweet_info<-tweet_info[keeps]
return(tweet_info)
}
a <- sentimental_data()
View(a)
