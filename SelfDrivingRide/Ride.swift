import Foundation

struct Ride {
    
    private(set) var id: Int
    private(set) var startPosition: Position
    private(set) var endPosition: Position
    private(set) var earliestStart: Int
    private(set) var latestFinish: Int
    private(set) var stepsToEndRide: Int = 0
    
    init(
        id: Int,
        startPosition: Position,
        endPosition: Position,
        earliestStart: Int,
        latestFinish: Int
    ) {
        self.id = id
        self.startPosition = startPosition
        self.endPosition = endPosition
        self.earliestStart = earliestStart
        self.latestFinish = latestFinish
        
        stepsToEndRide = distance(from: startPosition, to: endPosition)
    }
}

extension Ride {
    
    var minScore: Int {
        stepsToEndRide
    }
    
    var maxScore: Int {
        stepsToEndRide + SimulationInput.bonus
    }
    
    func distance(from startPosition: Position, to endPosition: Position) -> Int {
        abs(startPosition.row - endPosition.row) + abs(startPosition.column - endPosition.column)
    }
    
    func stepsToCompleteFromCurrentPosition(vehicle: Vehicle) -> Int {
        stepsToStartTheRide(vehicle: vehicle) + stepsToEndRide
    }
    
    
    func stepsToStartTheRide(vehicle: Vehicle) -> Int {
        distance(from: startPosition, to: vehicle.currentPosition)
    }
    
    func isRideExpired(vehicle: Vehicle) -> Bool {
        let stepsToStart = vehicle.currentStep + stepsToStartTheRide(vehicle: vehicle)
        return stepsToStart + stepsToEndRide >= latestFinish
    }
}

extension Ride {
    
    func fitness(vehicle: Vehicle) -> Int {
        
        if isRideExpired(vehicle: vehicle) {
            return Int.min
        }
        
        let stepsToStart = vehicle.currentStep + stepsToStartTheRide(vehicle: vehicle)
        
        if stepsToStart == earliestStart {
            return maxScore
        }
        
        if stepsToStart > earliestStart {
            return minScore
        }
        
        return maxScore - waitingTime(vehicle: vehicle)
    }
    
    func rideScore(vehicle: Vehicle) -> Int {
        
        let stepsToStart = vehicle.currentStep + stepsToStartTheRide(vehicle: vehicle)
        
        if isRideExpired(vehicle: vehicle) {
            return 0
        }
        
        return stepsToStart <= earliestStart ? maxScore : minScore
    }
    
    func waitingTime(vehicle: Vehicle) -> Int {
        let stepsToStart = vehicle.currentStep + stepsToStartTheRide(vehicle: vehicle)
        return earliestStart - stepsToStart
    }
    
    func updatedCurrentStep(vehicle: Vehicle) -> Int {
        var currentStep = vehicle.currentStep
        let time = waitingTime(vehicle: vehicle)
        currentStep += time > 0 ? time : 0
        currentStep += stepsToCompleteFromCurrentPosition(vehicle: vehicle)
        return currentStep
    }
}
