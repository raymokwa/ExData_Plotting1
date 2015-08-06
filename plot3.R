


data_df <- read.table("household_power_consumption.txt", sep=";", header=T)

data_df2 <- subset(data_df, Date=="1/2/2007" | Date=="2/2/2007", select=c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))

data_df2 <- transform(data_df2, Date=as.character(Date), Time=as.character(Time), 
                      Sub_metering_1=as.numeric(as.character(Sub_metering_1)), 
                      Sub_metering_2=as.numeric(as.character(Sub_metering_2)), 
                      Sub_metering_3=as.numeric(as.character(Sub_metering_3))
                      )


install.packages("dplyr")
library(dplyr)

data_df2 <- mutate(data_df2, date_time=paste(data_df2[,1], data_df2[,2]))
data_df2 <- select(data_df2, date_time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
data_df2[,1] <- as.data.frame.vector(strptime(data_df2[,1], format="%d/%m/%Y %H:%M:%S"))


png("plot3.png", width=480, height=480)
with(data_df2, {
     plot(date_time, Sub_metering_1, cex.lab=0.9, xlab="", ylab="Energy sub metering", type="l", col="black") 
     lines(date_time, Sub_metering_2, type="l", col="red")
     lines(date_time, Sub_metering_3, type="l", col="blue")
     legend(x="topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}
     )
dev.off()






