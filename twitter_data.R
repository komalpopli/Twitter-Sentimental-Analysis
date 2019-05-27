twitter_data(x="",n){
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


consumer_key <- 'zXOHKttBR7cxPqZ2ILiMReNww'
consumer_secret <- 'wxr4Vy3XTQLIn32HR5jS2Fz9ghizB8GRD5nlRVzybRCmDHDM1L'
access_token <- '3073142365-XJW8h0COIqqPyTxUzLRJsPjMLMoMK28ELKyAV5N'
access_secret <- 'j2iqVxBwOMNBxJuEOas39VUXB85VvHQXU6xfnuXTv2TWN'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret) 

tweets_g <- searchTwitter(x,n,lang = "en")
tweet <- twListToDF(tweets_g)
}