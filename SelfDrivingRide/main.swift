//
//    a_example: 10
//    b_should_be_easy: 176,727
//    c_no_hurry: 8,272,602
//    d_metropolis: 8,505,007
//    e_high_bonus: 21,465,945
//
//    total: 38,267,291

import Foundation

// MARK: - GRASP
print("Enter total time:")
let totalTime = readLine()?.intValue ?? 10

let inputFile: File  = .bData
print("Enter max_iterations:")
let maxIterations = readLine().intValue

grasp(inputFile: inputFile, totalTime: totalTime, maxIterations: maxIterations)
