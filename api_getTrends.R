source("full_code.R")
library(twitteR)
library(RMySQL)
library(dbConnect)
woeid <-2295420

consumer_key <- 'Nsyhh0Nf167phlWR0jeHExnza'
consumer_secret <- 'bWlpRk5B1yV36aB1GGXxRq3c1UDhi43WeCzwgA29WRBYXgLxEM'
access_token <- '3073142365-KnMDh5lxEjnk5q0HDCSuHUD7ACs0de5Ng5l7Flp'
access_secret <- 'OSnBDOcx4eXcCCjlWPoQ5TApmrqKsMxycGJcrZPzImpYY'

setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

current_trends <- getTrends(woeid)
a <-storing(current_trends$name[1])
a