import SwiftUI

struct BlockView: View{
    @Environment(MinesweeperViewModel.self) private var model
    let block: Block
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .shadow(radius: 5)
            Text("\(block.value.description)")
                .font(.caption)
                .foregroundColor(.black)
                .padding()
                .frame(width:40,height:40)
            
            
                .overlay{
                    if model.gameState == .running && !block.isOpen {
                        Text("⬛️")
                            .font(.caption)
                            
                            .onTapGesture(perform: {
                                
                                model.blockTapped(block: block)
                                
                            })
                            .overlay{
                                if block.isFlagged{
                                    Text("❌")
                                }
                            }
                    }else if block.isFlagged{
                        Text("❌")
                    }
                }.frame(width: 40, height: 40)
            
        }
            
                                
        
                
    }
}


#Preview{
    let block: Block = Block(value: .bomb)
    BlockView(block: block)
}
