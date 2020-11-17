import Foundation

enum File: String, CaseIterable {
    case aData = "a_example"
    case bData = "b_should_be_easy"
    case cData = "c_no_hurry"
    case dData = "d_metropolis"
    case eData = "e_high_bonus"
}

struct Reader {
    
    func read(file: File = .aData, extension: String = ".in") {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        guard let writePath = NSURL(fileURLWithPath: path + folderPath).appendingPathComponent("Assets/input") else { return }
        try? FileManager.default.createDirectory(atPath: writePath.path, withIntermediateDirectories: true)
        let file = writePath.appendingPathComponent(file.rawValue + `extension`)

        do {
            let text = try String(contentsOf: file, encoding: .utf8)
            let mainArray = text.components(separatedBy: .newlines).filter { $0.isEmpty == false }
            var computedArray = [[String]]()
            mainArray.forEach { string in
                computedArray.append(string.components(separatedBy: " "))
            }
            computedArray.mapSimulationInput()
        } catch let errOpening as NSError {
            print("Error!", errOpening)
        }
    }
    
    func write(vehicles: [Vehicle], toFile file: File) {
        
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        guard let writePath = NSURL(fileURLWithPath: path + folderPath).appendingPathComponent("Assets/output") else { return }
        try? FileManager.default.createDirectory(atPath: writePath.path, withIntermediateDirectories: true)
        let file = writePath.appendingPathComponent(file.rawValue + ".out")
        
        var totalString = ""
        vehicles.forEach { vehicle in
            var solution = ""
            solution += "\(vehicle.assignedRides.count) "
            vehicle.assignedRides.forEach { ride in
                solution += "\(ride.id) "
            }
            solution.removeLast()
            totalString += solution
            totalString += "\n"
        }
        do {
            try totalString.write(to: file, atomically: false, encoding: .utf8)
        } catch let errOpening as NSError {
            print("Error!", errOpening)
        }
    }
}
