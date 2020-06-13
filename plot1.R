## download dataset and unzip it in your working directory

library(readr) ##quicker

##reading the data
myFile <- "./household_power_consumption.txt" 
energy <- read_csv2(myFile) ##it's a txt file separated by ";"
energy2 <- as.data.table(energy)
energy2$Date <- as.Date(energy2$Date, format = "%d/%m/%Y") ##before, it was character
myData <- filter(energy2, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) ##as time, it's easy to divide and conquer

myData$Global_active_power <- as.numeric(myData$Global_active_power) ##to do the histogram, it has to be numeric values

##plotting
hist(myData$Global_active_power,
     main = "Global Active Power",
     col = "red",
     xlab = "Global Active Power(kilowatts)")

##now, saving as a PNG file 480 pixels x 480 pixels
dev.copy(png, width = 480, height = 480, file = "plot1.png")
dev.off()