import Foundation

func main() {
    
    Reader().read()
    let vehicles = Simulation.vehicles
    printSolution(vehicles: vehicles)
    printScore(vehicles: vehicles)
}

func printSolution(vehicles: [Vehicle]) {
    vehicles.forEach { vehicle in
        var solution = ""
        solution += "\(vehicle.assignedRides.count) "
        vehicle.assignedRides.forEach { ride in
            solution += "\(ride.id) "
        }
        print(solution)
    }
}

func printScore(vehicles: [Vehicle]) {
    print("\nScore: \(score(vehicles: vehicles))")
}

func score(vehicles: [Vehicle]) -> Int {
    vehicles.map(\.score).reduce(0, +)
}

func printTotalScore() {
    var totalScore = 0
    File.allCases.forEach { file in
        Reader().read(file: file)
        let vehicles = Simulation.vehicles
        print("\(file.rawValue): \(score(vehicles: vehicles))")
        totalScore += score(vehicles: vehicles)
    }
    print("\ntotalScore: \(totalScore)")
}

main()
//printTotalScore()
