# Load all of the data
dataAll <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# Now convert the Date column to an actual Date object so we can subset it just to the days
# we want to evaluate
dataAll[["Date"]] <- as.Date(dataAll[["Date"]], format="%d/%m/%Y")

# Now pull out just the subset of data we want to work with.
dataSmall <- dataAll[dataAll$Date %in% c(as.Date("1/2/2007", format="%d/%m/%Y"), as.Date("2/2/2007", format="%d/%m/%Y")),]
# Since we know we're not using this again, just delete to free up memory.
rm(dataAll)

# Convert to numeric form factor. But first you must change it to a character else, the decimal place confuses it.
# If time permits, go back and defines the colClasses when reading it in.
dataSmall[["Global_active_power"]] <- as.numeric(as.character(dataSmall[["Global_active_power"]]))

# Draw the plot directly to a file
png(filename="plot1.png", width=480, height=480)

# plot it and write it to disk.
hist(dataSmall$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")

dev.off()
