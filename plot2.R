

data_df <- read.table("household_power_consumption.txt", sep=";", header=T)

data_df2 <- subset(data_df, Date=="1/2/2007" | Date=="2/2/2007", select=c(Date, Time, Global_active_power))

data_df2 <- transform(data_df2, Global_active_power=as.numeric(as.character(Global_active_power)), Date=as.character(Date), Time=as.character(Time))

install.packages("dplyr")
library(dplyr)

data_df2 <- mutate(data_df2, date_time=paste(data_df2[,1], data_df2[,2]))
data_df2 <- select(data_df2, date_time, Global_active_power)
data_df2[,1] <- as.data.frame.vector(strptime(data_df2[,1], format="%d/%m/%Y %H:%M:%S"))

png("plot2.png", width=480, height=480)
with(data_df2, plot(date_time, Global_active_power, cex.lab=0.9,
                    xlab="", ylab="Global Active Power (kilowatts)", type="l"))
dev.off()



