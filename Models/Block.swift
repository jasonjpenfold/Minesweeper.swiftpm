import SwiftUI

enum BlockValue: Int, CustomStringConvertible{
    var description: String{
        switch self{
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight:
            return String(rawValue)
        case .bomb:
            return "💥"
        
        }
            }

    case zero, one, two, three, four, five, six, seven, eight, bomb 
}


struct Block: Identifiable, Hashable{
    var id = UUID()
    var value: BlockValue
    var isOpen: Bool = false
    var isBomb: Bool{
        value == .bomb
    }
    init(value: BlockValue = .zero){
        self.value = value
    }
    mutating func openBlock(){
        isOpen = true
    }
    mutating func increaseValue(){
        let oldValue = value.rawValue
        value = BlockValue(rawValue: oldValue + 1) ?? .zero
    }
}

struct BlockGrid{
    let width: Int
    let mineCount: Int
    var land: [Block]
    
    init(width: Int, mineCount: Int){
        let size = width * width
        self.width = width
        self.mineCount = mineCount
        let grid = Array(repeating: Block(), count: size - mineCount)
        let mines = Array(repeating: Block(value: .bomb), count: mineCount)
        self.land = (grid + mines)
        
    }
    
    func checkIndex(row: Int, col: Int)->Bool{
        guard row >= 0 && row < self.width && col >= 0 && col < self.width else { return false }
        return true
        
    }
    
    func findNeighbours(index: Int)->[Int]{
        var neighbours: [Int] = []
        let row = index / self.width
        let col = index % self.width
        let coordinates = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
        for xy in coordinates{
            let nbRow = row + xy.0
            let nbCol = col + xy.1
            if checkIndex(row: nbRow, col: nbCol){
                neighbours.append((nbRow * self.width) + nbCol)
            }
            
        }
        return neighbours
    }
    mutating func incrementNeighbour(index: Int){
        if self.land[index].value != .bomb{
            self.land[index].increaseValue()
        }
    }
    mutating func createMinefield(){
        self.land.shuffle()

        let mineIndices: [Int] = self.land.enumerated().compactMap{index, block in 
            if block.value == .bomb{ return index}
            return nil
        }
        for mineIndex in mineIndices {
            let neighbours: [Int] = findNeighbours(index: mineIndex)
            for nb in neighbours{
                incrementNeighbour(index: nb)
            }
        }
    }
    func getBlock(row: Int, col: Int)-> Block{
        let index = (row * self.width) + col
        guard index < self.land.count else {
            return Block()
        }
        return self.land[index]
    }
}
    
