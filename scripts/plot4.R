# reading the data, assuming that the file is in the same directory
household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# converting the date from character to date format
household$Date <- as.Date(strptime(household$Date, format = "%d/%m/%Y"))
household$Full_date <- strptime(paste(household$Date, household$Time), "%Y-%m-%d %H:%M:%S")

# filtering that date in the required interval
library(lubridate)
householdFiltered <- household[household$Full_date >= ymd("2007-02-01") & household$Full_date < ymd("2007-02-03"),]
householdFiltered$Global_active_power <- as.numeric(householdFiltered$Global_active_power)

# ploting the graphic
par(mfrow = c(2, 2), mar=c(4.5,5,2,2))
plot(householdFiltered$Full_date, householdFiltered$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
plot(householdFiltered$Full_date, householdFiltered$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(householdFiltered$Full_date, householdFiltered$Sub_metering_1, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", col = "black")
points(householdFiltered$Full_date, householdFiltered$Sub_metering_2, type = "l", col = "red")
points(householdFiltered$Full_date, householdFiltered$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, cex = 0.5)
plot(householdFiltered$Full_date, householdFiltered$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", col = "black")

# drawing into the file
dev.cur()
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()