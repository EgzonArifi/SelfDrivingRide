import Foundation

// MARK: - Hill Climbing

print("Enter max_iterations:")
let maxIterations = readLine().intValue
let inputFile: File  = .eData
Reader().read(file: inputFile)
print("Highest Hill: \(HillClimbing.solution(file: inputFile, maxIterations: maxIterations).fitness)")

// MARK: - GRASP
print("Enter total time:")
let totalTime = readLine().intValue

print("Enter max_iterations:")
let maxIterations = readLine().intValue

let trainedPercentage: Float = GRASP.trainedPercentage(file: .bData, totalTime: totalTime, m: maxIterations)
let grasp = GRASP(file: .cData, totalTime: totalTime, p: trainedPercentage, m: maxIterations)
grasp.grasp()

print("Solution Score \(grasp.score)")
