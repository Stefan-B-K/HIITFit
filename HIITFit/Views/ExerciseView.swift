

import SwiftUI
import AVKit

struct ExerciseView: View {
  var index: Int
  let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
  let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"]
  let interval: TimeInterval = 30
  @State var startButton: StartButton = .Start
  
  enum StartButton: String {
    case Start, Done
    mutating func toggle() {
      switch self {
      case .Start: self = .Done
      case .Done: self = .Start
      }
    }
  }
  
  var body: some View {
    GeometryReader { geomery in
      VStack {
        HeaderView(headerName: exerciseNames[index] )
          .padding(.bottom)
        
        if let url = Bundle.main.url(forResource: videoNames[index], withExtension: "mp4") {
          VideoPlayer(player: AVPlayer(url: url))
            .frame(height: geomery.size.height * 0.45)
        } else {
          Text("Не е открит видео файл \(videoNames[index]).mp4")
            .foregroundColor(.red)
        }
        
        Text(Date().addingTimeInterval(interval), style: .timer)
          .font(.system(size: 90))
        
        Button(startButton.rawValue){ startButton.toggle() }
        .font(.title3)
        .padding()
        
        RatingView()
          .padding()
        
        Spacer()
        Button("History") {}
        .padding(.bottom)
      }
    }
    
  }
}



struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(index: 0)
  }
}




