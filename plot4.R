## download dataset and unzip it in your working directory

library(readr) ##quicker

##reading the data
myFile <- "./household_power_consumption.txt" 
energy <- read_csv2(myFile) ##it's a txt file separated by ";"
energy2 <- as.data.table(energy)
energy2$Date <- as.Date(energy2$Date, format = "%d/%m/%Y") ##before, it was character
myData <- filter(energy2, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) ##as time, it's easy to divide and conquer

datetime <- strptime(paste(myData$Date, myData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

myData$Global_active_power <- as.numeric(myData$Global_active_power) ##to do the histogram, it has to be numeric values

##plotting

par(mfrow = c(2,2))

##1
plot(datetime, myData$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

##2

plot(datetime, myData$Voltage,
     type = "l",
     ylab = "Voltage")

##3
plot(datetime, myData$Sub_metering_1,
     type="l",
     col = "black",
     xlab="",
     ylab="Energy sub metering")

lines(datetime, myData$Sub_metering_2,
      col = "red")

lines(datetime, myData$Sub_metering_3,
      col = "blue")

legend("topright",
       lty= 1,
       lwd = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.35,
       bty = "n",
       y.intersp = 0.05,
       xjust = 1,
       inset = 0
)


##4
plot(datetime, myData$Global_reactive_power,
       type = "l",
       ylab = "Global_reactive_power")


##now, saving as a PNG file 480 pixels x 480 pixels
dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()