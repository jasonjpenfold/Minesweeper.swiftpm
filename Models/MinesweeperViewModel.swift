import SwiftUI

@Observable
class MinesweeperViewModel{
    private(set) var width: Int
    private(set) var mineland: BlockGrid
    private(set) var mineCount: Int
    
    
    init(width: Int = 6, mineCount: Int = 2){
        self.width = width
        self.mineCount = mineCount
        self.mineland = BlockGrid(width: width, mineCount: mineCount)
        
    }
    func startGame(){
        mineland = BlockGrid(width: width, mineCount: mineCount)
    }
    func getBlock(row: Int, col: Int)->Block{
        self.mineland.getBlock(row: row, col: col)
    }
}
