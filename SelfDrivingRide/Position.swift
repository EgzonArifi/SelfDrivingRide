import Foundation

struct Position {
    
    private(set) var row: Int
    private(set) var column: Int
}

extension Position {
    func distance(to position: Position) -> Int {
        abs(row - position.row) + abs(column - position.column)
    }
}
