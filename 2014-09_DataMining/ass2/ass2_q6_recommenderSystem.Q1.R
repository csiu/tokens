#Recommender Systems Q1

threshold = 0.75

#setup
utilityMatrix <- data.frame(Item1=c(5,3,4,4,1),
                            Item2=c(NA,2,NA,3,5),
                            Item3=c(4,3,4,4,NA),
                            Item4=c(4,NA,3,4,2),
                            Item5=c(NA,3,5,NA,1),
                            row.names=c("Alice", 
                                        "User1", 
                                        "User2", 
                                        "User3", 
                                        "User4"))

cos.sim <- function(X, Y){
  return(sum(X*Y)/sqrt(sum(X^2)*sum(Y^2)))  
}
pearson.sim <- function(X,Y){
  X <- as.matrix(X)
  Y <- as.matrix(Y)
  return(sum((X-mean(X))*(Y-mean(Y))) / 
           sqrt(sum((X-mean(X))^2)*sum((Y-mean(Y))^2)))
}
alice.sim <- function(user, simFunction){
  df <- utilityMatrix[c("Alice",user),]
  df <- df[,apply(df,2,function(x){!is.na(sum(x))})]
  X = df["Alice",]
  Y = df[user,]  
  return(simFunction(X,Y))
}

#Similarity
alice.sim("User1", cos.sim) #0.9938837
alice.sim("User2", cos.sim) #0.9929146
alice.sim("User3", cos.sim) #0.9941348
alice.sim("User4", cos.sim) #0.9079594

# ##Aside ... question asks to use cosine similarity ...
# alice.sim("User1", pearson.sim) #stadard deviation is 0
# alice.sim("User2", pearson.sim) #0.5
# alice.sim("User3", pearson.sim) #stadard deviation is 0
# alice.sim("User4", pearson.sim) #-1


#All Users above cos.sim threshold 0.75;
#However User3 did not rate Item5
neightbours = c("User1","User2", "User4")
alice_item5 <-mean(subset(utilityMatrix,
                          subset=rownames(utilityMatrix)%in%neightbours)$Item5)
alice_item5 #rating will be: 3