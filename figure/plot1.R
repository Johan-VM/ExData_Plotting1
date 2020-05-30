## Johan Vásquez Mazo
## Universidad Nacional de Colombia - Sede Medellín

#setwd("./figure/")

## Zip file download
if (!file.exists("household_power_consumption.txt")) {
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "file.zip")
    unzip("file.zip")
}

## Data reading
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# Date conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Subsetting from dates "2007-02-01" and "2007-02-02"
data <- subset(data, (Date >= "2007-02-01") & (Date <= "2007-02-02"))
# Time conversion
#data$Time <- strptime(data$Time, format = "%T")

## Plot 1 creation
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()
