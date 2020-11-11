import Foundation

extension Optional where Wrapped == String {
    var intValue: Int {
        return Int(self ?? "0") ?? 0
    }
}

extension String {
    var intValue: Int {
        return Int(self) ?? 0
    }
}
