//
//    a_example: 10
//    b_should_be_easy: 172,751
//    c_no_hurry: 6,609,085
//    d_metropolis: 4,127,710
//    e_high_bonus: 15,643,082
//
//    total: 26,533,538

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
            solution = solution.randomHillClimbing()
            print("New Hill: \(solution.fitness)")
        }
        
        // Write
        reader.write(vehicles: bestSolution.vehicles, toFile: file)
        
        return bestScore
    }
    
    static func score(file: File, maxIterations: Int) -> Int {
        
        let reader = Reader()
        reader.read(file: file)
        var solution = Simulation(rides: SimulationInput.rides)
        let startScore = solution.calculatedFitness
        var bestSolution = solution
        var bestScore = 0
        var iterations = maxIterations
        
        print("Start Hill: \(startScore)")
        while iterations > 0 {
            if solution.fitness > bestScore {
                bestSolution = solution
                bestScore = solution.fitness
            }
            solution = solution.randomHillClimbing()
            print("New Hill: \(solution.fitness)")
            iterations -= 1
        }
        reader.write(vehicles: bestSolution.vehicles, toFile: file)
        return bestScore
    }
}
