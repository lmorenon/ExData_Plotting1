###Course: Exploratory Data Analysis (Coursera) ###
###Project 1#######
### Made by Leonardo Moreno ####

## In this script i will try to reconstruct the graphics detailed in the asignment 
## Graph 4

## Load the dataset
library(dplyr)
library(lubridate)
library(readr)
library(zoo)

Sys.setlocale("LC_ALL","English")
Sys.setlocale("LC_TIME", "English")

Graph_DB<- read_delim("household_power_consumption.txt", ";", escape_double = FALSE, 
                      col_types = cols(Date = col_datetime(format = "%d/%m/%Y")), trim_ws = TRUE) 

subset4<-Graph_DB[Graph_DB$Date >= "2007-01-31" & Graph_DB$Date <= "2007-02-02",]

HDS<-as.POSIXct(paste(subset4$Date, subset4$Time), format="%Y-%m-%d %H:%M:%S")

subset4<-cbind(subset4,HDS)

##Graph Metering
ts.met1 <- zoo(subset4$Sub_metering_1, order.by = subset4$HDS) ## transform to time series object
ts.met2 <- zoo(subset4$Sub_metering_2, order.by = subset4$HDS) ## transform to timse series object
ts.met3 <- zoo(subset4$Sub_metering_3, order.by = subset4$HDS) ## transform to timse series object
ts.gen<- cbind(ts.met1,ts.met2,ts.met3)

##Graph Global active power

ts.gap <- zoo(subset4$Global_active_power, order.by = subset4$HDS)

##Graph Voltaje

ts.vol<- zoo(subset4$Voltage, order.by = subset4$HDS)

##Graph Global Reactive Power

ts.grp <- zoo(subset4$Global_reactive_power, order.by = subset4$HDS)

## Graphs Code

png(file="plot4.png", width=500, height=500)
par(mfrow=c(2,2))

plot_1<-plot.zoo(ts.gap,xlab="",ylab="Global Active Power (kilowatts)")

plot_2<- plot.zoo(ts.vol,xlab="datetime",ylab="Voltage")

plot_3<-plot(ts.gen,screens = 3,xlab="",ylab="Energy sub metering")
lines(ts.gen$ts.met1)
lines(ts.gen$ts.met2,col="red")
lines(ts.gen$ts.met3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot_4<-plot.zoo(ts.grp,xlab="datetime",ylab="Global Reactive Power")

dev.off()