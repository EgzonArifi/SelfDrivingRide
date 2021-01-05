//
//    a_example: 10
//    b_should_be_easy: 169,986
//    c_no_hurry: 8,272,602
//    d_metropolis: 8,505,007
//    e_high_bonus: 20,832,290
//
//    total: 37,626,895

import Foundation

struct HillClimbing {
    
    static func score(file: File) -> Int {
        
        // Read
        let reader = Reader()
        reader.read(file: file)
        
        // Generate
        var solution = Simulation(rides: SimulationInput.rides)
        
        // Evaluate
        let startScore = solution.calculatedFitness
        var bestSolution = solution
        var bestScore = 0
        print("Start Hill: \(startScore)")
        
        // Mutate
        while bestScore < solution.fitness {
            bestScore = solution.fitness
            bestSolution = solution
            solution = solution.tweak()
            print("New Hill: \(solution.fitness)")
        }
        
        // Write
        reader.write(vehicles: bestSolution.vehicles, toFile: file)
        
        return bestScore
    }
    
    static func solution(file: File, maxIterations: Int, rides: [Ride] = SimulationInput.rides) -> Simulation {
        // Read
        let reader = Reader()
        
        // Generate
        var solution = Simulation(rides: rides)
        
        // Evaluate
        let startScore = solution.calculatedFitness
        var bestSolution = solution.copy() as! Simulation
        var bestScore = solution.fitness
        var iterations = maxIterations
        
        print("Start Hill: \(startScore)")
        while iterations > 0 {
            solution = solution.tweak()
            print("New Hill: \(solution.fitness)")
            iterations -= 1
            if solution.fitness > bestScore {
                bestSolution = solution.copy() as! Simulation
                bestScore = solution.fitness
            }
        }
        reader.write(vehicles: bestSolution.vehicles, toFile: file)
        return bestSolution
    }
}
