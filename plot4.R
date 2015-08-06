



data_df <- read.table("household_power_consumption.txt", sep=";", header=T)



data_df2 <- subset(data_df, Date=="1/2/2007" | Date=="2/2/2007")

data_df2[, 1:length(data_df2)] <- as.data.frame(lapply(1:(length(data_df2)), 
                FUN=function(i) { 
                  if (i < 3) {
                    data_df2[,i] <- as.character(data_df2[,i]) 
                  } 
                  else {
                    data_df2[,i] <- as.numeric(as.character(data_df2[,i])) 
                  }
                  data_df2[,i]
                }), stringsAsFactors=FALSE)



# The following code can also do the job quickly, but would be more cumbersome if we have 
# a large data set. 
#data_df2 <- transform(data_df2, Date=as.character(Date), Time=as.character(Time), 
#                      Sub_metering_1=as.numeric(as.character(Sub_metering_1)), 
#                      Sub_metering_2=as.numeric(as.character(Sub_metering_2)), 
#                      Sub_metering_3=as.numeric(as.character(Sub_metering_3)),
#                      Global_active_power=as.numeric(as.character(Global_active_power)),
#                      Global_reactive_power=as.numeric(as.character(Global_reactive_power)),
#                      Global_intensity=as.numeric(as.character(Global_intensity)))


install.packages("dplyr")
library(dplyr)


data_df2 <- mutate(data_df2, date_time=paste(data_df2[,1], data_df2[,2]))
data_df2 <- select(data_df2, -c(Date, Time))
data_df2[,8] <- as.data.frame.vector(strptime(data_df2[,8], format="%d/%m/%Y %H:%M:%S"))

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(data_df2, plot(date_time, Global_active_power, cex.lab=0.9,
                    xlab="", ylab="Global Active Power", type="l"))

with(data_df2, plot(date_time, Voltage, xlab="datetime", ylab="Voltage", type="l"))
with(data_df2, {
  plot(date_time, Sub_metering_1, cex.lab=0.9, xlab="", ylab="Energy sub metering", type="l", col="black") 
  lines(date_time, Sub_metering_2, type="l", col="red")
  lines(date_time, Sub_metering_3, type="l", col="blue")
  legend(x="topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}
)
with(data_df2, plot(date_time, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l"))
dev.off()





