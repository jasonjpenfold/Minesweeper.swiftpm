import SwiftUI

struct ContentView: View {
    
    @Environment(MinesweeperViewModel.self) private var model
    
    var body: some View {
        @Bindable var viewmodel = model
        
        VStack(spacing:16){
            Spacer()
            HStack {
                Image(systemName: "laser.burst")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, Minesweeper!")
                
            }
            HStack{
                Button(model.touchEqualsFlagged ? "Flag On" : "Flag Off"){
                    model.toggleTouchEqualsFlagged()
                }.disabled(model.gameState != .running)
            }
            
            
            VStack(spacing: 8){
               
                LazyVGrid(columns: model.columns, alignment: .center, spacing: 1){
                    ForEach(0..<model.width, id: \.self){ row in
                        GridRow{
                            ForEach(0..<model.width, id: \.self){
                                col in 
                                
                                    let block = model.getBlock(row: row, col:col)
                                
                               
                                    BlockView(block: block)
                                    .onLongPressGesture(minimumDuration: 0.1, perform: {model.flagBlock(block: block)})
                                
                            }
                        }
                        
                    }
                }
                Spacer()
                Button(model.gameState == .setup ? "Start game" : "Reset game"){
                        model.startGame()
                    }
                                    
                .buttonStyle(.borderedProminent)
            
                Spacer()
            }
        }.padding()
            .background(.gray)
            .alert(model.isWon ? "You Won!" : "Boom - Game Over", isPresented: $viewmodel.isGameOver){
                Button("Start again?"){
                    model.startGame()
                }
            }
            
        }
        
}
