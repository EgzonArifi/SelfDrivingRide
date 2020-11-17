import Foundation

class Ride {
    
    private(set) var id: Int
    private(set) var startPosition: Position
    private(set) var endPosition: Position
    private(set) var earliestStart: Int
    private(set) var latestFinish: Int
    private(set) var stepsToEndRide: Int = 0
    var vehicle: Vehicle?
    
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
        self.stepsToEndRide = startPosition.distance(to: endPosition)        
    }
}
