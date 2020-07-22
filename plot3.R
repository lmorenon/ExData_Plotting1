###Course: Exploratory Data Analysis (Coursera) ###
###Project 1#######
### Made by Leonardo Moreno ####

## In this script i will try to reconstruct the graphics detailed in the asignment 
## Graph 3

## Load the dataset
library(dplyr)
library(lubridate)
library(readr)
library(zoo)

Sys.setlocale("LC_ALL","English")
Sys.setlocale("LC_TIME", "English")

Graph_DB<- read_delim("household_power_consumption.txt", ";", escape_double = FALSE, 
                      col_types = cols(Date = col_datetime(format = "%d/%m/%Y")), trim_ws = TRUE) 

subset3<-Graph_DB[Graph_DB$Date >= "2007-01-31" & Graph_DB$Date <= "2007-02-02",]

HDS<-as.POSIXct(paste(subset2$Date, subset3$Time), format="%Y-%m-%d %H:%M:%S")

subset3<-cbind(subset3,HDS)


ts.met1 <- zoo(subset3$Sub_metering_1, order.by = subset3$HDS) ## transform to time series object
ts.met2 <- zoo(subset3$Sub_metering_2, order.by = subset3$HDS) ## transform to timse series object
ts.met3 <- zoo(subset3$Sub_metering_3, order.by = subset3$HDS) ## transform to timse series object
ts.gen<- cbind(ts.met1,ts.met2,ts.met3)

## Graph Code

png(file="plot3.png", width=450, height=450)
plot3<-plot(ts.gen,screens = 3,xlab="",ylab="Energy sub metering")
lines(ts.gen$ts.met1)
lines(ts.gen$ts.met2,col="red")
lines(ts.gen$ts.met3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.off()