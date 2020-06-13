## download dataset and unzip it in your working directory

library(readr) ##quicker

##reading the data
myFile <- "./household_power_consumption.txt" 
energy <- read_csv2(myFile) ##it's a txt file separated by ";"
energy2 <- as.data.table(energy)
energy2$Date <- as.Date(energy2$Date, format = "%d/%m/%Y") ##before, it was character
myData <- filter(energy2, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) ##as time, it's easy to divide and conquer

##an extra step if the native language in your country isn't English - like for me!
Sys.setlocale("LC_TIME", "English_United States.1252") ##English is this for Windows, it varies in other OS

datetime <- strptime(paste(myData$Date, myData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

##plotting

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
       lty = 1,
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       xjust = 1,
       cex = 0.7
       )

##now, saving as a PNG file 480 pixels x 480 pixels
dev.copy(png, width = 480, height = 480, file = "plot3.png")
dev.off()