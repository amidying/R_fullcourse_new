# #  Bootstrapping in statistics is a resampling based approach useful for estimating the sampling distribution and standard error of an estimate. 
# #  Bootstrapping in statistics and in research provides an alternative approach to approaches based on large sample theory (you may recall that many approaches rely on having a large n in order to carry out the method). It becomes particularly useful when dealing with more complicated estimates, where their sampling distribution and/or standard error may not be easily calculated
# 
# df <- read.csv("ChickData.csv",header=T)
# # firstly convert feed to factor
# attach(df)
# 
# boxplot(weight~feed)
# mean(weight[feed=="casein"],na.rm=T)
# mean(weight[feed=="meatmeal"],na.rm=T)
# 
# 
# 
# # same as the above two lines of code
# with(df,tapply(weight, feed,mean))
# # if finds na use na.rm=T 
# help(with)
# 
# # mean diff absolute
# test.stat1 <- abs(mean(weight[feed=="casein"])-mean(weight[feed=="meatmeal"]))
# test.stat1
# # same 
# abs(diff(with(df,tapply(weight,feed,mean))))
# 
# median(weight[feed=="casein"])
# median(weight[feed=="meatmeal"])
# 
# 
# test.stat2 <- abs(median(weight[feed=='casein'])-median(weight[feed=="meatmeal"]))
# test.stat2
# abs(diff(with(df,tapply(weight,feed,median))))
# 
# 
# t.test(weight~feed,mu=0,alt="two.sided",paired=F,var.eq=F)
# wilcox.test(weight~feed,paired=F)
# 
# #############################
# ##### BOOTSTRAP APPROACH#####
# #############################
# set.seed(112358)
# n <- length(feed)
# n
# B <- 10000
# variable <- weight
# BootstrapSamples <- matrix(sample(variable,size=n*B,replace=T),nrow=n,ncol=B)
# 
# dim(BootstrapSamples)
# 
# 
# Boot.test.stat1 <- rep(0,B)
# Boot.test.stat2<- rep(0,B)
# # going hard man
# for (i in 1:B){
#     Boot.test.stat1[i] <- abs(mean(BootstrapSamples[1:12],i)-mean(BootstrapSamples[13:23,i]))
#     Boot.test.stat2[i] <- abs(median(BootstrapSamples[1:12,i]-median(BootstrapSamples[13:23,i])))
# }
# 
# 
# test.stat1;test.stat2
# 
# 
# round(Boot.test.stat1[1:20,1])
# round(Boot.test.stat2[1:20,1])



#----------------------------------------------------------------------
df <- read.csv(file.choose(),header=T)
head(df)
d <- df
rm(df)


levels(d$feed)
class(d$feed)
feed <- as.factor(d$feed)
d <- data.frame(d$weight,feed)
rm(feed)

levels(d$feed)


boxplot(d$d.weight~d$feed,main="Weight of chicks seperated by feed types",cex.main=1.5,col=c(4,2),xlab="Feed",ylab="Weight",las=1)

with(d,tapply(d$d.weight,d$feed,mean))
with(d,tapply(d$d.weight,d$feed,median))
test.stat1 <- abs(mean(d$d.weight[d$feed=="casein"])-mean(d$d.weight[d$feed=="meatmeal"]))
test.stat1
test.stat2 <- abs(median(d$d.weight[d$feed=="casein"])-median(d$d.weight[d$feed=="meatmeal"]))
test.stat2

t.test(d$d.weight~d$feed,paired=F,var.eq=F)
# is not working the bellow code 
wilcox.test(d$d.weight[d$feed=="casein"],d$d.weight[d$feed=="meatmeal",paired=F])







######################
###bootstrap#####
######################


set.seed(112358)
n <- length(d$feed)
n
B <- 10000
variable <- d$d.weight

BootstarpSamples <- matrix(sample(variable,size = n*B,replace=T),nrow=n,ncol=B)
BootstarpSamples[1:23]
length(BootstarpSamples)
dim(BootstarpSamples)
BootstarpSamples[1:23,2]
#------------------------------------------------------
Boot.test.stat1 <- rep(0,B)
Boot.test.stat2 <- rep(0,B)

for (i in 1:B){
  Boot.test.stat1[i]<- abs(mean(BootstarpSamples[1:12,i])-mean(BootstarpSamples[13:23,i]))
  Boot.test.stat2[i]<- abs(median(BootstarpSamples[1:12,i])-median(BootstarpSamples[13:23,i]))
}


test.stat1;test.stat2;
round(Boot.test.stat1[1:20],1)
round(Boot.test.stat2[1:20],1)

# P-values
# Under set of assumptions, what is the
# probability of getting the observed test statistic or one
# or more extreme, if the null 
# hypothesis is True
(Boot.test.stat1>=test.stat1)[1:20]
(Boot.test.stat2>=test.stat2)[1:20]
mean(Boot.test.stat1>=test.stat1)
mean(Boot.test.stat2>=test.stat2)
# as the p values are greater than 0.05 we may reject the null hypothesis
# p = 8% 
# interpretation: we don't have enough data or we may say that
#   two types of the feed has a significant difference in weight
# chick data

#1. Statistical Significant 2. Mathmatical Significant
# 1. The diets may have significance and may need to explore more
# 2. 


