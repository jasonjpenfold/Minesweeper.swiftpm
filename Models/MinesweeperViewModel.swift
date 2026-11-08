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
    var isGameOver: Bool = false
    private(set) var touchEqualsFlagged = false
    
    init(width: Int = 9, mineCount: Int = 10){
        self.width = width
        self.mineCount = mineCount
        self.mineland = BlockGrid(width: width, mineCount: mineCount)
        self.columns = Array(repeating: GridItem(), count: width)
        self.gameState = .setup
        
    }
    func startGame(){
        
        self.mineland = BlockGrid(width: width, mineCount: mineCount)
        mineland.createMinefield()
        gameState = .running
        isGameOver = false
        touchEqualsFlagged = false
    }
    func getBlock(row: Int, col: Int)->Block{
        self.mineland.getBlock(row: row, col: col)
    }
    func open(block:Block){
        if block.isFlagged{ return }
        mineland.openBlock(block: block)
        if block.isBomb{
            gameState = .gameover
            isGameOver = true
        }
    }
    func flagBlock(block: Block){
        mineland.flagBlock(block: block)
    }
    func toggleTouchEqualsFlagged(){
        touchEqualsFlagged.toggle()
    }
    func blockTapped(block: Block){
        if touchEqualsFlagged{
            flagBlock(block: block)
            return
        }
        open(block: block)
    }
}
