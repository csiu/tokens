library(MASS)

#Exercise 5.4.2
b = 0.8   # what is beta
e = 0.005 # used in stopping condition

##trust rank
M = matrix(c(0, 1/2, 1, 0, 
             1/3,   0, 0, 1/2,
             1/3,   0, 0, 1/2,
             1/3, 1/2, 0, 0), 
           nrow=4,
           ncol=4)
M <- t(M)
t_t = matrix(c(0, 1, 0, 0), ncol=1)
v_old = matrix(c(1/4, 1/4, 1/4, 1/4))

v_diff = 1
record = NULL
record = v_old

while (v_diff > e) {
  v_new <- (b * M %*% v_old) + ((1-b) * t_t)
  record <- cbind(record, v_new)
  v_diff <- sum(abs(v_old - v_new))
  v_old <- v_new
}
row.names(record)=c("[A]","[B]","[C]","[D]")
fractions(record)
# > apply(record,2,function(x){round(x,4)})
#      [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]   [,8]   [,9]
# [A] 0.25 0.3000 0.2800 0.2560 0.2784 0.2643 0.2720 0.2681 0.2700
# [B] 0.25 0.3667 0.3467 0.3653 0.3536 0.3600 0.3568 0.3583 0.3576
# [C] 0.25 0.1667 0.1467 0.1653 0.1536 0.1600 0.1568 0.1583 0.1576
# [D] 0.25 0.1667 0.2267 0.2133 0.2144 0.2157 0.2145 0.2152 0.2148


##spam mass
pageRank = record[,dim(record)[2]]
trustRank = t_t
spamMass = (pageRank - trustRank) / pageRank

sm_summary = data.frame(pageRank, trustRank, spamMass, 
                        row.names=c("[A]","[B]","[C]","[D]"))
# > apply(sm_summary,2,function(x){round(x,4)})
#     pageRank trustRank spamMass
# [A]   0.2700         0   1.0000
# [B]   0.3576         1  -1.7965
# [C]   0.1576         0   1.0000
# [D]   0.2148         0   1.0000
