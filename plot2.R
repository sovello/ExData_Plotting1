##Loading required libraries
library(sqldf, tcltk)

##Reference to the file
datafile <- "household_power_consumption.txt"

##the sql statement
mySql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007' "

##Reading data into householdata (use csv2) cos this is separated by ';'
householdata <- read.csv2.sql(datafile, mySql, na.strings="?")

datas <- householdata[c("Date", "Time", "Global_active_power")]
datas <- datas[datas[,2] != '?', ]
datas[,1] <- as.Date(datas[,1], "%d/%m/%Y")
Times <- paste(datas$Date,datas$Time, sep=" ")
datas <- cbind(datas,Times)
datas[,4] <- as.character(datas[,4])
datas$Times <- strptime(datas$Times, format="%Y-%m-%d %H:%M:%S")

##recode all ? into NAs
##datas[datas=="?"] <- NA
##considerColumns <- allRows[allRows[,3] != 'Not Available', ]
##only take complete cases
##datas[complete.cases(datas),]
##Create location to print the current plot
png(filename="plot2.png", width=480, height=480, units="px")

##plot the histogram
##plot(datas$Times, datas$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
with(datas, plot(Times, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

##close the png device
dev.off()