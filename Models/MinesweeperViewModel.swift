import SwiftUI

@Observable
class MinesweeperViewModel{
    private(set) var width: Int
    private(set) var mineland: BlockGrid
    
    
    init(){
        self.width = 9
        self.mineland = BlockGrid()
        
    }
}
