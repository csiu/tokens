library(MASS)
#Exercise 9.2.3

#Setup
procSpeed = c(3.06, 2.68, 2.92)
diskSize  = c( 500,  320,  640)
mainMemSz = c(   6,    4,    6)

userRating = c(4, 2, 5)

#Normalized rating
userNormRating <- userRating - mean(userRating)
fractions(userNormRating)
# > unlist(lapply(userNormRating,function(x){round(x,4)}))
# [1]  0.3333 -1.6667  1.3333

#User profile: processor Speed
sum(userRating * procSpeed)/sum(userRating) #2.927273

#User profile: disk size
sum(userRating * diskSize)/sum(userRating)  #530.9091

#User profile: main-memory size
sum(userRating * mainMemSz)/sum(userRating) #5.636364