import SwiftUI

@main
struct Minesweeper: App {
    @State private var model = MinesweeperViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                
        }
    }
}
