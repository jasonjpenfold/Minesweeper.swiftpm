import SwiftUI

struct BlockView: View{
    let block: Block
    var body: some View{
        HStack(spacing:16){
            Text("\(block.value.description)")
                .font(.largeTitle)
            
        }
                
    }
}


#Preview{
    let block: Block = Block(value: .bomb)
    BlockView(block: block)
}
