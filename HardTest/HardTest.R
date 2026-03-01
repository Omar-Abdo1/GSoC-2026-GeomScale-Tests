library(nloptr)

# Function to compute maximum inscribed ball
compute_max_ball <- function(A, b) {
  m <- nrow(A)   # number of constraints
  n <- ncol(A)   # number of dimension
  
  # Precompute norms of each constraint row
  norms <- sqrt(rowSums(A^2))
  
  # Objective: we want to maximize r, so minimize -r
  eval_f <- function(x) {
    # x[1:n] are center coordinates, x[n+1] is radius
    return(-x[n+1])
  } # Tells the solver how good this candidate point is 
  
  # Inequality constraints: g(x) ≤ 0
  # For each constraint i: A[i,] %*% c + r * norms[i] - b[i] ≤ 0
  eval_g_ineq <- function(x) {
    c <- x[1:n]
    r <- x[n+1]
    constraints <- A %*% c + r * norms - b
    return(as.vector(constraints))
  }#Tells the solver whether a candidate point is inside the polytope
  
  # Initial guess: center at origin, small radius
  x0 <- c(rep(0, n), 0.1)
  
  # Lower bounds: center unrestricted, radius >= 0
  lb <- c(rep(-Inf, n), 0)
  # Upper bounds: none (Inf)
  ub <- rep(Inf, n + 1)
  
  # Set nloptr options
  opts <- list(
    "algorithm" = "NLOPT_LN_COBYLA",    # LN = Local, No derivatives
    "xtol_rel" = 1e-8,
    "maxeval" = 1000,
    "print_level" = 0               
  )
  
  # Solve
  result <- nloptr(
    x0 = x0,
    eval_f = eval_f,
    lb = lb,
    ub = ub,
    eval_g_ineq = eval_g_ineq,
    opts = opts,
  )
  
  # Extract solution
  center <- result$solution[1:n]
  radius <- result$solution[n + 1]
  
  return(list(
    center = center,
    radius = radius,
    status = result$status,
    message = result$message
  ))
}

# -------------------- TEST WITH SQUARE --------------------
cat("\n=== Square: -1 ≤ x ≤ 1, -1 ≤ y ≤ 1 ===\n")
A_square <- matrix(c(
   1,  0,   # x ≤ 1
  -1,  0,   # -x ≤ 1
   0,  1,   # y ≤ 1
   0, -1    # -y ≤ 1
), nrow = 4, ncol = 2, byrow = TRUE)
b_square <- c(1, 1, 1, 1)

res_square <- compute_max_ball(A_square, b_square)
cat("Center: (", res_square$center[1], ", ", res_square$center[2], ")\n")
cat("Radius: ", res_square$radius, "\n")
cat("Status: ", res_square$status, " - ", res_square$message, "\n\n")

# -------------------- TEST WITH TRIANGLE --------------------
cat("=== Triangle: x ≥ 0, y ≥ 0, x + y ≤ 2 ===\n")
A_tri <- matrix(c(
  -1,  0,   # -x ≤ 0  (x ≥ 0)
   0, -1,   # -y ≤ 0  (y ≥ 0)
   1,  1    # x + y ≤ 2
), nrow = 3, ncol = 2, byrow = TRUE)
b_tri <- c(0, 0, 2)

res_tri <- compute_max_ball(A_tri, b_tri)
cat("Center: (", round(res_tri$center[1], 3), ", ", round(res_tri$center[2], 3), ")\n")
cat("Radius: ", round(res_tri$radius, 3), "\n")
cat("Status: ", res_tri$status, " - ", res_tri$message, "\n")
