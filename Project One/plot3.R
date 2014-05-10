## Loading in the data --> !! provide correct directory for your dataset (for me this is "~/Downloads/household_power_consumption.txt")

household_power_consumption <- read.csv("~/Downloads/household_power_consumption.txt", sep=";")

household_power_consumption$tijd =
  paste(household_power_consumption$Date, household_power_consumption$Time)

household_power_consumption$tijd = strptime(household_power_consumption$tijd,"%d/%m/%Y %H:%M:%S")

household_subset = subset(household_power_consumption,
                          household_power_consumption$tijd >=as.POSIXlt("2007-02-01 00:00:00") &
                            household_power_consumption$tijd <= as.POSIXlt("2007-02-02 23:59:59"))  


## Create second plot

plot(y = as.numeric(as.character(household_subset$Sub_metering_1)), 
     x = household_subset$tijd,
     xlab="",
     ylab="Energy sub metering",
     type = "l")
lines(household_subset$tijd,as.numeric(as.character(household_subset$Sub_metering_2)),col="red")
lines(household_subset$tijd,as.numeric(as.character(household_subset$Sub_metering_3)),col="blue")

legend("topright", cex=0.7, lwd=c(1.5,1.5,1.5) , col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.copy(png,"plot3.png",width=4.8,height=4.8,units="in",res=100)
dev.off()