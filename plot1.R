###Course: Exploratory Data Analysis (Coursera) ###
###Project 1#######
### Made by Leonardo Moreno ####

## In this script i will try to reconstruct the graphics detailed in the asignment 
## Graph 1

## Load the dataset
library(openair)

library(readr)
Graph_DB<- read_delim("household_power_consumption.txt", ";", escape_double = FALSE, 
                      col_types = cols(Date = col_datetime(format = "%d/%m/%Y")), trim_ws = TRUE) 
                                         
subset1<-Graph_DB[Graph_DB$Date >= "2007-01-31" & Graph_DB$Date <= "2007-02-02",]



## Graph Code

png(file="plot1.png", width=450, height=450)

plot1<-hist(subset1$Global_active_power, col="red", 
              main= "Gobal Active Power",xlab = "Global Active Power (kilowatts)")
              
dev.off()