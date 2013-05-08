# Let's get some estimates for the effect size 
bounce.lm<-lm(bounceRate~avgPageLoadTime, data=subset(final_dataset,yearmo==201211 & isMobile=='No' & bounceRate>1 & avgPageLoadTime<15))
summary(bounce.lm)
# Diagnostics for thefit
plot(bounce.lm)
