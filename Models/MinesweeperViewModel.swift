import SwiftUI

@Observable
class MinesweeperViewModel{
    private(set) var width: Int
    private(set) var mineland: BlockGrid
    private(set) var mineCount: Int
    private(set) var columns: [GridItem]
    
    enum GameState{
        case setup
        case running
        case gameover
    }
    private(set) var gameState: GameState
    
    init(width: Int = 6, mineCount: Int = 2){
        self.width = width
        self.mineCount = mineCount
        self.mineland = BlockGrid(width: width, mineCount: mineCount)
        self.columns = Array(repeating: GridItem(.flexible(minimum: 16, maximum: 100)), count: width)
        self.gameState = .setup
        
    }
    func startGame(){
        mineland.createMinefield()
        gameState = .running
    }
    func getBlock(row: Int, col: Int)->Block{
        self.mineland.getBlock(row: row, col: col)
    }
}
