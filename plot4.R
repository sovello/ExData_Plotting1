##Loading required libraries
library(sqldf, tcltk)

##Reference to the file
datafile <- "household_power_consumption.txt"

##the sql statement
mySql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007' "

##Reading data into householdata (use csv2) cos this is separated by ';'
datas <- read.csv2.sql(datafile, mySql)

## change the Date column into date type and add a new column that has date time
datas$Date <- as.Date(datas$Date, "%d/%m/%Y")
Times <- paste(datas$Date,datas$Time, sep=" ")
datas <- cbind(datas,Times)

##convert the new column into character so strptime() can convert this into datetime object
datas$Times <- as.character(datas$Times)
datas$Times <- strptime(datas$Times, format="%Y-%m-%d %H:%M:%S")

##Prepare a png device where to plot the
png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))
##plot the histogram
##firstplot
with(datas, plot(Times, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

##secondplot
with(datas, plot(Times, Voltage, type="l", ylab="Voltage", xlab="datetime"))

##thirdplot
with(datas, plot(Times, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black"))
with(datas, lines(Times, Sub_metering_2, type="l", ylab="", xlab="", col="red"))
with(datas, lines(Times, Sub_metering_3, type="l", ylab="", xlab="", col="blue"))

##set the legend
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col = c("black", "red", "blue"))

##fourthplot
with(datas, plot(Times, Global_reactive_power, type="l", xlab="datetime"))

##close the png device
dev.off()