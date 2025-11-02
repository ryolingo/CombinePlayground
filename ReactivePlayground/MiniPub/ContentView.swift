import SwiftUI

struct ContentView: View {
  @State private var message: String = ""
  private let viewModel =  CounterViewModel()
  
    var body: some View {
      
      VStack {
        Text(message.isEmpty ? "Start!" : message)
          .font(.largeTitle)
          
        Button("Increment") {
          viewModel.increment()
        }
        .buttonStyle(.borderedProminent)
      }
      .onAppear {
        viewModel.starObserving{ text in
          self.message = text
        }
      }
    }
}

#Preview {
  ContentView()
}
