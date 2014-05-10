## Loading in the data --> !! provide correct directory for your dataset (for me this is "~/Downloads/household_power_consumption.txt")

household_power_consumption <- read.csv("~/Downloads/household_power_consumption.txt", sep=";")

household_power_consumption$tijd =
  paste(household_power_consumption$Date, household_power_consumption$Time)

household_power_consumption$tijd = strptime(household_power_consumption$tijd,"%d/%m/%Y %H:%M:%S")

household_subset = subset(household_power_consumption,
                          household_power_consumption$tijd >=as.POSIXlt("2007-02-01 00:00:00") &
                            household_power_consumption$tijd <= as.POSIXlt("2007-02-02 23:59:59"))  


## Create second plot

par(mfrow = c(2, 2))

## left upper corner
plot(y = household_subset$Global_active_power, 
     x = household_subset$tijd,
     type = "l",
     xlab="",
     yaxt = 'n',
     ylab="Global Active Power")
axis(side=2, at=seq(0,4000, 1000), labels=c("0","2","4","6",""))

## rigth upper corner
plot(y = as.numeric(as.character(household_subset$Voltage)), 
     x = household_subset$tijd,
     type = "l",
     yaxt = 'n',
     ylab="Voltage",
     xlab="datetime"
)
axis(side=2, at=seq(232,248, 2), labels=c("","234","","238","","242","","246",""))

plot(y = as.numeric(as.character(household_subset$Sub_metering_1)), 
     x = household_subset$tijd,
     xlab="",
     ylab="Energy sub metering",
     type = "l")
lines(household_subset$tijd,as.numeric(as.character(household_subset$Sub_metering_2)),col="red")
lines(household_subset$tijd,as.numeric(as.character(household_subset$Sub_metering_3)),col="blue")

legend("topright", cex=0.3, lwd=c(1.5,1.5,1.5) , pt.cex = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(y = as.numeric(as.character(household_subset$Global_reactive_power)), 
     x = household_subset$tijd,
     ylab="Global_reactive_power",
     type = "l",
     xlab="datetime")

dev.copy(png,"plot4.png",width=4.8,height=4.8,units="in",res=100)
dev.off()