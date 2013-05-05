require(googleVis)

# We need to aggreagate data across countries first
# final_dataset_agg<-
input<- final_dataset_aggr
select<- input[which(input$avgPLGroupNum<18),]
Map<- data.frame(select$country, select$avgPageLoadTime)
names(Map)<- c("Country", "avgPageLoadTime")
Geo=gvisGeoMap(Map, locationvar="Country", numvar="avgPageLoadTime",
               options=list(height=350, dataMode='regions'))
plot(Geo)
