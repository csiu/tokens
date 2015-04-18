library(MASS)

#Exercise 5.5.1
e = 0.005

##Hub & Authority
A = matrix(c(0, 1, 1, 1,
             1, 0, 0, 1,
             1, 0, 0, 0,
             0, 1, 1, 0),
           nrow=4,
           ncol=4)
A = t(A)
record_h = NULL
record_a = NULL

##Initialize h, a to all 1's
h_old = a_old = matrix(rep(1, dim(A)[1]))

record_h = h_old
record_a = a_old

h_diff = a_diff = 1
while (h_diff > e || a_diff > e) {
  ##Update simultaneous
  h_new = A %*% a_old
  a_new = t(A) %*% h_old
  
  ##Scale h so that max entry is 1.0
  h_new <- h_new/max(h_new)
  ##Scale a so that max entry is 1.0
  a_new <- a_new/max(a_new)
  
  record_h <- cbind(record_h, h_new)
  record_a <- cbind(record_a, a_new)
  
  ##Continue until h, a converge
  h_diff = sum(abs(h_new - h_old))
  a_diff = sum(abs(a_new - a_old))  
  
  h_old <- h_new
  a_old <- a_new
}
row.names(record_a)=c("a[A]","a[B]","a[C]","a[D]")
row.names(record_h)=c("h[A]","h[B]","h[C]","h[D]")

fractions(record_a)
fractions(record_h)

apply(record_a,2,function(x){round(x,4)})
#      [,1] [,2] [,3] [,4] [,5] [,6]   [,7]   [,8]   [,9]  [,10]  [,11]
# a[A]    1    1  0.6  0.6 0.44 0.44 0.3659 0.3659 0.3289 0.3289 0.3099
# a[B]    1    1  1.0  1.0 1.00 1.00 1.0000 1.0000 1.0000 1.0000 1.0000
# a[C]    1    1  1.0  1.0 1.00 1.00 1.0000 1.0000 1.0000 1.0000 1.0000
# a[D]    1    1  1.0  1.0 0.92 0.92 0.8699 0.8699 0.8431 0.8431 0.8290
#       [,12]  [,13]  [,14]  [,15]  [,16]  [,17]
# a[A] 0.3099 0.3000 0.3000 0.2949 0.2949 0.2922
# a[B] 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
# a[C] 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
# a[D] 0.8290 0.8217 0.8217 0.8178 0.8178 0.8158

apply(record_h,2,function(x){round(x,4)})
#      [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]   [,8]   [,9]
# h[A]    1 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
# h[B]    1 0.6667 0.6667 0.5333 0.5333 0.4658 0.4658 0.4306 0.4306
# h[C]    1 0.3333 0.3333 0.2000 0.2000 0.1507 0.1507 0.1275 0.1275
# h[D]    1 0.6667 0.6667 0.6667 0.6667 0.6849 0.6849 0.6969 0.6969
#       [,10]  [,11]  [,12]  [,13]  [,14]  [,15]  [,16]  [,17]
# h[A] 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
# h[B] 0.4122 0.4122 0.4026 0.4026 0.3975 0.3975 0.3949 0.3949
# h[C] 0.1157 0.1157 0.1095 0.1095 0.1063 0.1063 0.1046 0.1046
# h[D] 0.7035 0.7035 0.7070 0.7070 0.7088 0.7088 0.7098 0.7098
