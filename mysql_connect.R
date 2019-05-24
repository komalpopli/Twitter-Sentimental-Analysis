

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

consumer_key <- 'XXXX'
consumer_secret <- 'XXXX'
access_token <- 'XXXX'
access_secret <- 'XXXX'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret) 

tweets_g <- searchTwitter("#LokSabhaElections2019", n=100,lang = "en")
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

dataf <- data.frame(cleaned_data,category_senti)



library(RMySQL)
library(dbConnect)
# 2. Settings
db_user <- "root"
db_password <- "password"
db_name <- "twitter"
db_table <- "dataf"
db_host <- "127.0.0.1" # for local access
db_port <- 3306

# 3. Read data from db
mydb <-  dbConnect(MySQL(), user = db_user, password = db_password,
                   dbname = db_name, host = db_host, port = db_port)
dbListTables(mydb)
dbWriteTable(mydb,  name = "abc",value = dataf, append=T, row.names=F, overwrite=F) 
xyz <- dbReadTable(conn = mydb, name = 'abc')
head(xyz)


