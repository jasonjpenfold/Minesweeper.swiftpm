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
            
            
            VStack(spacing: 16){
                Spacer()
                Grid(alignment: .center, horizontalSpacing: 30, verticalSpacing: 30){
                    ForEach(0..<model.width, id: \.self){ row in
                        GridRow{
                            ForEach(0..<model.width, id: \.self){
                                col in 
                                
                                    let block = model.getBlock(row: row, col:col)
                                    BlockView(block: block)
                                    
                                
                                                            }
                        }
                        
                    }
                }
                Spacer()
                Button("Start game"){
                    model.startGame()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        }
        
}
