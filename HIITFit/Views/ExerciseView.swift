

import SwiftUI

struct ExerciseView: View {
  var index: Int
  let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
  let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"]
  
  var body: some View {
    VStack {
      HeaderView(headerName: exerciseNames[index] )
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


