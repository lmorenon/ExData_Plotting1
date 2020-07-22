###Course: Exploratory Data Analysis (Coursera) ###
###Project 1#######
### Made by Leonardo Moreno ####

## In this script i will try to reconstruct the graphics detailed in the asignment 
## Graph 2

## Load the dataset
library(dplyr)
library(lubridate)
library(readr)
library(zoo)

Sys.setlocale("LC_ALL","English")
Sys.setlocale("LC_TIME", "English")

Graph_DB<- read_delim("household_power_consumption.txt", ";", escape_double = FALSE, 
                      col_types = cols(Date = col_datetime(format = "%d/%m/%Y")), trim_ws = TRUE) 

subset2<-Graph_DB[Graph_DB$Date >= "2007-01-31" & Graph_DB$Date <= "2007-02-02",]

HDS<-as.POSIXct(paste(subset2$Date, subset2$Time), format="%Y-%m-%d %H:%M:%S")

subset2<-cbind(subset2,HDS)


ts.graph <- zoo(subset2$Global_active_power, order.by = subset2$HDS) ## transform to time series object


## Graph Code

png(file="plot2.png", width=450, height=450)
plot2<-plot.zoo(ts.graph,xlab="",ylab="Global Active Power (kilowatts)")


dev.off()
