setwd("./GitHub/Figure_Exp2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
sum(is.na(NEI$Emission))

str(SCC)
head(SCC)
coal <- SCC[(grep("Coal", SCC$"SCC.Level.Three")),c("SCC", "SCC.Level.Three", "EI.Sector")]
coal
coallist <- coal[,1]

coaldata <- NEI[NEI$SCC %in% coallist, ]
head(coaldata)

df <- aggregate(coaldata$Emission, by=list(coaldata$year), FUN=sum)
head(df)
colnames(df) <- c("Year","Emission")

png("plot4.png", width = 480, height = 480)
plot(df$Year, df$Emission/1000, type="b", main ="Coal-related PM2.5 Emission By Year",
     xlab="Year", ylab="PM2.5 Emission (Thousand Tons)", cex=0.5)
axis(side=1, at=seq(1999, 2008))
dev.off()