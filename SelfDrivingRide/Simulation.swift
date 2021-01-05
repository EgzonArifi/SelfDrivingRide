import Foundation

class Simulation: NSCopying {
    
    var fitness = 0
    var rides: [Ride]
    var vehicles: [Vehicle] = Vehicle.initial(SimulationInput.numberOfVehicles)
    var unAssignedRides = [Ride]()
    
    init(rides: [Ride]) {
        let sortedRides = rides.sorted { $0.earliestStart < $1.earliestStart }
        self.rides = sortedRides
        assignRides()
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Simulation(rides: rides)
        copy.fitness = fitness
        copy.vehicles = vehicles
        copy.unAssignedRides = unAssignedRides
        return copy
    }
}

// MARK: - Initial assign
extension Simulation {
    
    func assignRides() {
        
        var calculatedRides = [Ride]()
        calculatedRides.append(contentsOf: rides)
        
        for vehicle in vehicles {
            guard let ride = calculatedRides.first,
                  let firstIndex = self.vehicles.firstIndex(where: { $0.id == vehicle.id } ) else { return }
            vehicles[firstIndex].addRide(ride: ride)
            calculatedRides.remove(ride)
        }
        
        calculatedRides.forEach { ride in
            guard let randomVehicle = vehicles.sorted(by: { $0.score(for: ride) < $1.score(for: ride) }).suffix(10).randomElement(),
                  randomVehicle.isRideExpired(ride: ride) == false
            else {
                unAssignedRides.append(ride)
                return
            }
            guard let firstIndex = self.vehicles.firstIndex(where: { $0.id == randomVehicle.id } ) else { return }
            vehicles[firstIndex].addRide(ride: ride)
        }
        
        unAssignedRides.forEach { ride in
            guard let vehicle = vehicles.sorted(by: { $0.score(for: ride) < $1.score(for: ride) }).suffix(10).randomElement(),
                  vehicle.isRideExpired(ride: ride) == false else { return }
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
