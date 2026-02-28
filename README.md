
# GSoC 2026 - GeomScale Tests

**Applicant:** Omar Abdo  
**Project:** Exclude Lpsolve (Replace lpSolve in volesti)

This repository contains my solutions to the required tests for the GeomScale GSoC project.


# Repository Structure :


```
.
├── EasyTest/                     # Easy Test: Build volesti and compute inner ball
│   ├── easy_test.cpp             # C++ code to compute Chebyshev center of a cube
│   └── result.png                # Screenshot of the output
├── MediumTest/                   # Medium Test: Research CRAN and C++ LP solvers
│   └── Medium_Test_Report_Omar_Abdo.pdf  # Detailed report (ROI, GLPK, HiGHS + algorithm + examples)
├── HardTest/                      # Hard Test: Implementation with nloptr
│   ├── HardTest.R                 # R script using nloptr to compute maximum inscribed ball
│   ├── square_output.png          # Screenshot of square test result
│   ├── triangle_output.png        # Screenshot of triangle test result
│   └── README.md                  # Brief explanation of the implementation
└── README.md                      # This file
```

## Test Status

- [x] **Easy Test** – Completed  
  - Built the C++ interface of volesti.  
  - Generated a 3D H‑polytope (cube) and computed its maximum inscribed ball using `ComputeInnerBall()`.  
  - See `EasyTest/` for source code and output screenshot.

- [x] **Medium Test** – Completed  
  - Identified one additional CRAN package: **ROI** (R Optimization Infrastructure).  
  - Identified two open‑source C++ LP solvers: **GLPK** and **HiGHS**.  
  - Explained the algorithm for the Chebyshev center and provided simple 2D examples (square, right triangle).  
  - Full report available in `MediumTest/`.

- [x] **Hard Test** – Completed
  - Implemented the maximum inscribed ball computation using the CRAN package nloptr
  - The R script HardTest.R defines a function **compute_max_ball(A, b)** and tests it on a square and a right triangle
  - Results match the expected values: square → center (0,0), radius 1; triangle → center (0.586,0.586), radius 0.586. 
  - See `HardTest/`. for the code and output screenshots.

---

## Contact

- GitHub: [@OmarAbdo](https://github.com/Omar-Abdo1)  
- Email: omarradwan10a@gmail.com 
