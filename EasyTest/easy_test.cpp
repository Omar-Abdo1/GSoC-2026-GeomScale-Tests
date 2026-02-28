#include <iostream>
#include "cartesian_geom/cartesian_kernel.h"
#include "convex_bodies/hpolytope.h"
#include "generators/known_polytope_generators.h"

// 1. Setup the exact types used by volesti architecture
typedef double NT;
typedef Cartesian<NT> Kernel;
typedef Kernel::Point Point;
typedef HPolytope<Point> HpolytopeType;

int main(){

   std::cout << "Starting GSoC 2026 Easy Test: Maximum Ball Computation" << std::endl;
   
    // 2. Generate a 3-dimensional cube 

   unsigned int dimensions = 3;
   HpolytopeType cube = generate_cube<HpolytopeType>(dimensions,false);

   std::cout << "Successfully generated a " << dimensions << "D cube." << std::endl;

    // 3. Compute the maximum inner ball 
    std::cout << "Computing the maximum inscribed ball..." << std::endl;
    std::pair<Point, NT> max_ball = cube.ComputeInnerBall();

    // 4. Print the results
    Point center = max_ball.first;
    NT radius = max_ball.second;

    std::cout << "------------------------------------------------" << std::endl;
    std::cout << "Test Results:" << std::endl;
    std::cout << "Ball Radius: " << radius << std::endl;
    
    std::cout << "Ball Center (Coordinates): ";
    for(unsigned int i=0; i < center.dimension(); i++) {
        std::cout << center[i] << " ";
    }
    std::cout << std::endl;
    std::cout << "------------------------------------------------" << std::endl;
    std::cout << "Test Completed Successfully." << std::endl;

    return 0;
}
