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
                LazyVGrid(columns: model.columns, alignment: .center, spacing: 16){
                    ForEach(0..<model.width, id: \.self){ row in
                        GridRow{
                            ForEach(0..<model.width, id: \.self){
                                col in 
                                
                                    let block = model.getBlock(row: row, col:col)
                                
                                if model.gameState == .setup || block.isOpen{
                                    BlockView(block: block)
                                        
                                }else if model.gameState == .running && !block.isOpen{
                                    HStack(spacing:16){
                                        Text("⬛️")
                                            .font(.largeTitle)
                                            .onTapGesture(perform: {
                                                print("ContantView block: \(block)")
                                                print("row:\(row) col: \(col)")
                                                model.open(block:block)
                                            })
                                        
                                    }
                                }
                                                                        
                                    
                                
                                                            }
                        }
                        
                    }
                }
                Spacer()
                Button("Start game"){
                    model.startGame()
                }
                .buttonStyle(.borderedProminent)
                .disabled(model.gameState != .setup)
                Spacer()
            }
        }
        }
        
}
