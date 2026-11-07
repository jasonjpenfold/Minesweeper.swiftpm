import SwiftUI

enum BlockValue: Int, CustomStringConvertible{
    var description: String{
        switch self{
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight:
            return String(rawValue)
        case .bomb:
            return "BOMB"
        
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
    mutating func openBlock(){
        isOpen = true
    }
    mutating func increaseValue(){
        let oldValue = value.rawValue
        value = BlockValue(rawValue: oldValue + 1) ?? .zero
    }
}

struct BlockGrid{
    var land: [Block]
    init(){
        land = []
    }
    init(width: Int){
        guard width > 3 else {
            self.land = []
            return
        }
        let grid = Array(repeating: Block(value: .zero), count: width * width - 3)
       // let bombs = Array(repeating: Block(value: .bomb), count: 3) 
       // self.land = []
        self.land = grid //+ bombs
      //  self.land.shuffle()
        
    }
}
    
