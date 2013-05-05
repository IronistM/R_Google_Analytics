# Only for the first and test runs!
final_dataset<-NA
j<-1
# In the future we should only get data for increment dates. Don't we? 
# get.start.date<-min(final_dataset$date)
# Set up a filters vector to loop over the distinct categories of the blog
filters<-c("ga:pagePath=~^/blog/category/measure/*;ga:pageLoadSample>0","ga:pagePath=~^/blog/category/statistics/*;ga:pageLoadSample>0","ga:pagePath=~^/blog/category/music/*;ga:pageLoadSample>0")
# setwd('C:/Users/m.parzakonis/Google Drive/MyCodeRants/GA/data')

for (i in filters) {
speed.df.1 <- ga$getData(i, 
                       start.date = "2012-08-01", 
                       end.date = today()-1,  
                       metrics = "ga:pageLoadTime,ga:pageLoadSample,ga:domainLookupTime,ga:pageDownloadTime,ga:redirectionTime,ga:serverConnectionTime,ga:serverResponseTime,ga:speedMetricsSample", 
                       filters = filters[i], 
                       dimensions = "ga:date,ga:isMobile",
                       max = 1500,
                       sort = "-ga:pageLoadSample")

speed.df.2 <- ga$getData(i, 
                         start.date = "2012-08-01", 
                         end.date = today()-1,  
                         metrics = "ga:domInteractiveTime,ga:domContentLoadedTime,ga:domLatencyMetricsSample,ga:visits,ga:transactions,ga:bounces", 
                         filters = filters[i], 
                         dimensions = "ga:date,ga:isMobile",
                         max = 1500,
                         sort = "ga:date")


# Merge files, create metrics
merged.df <- merge(speed.df.1, speed.df.2, all=TRUE)
# head(merged.df) # Yessssss! Only to check that it's OK
merged.df$avgPageLoadTime <- (merged.df$pageLoadTime/merged.df$pageLoadSample)/1000
merged.df$avgDomInteractiveTime <- (merged.df$domInteractiveTime/merged.df$domLatencyMetricsSample)/1000
merged.df$conversionRate <- (merged.df$transactions/merged.df$visits)*100
merged.df$bounceRate <- (merged.df$bounces/merged.df$visits)*100
merged.df$yearmo <- year(merged.df$date)*100 + month(merged.df$date)
# Add another group variable to the data for further analysis
merged.df$avgPLGroup<-cut_interval(merged.df$avgPageLoadTime, length = 4)
merged.df$avgPLGroupNum<-as.numeric(cut_interval(merged.df$avgPageLoadTime, length = 4))
# Should you have more page groups to studt use this varible as an index
merged.df$pageGroup<-rep(page.group[j],nrow(merged.df))

final_dataset = merge(final_dataset,merged.df,all=TRUE)

j<-j+1
}

summary(final_dataset)

# You realy got to open http://docs.ggplot2.org/ on a Browser tab now! It's awesome...
# Need to fix xlab a bit
m <- ggplot(data=subset(final_dataset,avgPLGroupNum<12), aes(x=avgPLGroup))
m + geom_histogram(aes(y = ..count..)) + geom_density(fill=NA) + geom_histogram(aes(fill = ..count..))
# Let's get a sense of the distribution of load times per month
qplot(factor(yearmo), avgPageLoadTime, data = subset(final_dataset,yearmo>201208 & isMobile=='No'), geom = "boxplot",outlier.colour = "red", outlier.size = 1) + ylim(0, 20)  + labs(title = "Page Load (in secs) for Desktop",x="Year-Month")
