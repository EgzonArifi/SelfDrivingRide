import Foundation

extension Array where Element == [String] {
    func mapSimulationInput() {
        guard let firstRow = self.first else { return }
        SimulationInput.rows = firstRow[0].intValue
        SimulationInput.columns = firstRow[1].intValue
        SimulationInput.numberOfVehicles = firstRow[2].intValue
        SimulationInput.numberOfRides = firstRow[3].intValue
        SimulationInput.bonus = firstRow[4].intValue
        SimulationInput.numberOfSteps = firstRow[5].intValue

        SimulationInput.rides.removeAll()
        for index in 1...SimulationInput.numberOfRides {
            let currentRow = self[index]
            let a = currentRow[0].intValue
            let b = currentRow[1].intValue
            let x = currentRow[2].intValue
            let y = currentRow[3].intValue
            let s = currentRow[4].intValue
            let f = currentRow[5].intValue
            
            let ride = Ride(
                id: index - 1,
                startPosition: Position(row: a, column: b),
                endPosition: Position(row: x, column: y),
                earliestStart: s,
                latestFinish: f
            )
            SimulationInput.rides.append(ride)
        }
    }
}

extension Array where Element == Vehicle {
    mutating func addOrUpdate(vehicle: Vehicle) {
        guard let vehicleIndex = firstIndex(where: { $0.id == vehicle.id }) else {
            append(vehicle); return
        }
        self[vehicleIndex] = vehicle
    }
    
    mutating func remove(_ vehicle: Vehicle) {
        guard let index = firstIndex(where: { $0.id == vehicle.id }) else {
            return
        }
        self.remove(at: index)
    }
}

extension Array where Element == Ride {
    mutating func remove(_ ride: Ride) {
        guard let index = firstIndex(where: { $0.id == ride.id }) else {
            return
        }
        self.remove(at: index)
    }
    
    mutating func addOrUpdate(ride: Ride) {
        guard let rideIndex = firstIndex(where: { $0.id == ride.id }) else {
            append(ride); return
        }
        self[rideIndex] = ride
    }
}
