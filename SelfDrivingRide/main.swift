import Foundation

// MARK: - Hill Climbing

//print("Highest Hill: \(HillClimbing.score(file: .aData))")

//print("Enter max_iterations:")
//let maxIterations = readLine()
//Reader().read(file: .bData)
//print("Highest Hill: \(HillClimbing.solution(file: .bData, maxIterations: maxIterations?.intValue ?? 4).fitness)")

// MARK: - GRASP
print("Enter total time:")
let totalTime = readLine().intValue

print("Enter percentage:")
let percentage = Float(readLine() ?? "0.4") ?? 0.4

print("Enter max_iterations:")
let maxIterations = readLine().intValue

let grasp = GRASP(file: .bData, totalTime: totalTime, p: percentage, m: maxIterations)
grasp.grasp()

print("Solution Score \(grasp.score)")
