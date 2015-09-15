cls <- c(Date='character', Time ='character'   ,Global_active_power = 'numeric' , Global_reactive_power ='numeric' , Voltage='numeric',Global_intensity='numeric', Sub_metering_1 ='numeric',Sub_metering_2 ='numeric'   ,     Sub_metering_3 = 'numeric'       )
EPC <- read.table("../household_power_consumption.txt", colClasses = cls, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings = '?')
x <- paste(EPC$Date, EPC$Time)
date1 <- strptime(x,"%d/%m/%Y  %H:%M:%S" )
EPC$Date <-date1
EPC$Time <- as.factor(weekdays(EPC$Date))
DATE1 <- as.Date("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
DATE2 <- as.Date("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S")
DATE2 - DATE1
Test2007 <- subset(EPC, as.Date(date1) >= DATE1 & as.Date(date1) <= DATE2)
dim(Test2007)
epcG<- EPC$Global_active_power
rm(EPC)

attach(Test2007)

# Now to draw plot three ( this is overlay of three time series and one argument is enough)


plot(ts(Test2007$Global_active_power), xlab = '', xaxt = "n", ylab ="Energy Sub Metering", ylim=c(0,40), yaxt = "n", type = 'n')
lines(ts(Test2007$Sub_metering_1))
lines(ts(Test2007$Sub_metering_2), col = 'red')
lines(ts(Test2007$Sub_metering_3), col = 'blue')
legend('topright', lwd = .75, col = c('black', 'red', 'blue'), 
       legend =c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),cex = 0.6)
axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat")) 
axis(2, at=c(0, 10, 20,30))
dev.copy(png, file = 'plot3.png', width = 480, height = 480)
dev.off()


