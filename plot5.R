setwd("./GitHub/Figure_Exp2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
sum(is.na(NEI$Emission))

Baldata <- NEI[(NEI$fips == "24510"),]
head(Baldata)

motor <- SCC[(grep("Vehicles", SCC$"SCC.Level.Three")),c("SCC", "SCC.Level.Three", "EI.Sector")]
motorlist <- motor[,1]

motordata <- Baldata[Baldata$SCC %in% motorlist, ]
head(motordata)


df <- aggregate(motordata$Emission, by=list(motordata$year), FUN=sum)
head(df)
colnames(df) <- c("Year","Emission")

png("plot5.png", width = 480, height = 480)
plot(df$Year, df$Emission, type="b", main ="Motor Vehicles: PM2.5 Emission By Year (Baltimore City)",
     xlab="Year", ylab="PM2.5 Emission (Tons)", cex=0.5)
axis(side=1, at=seq(1999, 2008))
dev.off()
