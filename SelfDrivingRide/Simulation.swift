import Foundation

class Simulation {
    
    var fitness = 0
    var rides: [Ride]
    var vehicles: [Vehicle] = Vehicle.initial(SimulationInput.numberOfVehicles)
    
    init(rides: [Ride]) {
        self.rides = rides
        assignRides()
    }
}

extension Simulation {
    
    func assignRides() {
        rides.forEach { ride in
            guard let randomVehicle = vehicles.randomElement(),
                  randomVehicle.isRideExpired(ride: ride) == false
            else {
                return
            }
            ride.vehicle = randomVehicle
            guard let firstIndex = self.vehicles.firstIndex(where: { $0.id == randomVehicle.id } ) else { return }
            vehicles[firstIndex].addRide(ride: ride)
        }
    }
    
    var calculatedFitness: Int {
        fitness = 0
        fitness = vehicles.map { $0.calculateFitness() }.reduce(0, +)
        return fitness
    }
}

extension Simulation {
    
    func randomHillClimbing() -> Simulation {
        
        var population = [Simulation]()
        
        for _ in 0..<SimulationInput.numberOfRides {
            
            let ride = rides.randomElement()
            let vehicle = vehicles.randomElement()
            
            let swap = ride?.vehicle
            ride?.vehicle = vehicle
            
            population.append(Simulation(rides: rides))
            
            ride?.vehicle = swap
        }
        
        guard let fittestElement = (population.max { $0.calculatedFitness < $1.calculatedFitness }) else { return self }
        return fittestElement
    }
}
