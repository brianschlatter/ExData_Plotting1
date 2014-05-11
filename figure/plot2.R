# Load all of the data
dataAll <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

dataAll[["Date"]] <- as.Date(dataAll[["Date"]], format="%d/%m/%Y")

# Now pull out just the subset of data we want to work with.
dataSmall <- dataAll[dataAll$Date %in% c(as.Date("1/2/2007", format="%d/%m/%Y"), as.Date("2/2/2007", format="%d/%m/%Y")),]
# Since we know we're not using this again, just delete to free up memory.
rm(dataAll)

pasted <- paste(dataSmall[["Date"]], dataSmall[["Time"]])
datetime <- strptime(pasted, "%Y-%m-%d %H:%M:%S")

png(filename="plot2.png", width=480, height=480)
with(dataSmall,  plot(datetime, Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab=""))
# Save it to a file
dev.off()

