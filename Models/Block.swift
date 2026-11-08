import SwiftUI

enum BlockValue: Int, CustomStringConvertible{
    var description: String{
        switch self{
        case .one, .two, .three, .four, .five, .six, .seven, .eight:
            return String(rawValue)
        case .zero:
            return " "
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
    var isFlagged: Bool = false
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
    mutating func flagged(){
        isFlagged.toggle()
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
       
        let grid = (0..<(size - mineCount)).map{_ in Block()}
        
       
        let mines = (0..<mineCount).map{_ in Block(value: .bomb)}
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
    mutating func openBlock(block: Block){
        
        if let blockToOpen = self.land.firstIndex(where: {$0.id == block.id}){
            
            land[blockToOpen].openBlock()
            
        }
                
    }
    mutating func flagBlock(block: Block){
        if let blockToFlag = self.land.firstIndex(where: {$0.id == block.id}){
            
            land[blockToFlag].flagged()
            
        }
    }
}
    
