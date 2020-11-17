import Foundation

class Vehicle {
    
    var id: Int
    var currentPosition: Position = Position(row: 0, column: 0)
    var assignedRides: [Ride] = []
    var score: Int = 0
    var currentStep: Int = 0
    
    init(id: Int) {
        self.id = id
    }
}

extension Vehicle {
    
    func calculateFitness() -> Int {
        
        currentPosition = Position(row: 0, column: 0)
        currentStep = 0
        score = 0
        sortRides()
        
        assignedRides.forEach { ride in
            
            currentStep += currentPosition.distance(to: ride.startPosition)
            currentPosition = ride.startPosition
            
            let time = max(ride.earliestStart, currentStep)
            
            if time == ride.earliestStart {
                score += SimulationInput.bonus
            }
            
            currentStep = time + ride.stepsToEndRide
            
            if currentStep <= ride.latestFinish {
                score += ride.stepsToEndRide
            }
            
            currentPosition = ride.endPosition
        }
        return score
    }
    
    func sortRides() {
        assignedRides = assignedRides.sorted { $0.earliestStart < $1.earliestStart }
    }
    
    static func initial(_ count: Int) -> [Vehicle] {
        var vehicleList = [Vehicle]()
        for index in 0..<count {
            vehicleList.append(Vehicle(id: index))
        }
        return vehicleList
    }
}
