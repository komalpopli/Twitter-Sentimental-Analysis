#storing <- function(x){
library(twitteR)
library(ROAuth)
library(syuzhet)
consumer_key <- '47jjrxeqsZgHtjLpbHQ2QGpgQ'
consumer_secret <- 'kkCQveDjFS8wNW9Em45VC51nzuuYAqpX5mIjdhL3i9vo6sUYUD'
access_token <- '3073142365-a1o4BINz8HeEmA9kWnt66M9W2SfEfOxAUk6icy3'
access_secret <- 'lCJ0eDsqECORtOnxJpUB5uBkLguy3Wbor7qXXvmq7FXRC'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)
searched_string <- "#JCB"
tweets_g <- searchTwitter(searched_string,n=100,lang = "en")
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
tweet_info <- tweet_info[keeps]



library(RMySQL)
library(dbConnect)
# 2. Settings
db_user <- "root"
db_password <- "password"
db_name <- "twitter"
db_table <- "data"
db_host <- "127.0.0.1" # for local access
db_port <- 3306
mydb <-  dbConnect(MySQL(), user = db_user, password = db_password,
                   dbname = db_name, host = db_host, port = db_port)
dbSendQuery(mydb,paste("INSERT INTO topic_ref (topic_name) VALUES ('",searched_string,"');"))
rs <- dbSendQuery(mydb, paste("SELECT topic_id FROM topic_ref WHERE topic_name = '",searched_string,"';"))
a <- dbFetch(rs)

tweet_info$id_topic <- as.numeric(a)
#dbSendQuery(mydb,paste("INSERT INTO tweet_info(id_topic) SELECT topic_id FROM topic_ref WHERE topic_name = '",searched_string,"';"))

dbWriteTable(mydb,  name = 'tweet_info',value = tweet_info, append=T, row.names=F, overwrite=F) 


#dbSendQuery(mydb, "INSERT INTO topic_ref
#(author_last, author_first, country)
#VALUES('Kumar','Manoj','India');")
xyz <- dbReadTable(conn = mydb, name = 'tweet_info')
abc <- dbReadTable(conn = mydb, name = 'topic_ref')
View(xyz)
abc
#}
#}