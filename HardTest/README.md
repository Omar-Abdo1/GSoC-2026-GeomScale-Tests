# Maximum Inscribed Ball (Chebyshev Center) with nloptr

## Overview

This folder contains an implementation of the **maximum inscribed ball** (Chebyshev center) computation for a convex polytope described by linear inequalities of the form:

```
Ax <= b
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
Ax <= b
```

The largest inscribed ball has center **c** and radius **r** satisfying:

```
a_i^T c + r ||a_i|| <= b_i   for all i
r >= 0
```

The problem is cast as a linear program:

> **maximize** r
> subject to the above constraints

Because `nloptr` performs minimization, we instead minimize **−r**.

Constraints are provided in the form `g(x) ≤ 0`, where:

```
g_i(c, r) = a_i^T c + r ||a_i|| - b_i
```

The script uses the COBYLA algorithm (NLOPT_LN_COBYLA) from nloptr. This is a derivative‑free optimization method that works well for problems with nonlinear constraints and does not require gradient information. It reliably finds the correct solution for the tested examples.

Although gradient‑based algorithms (such as MMA) could offer faster convergence, we chose COBYLA because it avoids the need to compute and supply gradients, simplifying the implementation and reducing the risk of errors. For the small‑scale test problems considered (square and triangle), the speed difference is negligible, and COBYLA still produces accurate results.

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
---

## GSoC 2026 Context

Part of a **GSoC 2026 application** for the **GeomScale – “Exclude Lpsolve”** project.
