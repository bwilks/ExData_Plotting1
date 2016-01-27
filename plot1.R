##Check for directory and create if not there. Set working directory.

if (!file.exists("C:/Users/Brad/Documents/Coursera/Exploratory_Data_Analysis/Project_1")){
  dir.create("C:/Users/Brad/Documents/Coursera/Exploratory_Data_Analysis/Project_1")
}
setwd("C:/Users/Brad/Documents/Coursera/Exploratory_Data_Analysis/Project_1")

##Get the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="elec_projectzip")

##Unzip file into the working directory
unzip("elec_projectzip")

##Use SQLDF library to read the file and load only the rows that are needed
  library(sqldf)
  delec<- read.csv.sql("household_power_consumption.txt", sep = ';', header = TRUE,sql="select * from file where Date in ('1/2/2007', '2/2/2007')")

##Convert dataframe to tdelec so mutate can be used
  library(dplyr)
  tdelec<-tbl_df(delec) 

##Combine date and time column and append to the dataframe
  fulldelectbl<- mutate(tdelec, DateTime=paste(tdelec$Date,tdelec$Time))

##Confert tbl_df back to a data.frame so you can work with idividual components####
  fulldelec<-as.data.frame(fulldelectbl)
  
##Convert DateTime character type to POSIXlt
  fulldelec$DateTime <- strptime(fulldelec$DateTime,"%d/%m/%Y %T") 

## Remove original date and time columns
  fulldelec$Date<-NULL
  fulldelec$Time<-NULL
  
####Begin Plot1####
  png(file = "plot1.png", width = 480, height = 480)
  hist(fulldelec$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()  





















