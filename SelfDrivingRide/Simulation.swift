import Foundation

class Simulation {
    
    static var vehicles: [Vehicle] {
        
        var initialVehicles = Vehicle.initial(SimulationInput.numberOfVehicles)
        
        SimulationInput.rides.forEach { ride in
            
            guard SimulationInput.numberOfSteps > 0 else { return }
            
            let fittestVehicleForTheRide = initialVehicles.max {
                ride.fitness(vehicle: $0) < ride.fitness(vehicle: $1)
            }
            
            guard var vehicle = fittestVehicleForTheRide else { return }
            SimulationInput.numberOfSteps -= 1
            
            switch assignRide(vehicle: &vehicle, ride: ride) {
            case .success:
                initialVehicles.addOrUpdate(vehicle: vehicle)
            default: break
            }
        }
        
        return initialVehicles
    }
    
    private static func assignRide(vehicle: inout Vehicle, ride: Ride) -> Result<Void, AssignError> {
        
        if ride.isRideExpired(vehicle: vehicle) {
            return .failure(.expiredRide)
        }
        
        vehicle.assignedRides.append(ride)
        vehicle.score += ride.rideScore(vehicle: vehicle)
        vehicle.currentStep += ride.updatedCurrentStep(vehicle: vehicle)
        vehicle.currentPosition = ride.endPosition
        
        return .success(())
    }
    
    private static func initialSolution(for vehicles: inout [Vehicle]) {
        
        vehicles.forEach { item in
            var vehicle = item
            SimulationInput.rides.forEach { ride in
                switch assignRide(vehicle: &vehicle, ride: ride) {
                case .success:
                    vehicles.addOrUpdate(vehicle: vehicle)
                    SimulationInput.rides.remove(ride)
                default: break
                }
            }
        }
    }
}

enum AssignError: Error {
    case expiredRide
    case noRide
}
