# plumber.R
library(plumber)
#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function(){
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
  result <- dbSendQuery(mydb,"select * from kom")
  data.frame=fetch(result,n=50)
  print(data.frame)
}




