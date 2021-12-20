

import SwiftUI

struct ExerciseView: View {
  var index: Int
  let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
  let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"]
  
  var body: some View {
    VStack {
      VStack {
        Text(exerciseNames[index])
          .font(.largeTitle)
        HStack {
          ForEach(0..<4) { index in
            Image(systemName: "\(index).circle")
          }
        }
        .font(.title2)
      }
      Text("Video player")
      Text("Timer")
      Text("Start/Done button")
      Text("Rating")
      Text("History button")
    }

  }
}



struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(index: 0)
  }
}
