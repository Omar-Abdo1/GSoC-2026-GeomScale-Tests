library(nloptr)
# Check available algorithms
nloptr.get.default.options()
# Should print a list of options – no error means it's working.

# Try a tiny example (minimize x^2)
eval_f <- function(x) return(x^2)
x0 <- 1.0
res <- nloptr(x0, eval_f, opts = list(algorithm = "NLOPT_LN_COBYLA", xtol_rel = 1e-8))
print("now the res is :")
print(res)