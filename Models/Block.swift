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
        self.land = (grid + mines).shuffled()
        
        
        
    }
    func getBlock(row: Int, col: Int)-> Block{
        let index = (row * self.width) + col
        guard index < self.land.count else {
            return Block()
        }
        return self.land[index]
    }
}
    
