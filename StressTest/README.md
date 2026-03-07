# Stress Test: Why lp_solve Must Be Replaced

## Goal
To prove with experimental data that lp_solve fails for high-dimensional polytopes, which is the core problem this GSoC project aims to solve.

## The Test
We generated random H-polytopes (using the code in `stress_test.cpp`) with dimensions from 10 to 70. For each dimension, we created 10 random polytopes and asked lp_solve (through volesti) to compute the largest inscribed ball (Chebyshev center). We then checked if the returned solution was truly feasible—i.e., if the center satisfied all constraints within a small tolerance (`1e-6`).

## Key Results
| Dimension | Success Rate (out of 10) |
|-----------|--------------------------|
| 10        | 10/10                    |
| 20        | 10/10                    |
| 30        | 10/10                    |
| 40        | 10/10                    |
| 50        | 9/10                     |
| 60        | 10/10                    |
| 70        | 4/10                     |

## What This Means
- Up to dimension 40, lp_solve is reliable.
- At dimension 50, the first numerical issue appears.
- At dimension 70, the success rate drops to **only 40%**. The other 60% of cases either produced results that violated the constraints or threw exceptions.

This experiment confirms that lp_solve is **not reliable** for dimensions above 60–70, which is exactly why volesti needs a modern, robust solver like HiGHS.

## How to Compile and Run

Use the following command (tested on Linux with Eigen3 and lp_solve installed):

```bash
g++ -O3 stress_test.cpp -I./include -I/usr/include/eigen3 -I/usr/include/lpsolve -llpsolve55 -lcolamd -lamd -lm -ldl -o stress_test

./stress_test
```



## Files
- `stress_test.cpp`: The complete C++ code used for the test.
- `results_table.png`: Screenshot of the console output showing the table above.
