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

print("Enter max_iterations:")
let maxIterations = readLine().intValue

let trainedPercentage = GRASP.trainedPercentage(file: .bData, totalTime: totalTime, m: maxIterations)
let grasp = GRASP(file: .bData, totalTime: totalTime, p: trainedPercentage, m: maxIterations)
grasp.grasp()

print("Solution Score \(grasp.score)")
