import Foundation

final class GRASP {
    
    private var totalTime: Int
    private let p: Float
    private let m: Int
    private let file: File
    private let reader = Reader()
    
    var c = [Ride]()
    var c1 = [Ride]()
    var c2 = [Ride]()
    var best = [Vehicle]()
    var s = [Ride]()
    var score = 0
    
    init(
        file: File,
        totalTime: Int,
        p: Float,
        m: Int
    ) {
        self.file = file
        self.totalTime = totalTime
        self.p = p
        self.m = m
    }
    
    func grasp() {
        
        createComponents()
        
        while totalTime > 0 {
            s = [Ride]()
            
            while !isCompleteSolution {
                c1 = remove(s: s, from: c)
                
                if c1.isEmpty {
                    s.removeAll()
                } else {
                    c2 = selectP(from: c1)
                    if let c2Element = c2.randomElement() {
                        s.append(c2Element)
                    }
                }
            }
            
            let hc = HillClimbing.solution(file: file, maxIterations: m, rides: s)
            setScore(hc)
            totalTime -= 1
        }
        
        reader.write(vehicles: best, toFile: file)
    }
    
    func createComponents() {
        reader.read(file: file)
        c = SimulationInput.rides.sorted { $0.stepsToEndRide < $1.stepsToEndRide }
    }
    
    var isCompleteSolution: Bool {
        s.count == Int(Float(SimulationInput.numberOfRides) * p)
    }
    
    func remove(s sRides: [Ride], from cRides: [Ride]) -> [Ride] {
        var components = cRides
        sRides.forEach { ride in
            components.remove(ride)
        }
        return components
    }
    
    func selectP(from c1: [Ride]) -> [Ride] {
        let components = c1.sorted { $0.stepsToEndRide > $1.stepsToEndRide }
        let maxLength = Float(components.count) * p
        return components.suffix(Int(maxLength))
    }
    
    func setScore(_ simulation: Simulation) {
        if simulation.fitness > self.score {
            best = simulation.vehicles
            self.score = simulation.fitness
        }
    }
}
