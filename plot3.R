##Loading required libraries
library(sqldf, tcltk)

##Reference to the file
datafile <- "household_power_consumption.txt"

##the sql statement
mySql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007' "

##Reading data into householdata (use csv2) cos this is separated by ';'
datas <- read.csv2.sql(datafile, mySql)

#datas <- datas[datas == '?' ] <- NA
#datas <- datas[complete.cases(datas)]
datas$Date <- as.Date(datas$Date, "%d/%m/%Y")
Times <- paste(datas$Date,datas$Time, sep=" ")
datas <- cbind(datas,Times)
datas$Times <- as.character(datas$Times)
datas$Times <- strptime(datas$Times, format="%Y-%m-%d %H:%M:%S")

##recode all ? into NAs
##datas[datas=="?"] <- NA
##considerColumns <- allRows[allRows[,3] != 'Not Available', ]
##only take complete cases
##datas[complete.cases(datas),]
##Create location to print the current plot
png(filename="plot3.png", width=480, height=480, units="px")

##plot the histogram
##plot(datas$Times, datas$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
with(datas, plot(Times, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black"))
with(datas, lines(Times, Sub_metering_2, type="l", ylab="", xlab="", col="red"))
with(datas, lines(Times, Sub_metering_3, type="l", ylab="", xlab="", col="blue"))
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col = c("black", "red", "blue"))

##close the png device
dev.off()