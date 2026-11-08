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
                .font(.title)
                .bold()
                .monospaced()
                .foregroundColor(.black)
                .padding()
                .frame(width:60,height:60)
            
            
                .overlay{
                    if model.gameState == .running && !block.isOpen {
                       // Text("⬛️")
                         //   .font(.callout)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width: 36, height: 36)
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
                }.frame(width: 36, height: 36)
            
        }
            
                                
        
                
    }
}


#Preview{
    let block: Block = Block(value: .bomb)
    BlockView(block: block)
}
