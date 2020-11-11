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
        let directoryURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: file.rawValue + `extension`, relativeTo: directoryURL)

        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
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
}
