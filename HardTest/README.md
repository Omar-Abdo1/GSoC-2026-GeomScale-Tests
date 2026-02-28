# Maximum Inscribed Ball (Chebyshev Center) with nloptr

## Overview

This folder contains an implementation of the **maximum inscribed ball** (Chebyshev center) computation for a convex polytope described by linear inequalities of the form:

```
A x \le b
```

The implementation uses the **CRAN package `nloptr`** (a general‑purpose nonlinear optimization library) to solve the equivalent linear program.

---

## Files

* **HardTest.R** – R script that defines the function `compute_max_ball(A, b)` and tests it on a square and a right triangle.
* **square_output.png** – Screenshot of the output for the square example.
* **triangle_output.png** – Screenshot of the output for the triangle example.
* **README.md** – This file.

---

## Requirements

* **R ≥ 3.5**
* **nloptr** package

Install `nloptr` in R with:

```r
install.packages("nloptr")
```

---

## How to Run

1. Open **R** or **RStudio**.
2. Set the working directory to the location of `HardTest.R`.
3. Run the script:

```r
source("HardTest.R")
```

The console will display the computed centers and radii for both polytopes.

---

## Implementation Details

The polytope is given in **H‑representation**:

```
A x \le b
```

The largest inscribed ball has center **c** and radius **r** satisfying:

```
a_i^T c + r ||a_i|| \le b_i   for all i
r \ge 0
```

The problem is cast as a linear program:

> **maximize** r
> subject to the above constraints

Because `nloptr` performs minimization, we instead minimize **−r**.

Constraints are provided in the form `g(x) ≤ 0`, where:

```
g_i(c, r) = a_i^T c + r ||a_i|| − b_i
```

The script uses the **MMA algorithm (`NLOPT_LD_MMA`)** for gradient‑based optimization.
It also demonstrates results on two simple 2D examples.

---

## Results

### Square: −1 ≤ x ≤ 1, −1 ≤ y ≤ 1

* **Center:** (0, 0)
* **Radius:** 1
  *(as expected)*

### Right Triangle: x ≥ 0, y ≥ 0, x + y ≤ 2

* **Center:** ≈ (0.586, 0.586)
* **Radius:** ≈ 0.586
  *(matches the analytical solution)*

Screenshots of the output are included in this folder for verification.

---

## Notes

* The same approach extends to **higher‑dimensional polytopes** by supplying the appropriate matrices **A** and **b**.
* If gradient information is unavailable, the algorithm can be switched to a derivative‑free method (e.g., `NLOPT_LN_COBYLA`).

---

## GSoC 2026 Context

Part of a **GSoC 2026 application** for the **GeomScale – “Exclude Lpsolve”** project.
