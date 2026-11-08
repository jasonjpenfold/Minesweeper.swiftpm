import SwiftUI

struct BlockView: View{
    @Environment(MinesweeperViewModel.self) private var model
    let block: Block
    var body: some View{
        
            Text("\(block.value.description)")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
                .frame(width:68,height:68)
                
                
                .overlay{
                    if model.gameState == .running && !block.isOpen {
                        Text("⬛️")
                            .font(.largeTitle)
                            .frame(width:68,height:68)
                            .onTapGesture(perform: {
                                
                                
                                model.open(block:block)
                            })
                            .overlay{
                                if block.isFlagged{
                                    Text("❌")
                                }
                            }
                    }else if block.isFlagged{
                        Text("❌")
                    }
                    }
                                
        
                
    }
}


#Preview{
    let block: Block = Block(value: .bomb)
    BlockView(block: block)
}
