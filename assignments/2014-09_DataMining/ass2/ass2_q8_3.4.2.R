#Exercise 3.4.2

value_s <- function(r,b){
  return((1 - (0.5^(1/b)) )^(1/r))
}
estimate_s <- function(r,b){
  return((1/b)^(1/r))
}

s_1 = value_s(3,10)
s_2 = value_s(6,20)
s_3 = value_s(5,50)

e_1 = estimate_s(3,10)
e_2 = estimate_s(6,10)
e_3 = estimate_s(5,50)

estimate <- matrix(c(e_1, e_2, e_3))
true     <- matrix(c(s_1, s_2, s_3))
diff     <- estimate - true
percent_diff <- (estimate-true)/apply(cbind(estimate,true),1,max) * 100

## Summary
summary <- data.frame(estimate,
                      true,
                      diff,
                      percent_diff,
                      row.names=c("r=3,b=10",
                                  "r=6,b=20",
                                  "r=9,b=50"))

# > apply(summary, 2, function(x){round(x,4)})
#          estimate   true   diff percent_diff
# r=3,b=10   0.4642 0.4061 0.0581      12.5110
# r=6,b=20   0.6813 0.5694 0.1119      16.4304
# r=9,b=50   0.4573 0.4244 0.0329       7.1966