import SwiftUI

struct ContentView: View {
    
    @Environment(MinesweeperViewModel.self) private var model
    var body: some View {
        VStack(spacing:16){
            Spacer()
            HStack {
                Image(systemName: "laser.burst")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, Minesweeper!")
                
            }
            
            
            VStack(spacing: 8){
               
                LazyVGrid(columns: model.columns, alignment: .center, spacing: 2){
                    ForEach(0..<model.width, id: \.self){ row in
                        GridRow{
                            ForEach(0..<model.width, id: \.self){
                                col in 
                                
                                    let block = model.getBlock(row: row, col:col)
                                
                               
                                    BlockView(block: block)
                                    .onLongPressGesture(minimumDuration: 0.5, perform: {model.flagBlock(block: block)})
                                
                            }
                        }
                        
                    }
                }.background(.gray)
                Spacer()
                Button(model.gameState == .setup ? "Start game" : "Reset game"){
                        model.startGame()
                    }
                                    
                .buttonStyle(.borderedProminent)
            
                Spacer()
            }
        }.padding()
        }
        
}
