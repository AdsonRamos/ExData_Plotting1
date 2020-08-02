# reading the data, assuming that the file is in the same directory
household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# converting the date from character to date format
household$Date <- as.Date(strptime(household$Date, format = "%d/%m/%Y"))

# filtering that date in the required interval
library(lubridate)
householdFiltered <- household[household$Full_date >= ymd("2007-02-01") & household$Full_date < ymd("2007-02-03"),]
householdFiltered$Global_active_power <- as.numeric(householdFiltered$Global_active_power)

# ploting the graphic
par(mfrow = c(1, 1),mar=c(5,4.5,4,2))
hist(householdFiltered$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

# drawing into the file
dev.cur()
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()