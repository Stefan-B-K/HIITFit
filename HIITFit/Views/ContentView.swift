

import SwiftUI

struct ContentView: View {
//  @State private var selectedTab = 9
  @SceneStorage("selectedTab") private var selectedTab = 9
  
  var body: some View {
    ZStack {
      GradientBackground()
      TabView(selection: $selectedTab) {
        WelcomeView(selectedTab: $selectedTab)
          .tag(9)
        ForEach(0..<Exercise.exercises.count) { index in
          ExerciseView(selectedTab: $selectedTab, index: index)
            .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
  }
}

extension View {
  func resized(size: CGSize) -> some View {
    self
    .frame(width: max(size.width, size.height),
           height: max(size.width, size.height))                           
    .offset(y: -max(size.width, size.height) / 2 +
            min(size.width, size.height) / 2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

