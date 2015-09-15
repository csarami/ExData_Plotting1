cls <- c(Date='character', Time ='character'   ,Global_active_power = 'numeric' , Global_reactive_power ='numeric' , Voltage='numeric',Global_intensity='numeric', Sub_metering_1 ='numeric',Sub_metering_2 ='numeric'   ,     Sub_metering_3 = 'numeric'       )
EPC <- read.table("../household_power_consumption.txt", colClasses = cls, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings = '?')
#date1<- as.Date(EPC$Date, "%d/%m/%Y")
#DATE1 <- as.Date("2007-02-01 01:00", "%Y-%m-%d %H:%M")
#DATE2 <- as.Date("2007-02-02 00:00", "%Y-%m-%d %H:%M")
x <- paste(EPC$Date, EPC$Time)
date1 <- strptime(x,"%d/%m/%Y  %H:%M:%S" )

EPC$Date <-date1
EPC$Time <- as.factor(weekdays(EPC$Date))

DATE1 <- as.Date("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
DATE2 <- as.Date("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S")
DATE2 - DATE1

Test2007 <- subset(EPC, as.Date(date1) >= DATE1 & as.Date(date1) <= DATE2)
dim(Test2007)
rm(EPC)
attach(Test2007)
dev.off()
dev.new()
hist(Global_active_power, main ='Global Active Power', xlab = "Global Active Power (killowatts)", ylab = 'Frequency', col = 'red')
dev.copy(png, file = 'plot1.png', width = 480, height = 480)
dev.off()

