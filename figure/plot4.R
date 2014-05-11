# Load all of the data
dataAll <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

dataAll[["Date"]] <- as.Date(dataAll[["Date"]], format="%d/%m/%Y")

# Now pull out just the subset of data we want to work with.
dataSmall <- dataAll[dataAll$Date %in% c(as.Date("1/2/2007", format="%d/%m/%Y"), as.Date("2/2/2007", format="%d/%m/%Y")),]
# Since we know we're not using this again, just delete to free up memory.
rm(dataAll)

pasted <- paste(dataSmall[["Date"]], dataSmall[["Time"]])
dataSmall[["DateTime"]] <- strptime(pasted, "%Y-%m-%d %H:%M:%S")

# plot the 4 graphs in a 2x2 grid.
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(dataSmall, {
  plot(DateTime, Global_active_power, type='l', ylab="Global Active Power", xlab="")
  plot(DateTime, Voltage, type='l', xlab="datetime")
  plot(DateTime, Sub_metering_1, type='l', ylab="Energy sub metering", xlab="")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.95, # smaller font for legend text
       bty="n", # no border on legend
       col=c("black", "red", "blue"), 
       lty=c(1, 1, 1)) # Gives the legend the correct symbols i.e. lines
  plot(DateTime, Global_reactive_power, type='l', xlab="datetime")
})
dev.off()
