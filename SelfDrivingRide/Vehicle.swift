import Foundation

struct Vehicle {
    
    var id: Int
    var currentPosition: Position = Position(row: 0, column: 0)
    var assignedRides: [Ride] = []
    var score: Int = 0
    var currentStep: Int = 0
}

extension Vehicle {
    
    static func initial(_ count: Int) -> [Vehicle] {
        var vehicleList = [Vehicle]()
        for index in 0..<count {
            vehicleList.append(Vehicle(id: index + 1))
        }
        return vehicleList
    }
}
