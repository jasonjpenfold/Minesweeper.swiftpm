import SwiftUI

struct ContentView: View {
    
    @Environment(MinesweeperViewModel.self) private var model
    var body: some View {
        VStack {
            Image(systemName: "laser.burst")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Minesweeper!")
            Text("H")
        }
       
        VStack{
            Text("P")
            LazyVGrid(columns: Array(repeating:GridItem(), count: model.width)){
                ForEach([1,2,3,4,5,6,7,8,9,0], id: \.self){
                    num in 
                    Text("\(num)")
                }
                }
            
        }
    }
}
