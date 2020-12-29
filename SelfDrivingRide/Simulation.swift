import Foundation

class Simulation {
    
    var fitness = 0
    var rides: [Ride]
    var vehicles: [Vehicle] = Vehicle.initial(SimulationInput.numberOfVehicles)
    var unAssignedRides = [Ride]()
    
    init(rides: [Ride]) {
        let sortedRides = rides.sorted { $0.stepsToEndRide < $1.stepsToEndRide }
        self.rides = sortedRides
        assignRides()
    }
}

// MARK: - Initial assign
extension Simulation {
    
    func assignRides() {
        
        rides.forEach { ride in
            guard let randomVehicle = vehicles.randomElement(),
                  randomVehicle.isRideExpired(ride: ride) == false
            else {
                unAssignedRides.append(ride)
                return
            }
            guard let firstIndex = self.vehicles.firstIndex(where: { $0.id == randomVehicle.id } ) else { return }
            vehicles[firstIndex].addRide(ride: ride)
        }
        
        unAssignedRides.forEach { ride in
            guard let ride = unAssignedRides.first, let vehicle = vehicles.first(where: { $0.isRideExpired(ride: ride) == false }) else { return }
            vehicle.assignedRides.addOrUpdate(ride: ride)
            unAssignedRides.remove(ride)
        }
    }
    
    var calculatedFitness: Int {
        fitness = 0
        fitness = vehicles.map { $0.calculateFitness() }.reduce(0, +)
        return fitness
    }
}

// MARK: - Operators
extension Simulation {
    
    func tweak() -> Simulation {
        var currentSolution = swapRidesBetweenCars()
        currentSolution = currentSolution.swapRidesOfaGivenCar()
        currentSolution = currentSolution.swapRideNotInSolution()
        return currentSolution
    }

    /// Swap rides between two given cars
    func swapRidesBetweenCars() -> Simulation {
        
        var population: [Simulation] = [self]
        let currentSolution = self
        
        let vehicle1 = currentSolution.vehicles.randomElement()
        let vehicle2 = currentSolution.vehicles.randomElement()
        
        if let vehicle1Ride = vehicle1?.assignedRides.randomElement(),
           let vehicle2Ride = vehicle2?.assignedRides.randomElement()  {
            
            vehicle1?.assignedRides.remove(vehicle1Ride)
            vehicle1?.assignedRides.addOrUpdate(ride: vehicle2Ride)
            
            vehicle2?.assignedRides.remove(vehicle2Ride)
            vehicle2?.assignedRides.addOrUpdate(ride: vehicle1Ride)
            
            population.append(Simulation(rides: currentSolution.rides))
        }
        guard let fittestElement = (population.max { $0.calculatedFitness < $1.calculatedFitness }) else { return self }
        return fittestElement
    }
    
    
    /// Swap rides of a given car
    func swapRidesOfaGivenCar() -> Simulation {
        var population: [Simulation] = [self]
        let currentSolution = self
        guard let vehicle = currentSolution.vehicles.filter({ $0.assignedRides.count > 1 }).randomElement(),
              let vehicleRide1 = vehicle.assignedRides.randomElement(),
              let vehicleRide2 = vehicle.assignedRides.randomElement() else {
            return self
        }
        guard let i = vehicle.assignedRides.firstIndex(where: { $0.id == vehicleRide1.id }),
              let j = vehicle.assignedRides.firstIndex(where: { $0.id == vehicleRide2.id }) else { return self }
        
        vehicle.assignedRides.swapAt(i, j)
        population.append(Simulation(rides: currentSolution.rides))
        
        guard let fittestElement = (population.max { $0.calculatedFitness < $1.calculatedFitness }) else { return self }
        return fittestElement
    }
    
    /// Swap rides in the solution with those not in the solution
    func swapRideNotInSolution() -> Simulation {
        var population: [Simulation] = [self]
        let currentSolution = self
        
        guard let firstVehicle = currentSolution.vehicles.first,
              !currentSolution.vehicles.isEmpty,
              !firstVehicle.assignedRides.isEmpty
        else { return currentSolution }
        
        currentSolution.vehicles.first?.assignedRides.removeFirst()
        guard let ride = currentSolution.unAssignedRides.first else { return self }
        currentSolution.vehicles.first?.assignedRides.addOrUpdate(ride: ride)
        unAssignedRides.remove(ride)
        
        population.append(Simulation(rides: currentSolution.rides))
        
        guard let fittestElement = (population.max { $0.calculatedFitness < $1.calculatedFitness }) else { return self }
        return fittestElement
    }
}
