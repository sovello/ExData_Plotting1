##Loading required libraries
library(sqldf, tcltk)

##Reference to the file
datafile <- "household_power_consumption.txt"

##the sql statement
mySql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007' "

##Reading data into householdata (use csv2) cos this is separated by ';'
householdata <- read.csv2.sql(datafile, mySql)

##Prepare a png device where to plot the
png(filename="plot1.png", width=480, height=480, units="px")

##plot the histogram
hist(householdata$Global_active_power, 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Globa Active Power", col="red")

##close the png device
dev.off()