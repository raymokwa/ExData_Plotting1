




data_df <- read.table("./household_power_consumption.txt", header=T, sep=";")
data_df2 <- subset(data_df, (Date=="1/2/2007" | Date=="2/2/2007" ))
data_df2 <- transform(data_df2, Global_active_power=as.numeric(as.character(Global_active_power)))

png(file="plot1.png", width=480, height=480)
hist(data_df2[,3], xlab="Glabal Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()

