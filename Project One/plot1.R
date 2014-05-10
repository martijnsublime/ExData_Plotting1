## Loading in the data --> !! provide correct directory for your dataset (for me this is "~/Downloads/household_power_consumption.txt")

household_power_consumption <- read.csv("~/Downloads/household_power_consumption.txt", sep=";")

household_power_consumption$tijd =
  paste(household_power_consumption$Date, household_power_consumption$Time)

household_power_consumption$tijd = strptime(household_power_consumption$tijd,"%d/%m/%Y %H:%M:%S")

household_subset = subset(household_power_consumption,
                          household_power_consumption$tijd >=as.POSIXlt("2007-02-01 00:00:00") &
                            household_power_consumption$tijd <= as.POSIXlt("2007-02-02 23:59:59"))  


## Create first plot

hist(as.numeric(as.character(household_subset$Global_active_power)),
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
)

dev.copy(png,"plot1.png",width=4.8,height=4.8,units="in",res=100)
dev.off()
