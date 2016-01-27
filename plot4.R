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
  
####Begin Plot4####
  png(file = "plot4.png", width = 480, height = 480)
  par(mfrow = c(2, 2),mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

  with(fulldelec,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power",xlab=""))

  with(fulldelec,plot(DateTime,Voltage,type="l",ylab="Voltage",xlab="datetime"))

  with(fulldelec,{
    plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
    points(DateTime,Sub_metering_2,type="l",col="red")
    points(DateTime,Sub_metering_3,type="l",col="blue")
    legend("topright",lty= 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  })

  with(fulldelec,plot(DateTime,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime"))
  dev.off() 




















