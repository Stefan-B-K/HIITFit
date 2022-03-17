

import SwiftUI
import AVKit

struct ExerciseView: View {
  @State private var showSheet = false
  @State private var timerFinished = false
  @Binding var selectedTab: Int
  @EnvironmentObject var history: HistoryStore
  @AppStorage("ratings") private var ratings = ""
  @State private var rating = 0
  
  @State private var exerciseSheet: ExerciseSheet?
  
  var index: Int
  
  enum ExerciseSheet {
    case history, timer, success
  }
  
  var lastExercise: Bool {
    index + 1 == Exercise.exercises.count
  }
  
  func updateRating(rating: Int) {
    let index = ratings.index(ratings.startIndex, offsetBy: index)
    ratings.replaceSubrange(index...index, with: String(rating))
  }
  
  init(selectedTab: Binding<Int>, index: Int) {
    self._selectedTab = selectedTab
    self.index = index
    if ratings.count < Exercise.exercises.count {
      ratings = ratings.padding(toLength: Exercise.exercises.count, withPad: "0", startingAt: 0)
    }
  }
  
  fileprivate func convertRating() {
    let index = ratings.index(ratings.startIndex, offsetBy: index)
    rating = ratings[index].wholeNumberValue ?? 0
  }
  
  
  @ViewBuilder
  fileprivate func video(size: CGSize) -> some View {
    if let url = Bundle.main.url(
      forResource: Exercise.exercises[index].videoFileName, withExtension: "mp4") {
      VideoPlayer(player: AVPlayer(url: url))
        .frame(height: size.height * 0.25)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(20)
    } else {
      Text("Coudn't find video file \(Exercise.exercises[index].videoFileName).mp4")
        .foregroundColor(.red)
    }
  }
  
  var body: some View {
    GeometryReader { geomery in
      VStack {
        HeaderView(
          selectedTab: $selectedTab,
          titleText: Exercise.exercises[index].name )
          .padding(.bottom)
        Spacer()
        ContainerView {
          VStack {
            video(size: geomery.size)
            startButton
              .opacity(rating < 5 ? 1 : 0.2)
              .disabled(rating >= 5)
              .padding(20)
            RatingView(rating: $rating)
              .onAppear {
                if let lastRecordedDate = history.exerciseDays.first?.date, !lastRecordedDate.isSameDay(as: Date()) {
                  ratings = ""
                  ratings = ratings.padding(toLength: Exercise.exercises.count, withPad: "0", startingAt: 0)
                }
                convertRating()
              }
              .onChange(of: ratings) { _ in
                convertRating()
              }
              .padding()
            Spacer()
            historyButton
          }
        }
        .frame(height: geomery.size.height * 0.80)
        .sheet(isPresented: $showSheet) {
          if exerciseSheet == .timer {
            if timerFinished {
              rating += 1
              history.addExercise(Exercise.exercises[index].name, reps: rating)
              updateRating(rating: rating)
              timerFinished = false
            }
            if lastExercise {
              showSheet = true
              exerciseSheet = .success
            }
          } else {
            exerciseSheet = nil
          }
        } content: {
          if let sheet = exerciseSheet {
            switch sheet {
            case .history:
              HistoryView()
                .environmentObject(history)
            case .timer:
              TimerView(timerFinished: $timerFinished, exercise: Exercise.exercises[index].name)
            case .success:
              SuccessView(selectedTab: $selectedTab)
            }
          }
        }
        
        
      }
    }
  }
  
  var startButton: some View {
    RaisedButton("Start") {
      exerciseSheet = .timer
      timerFinished = false
      showSheet = true
    }
  }
  
  var historyButton: some View {
    Button(
      action: {
        showSheet = true
        exerciseSheet = .history
      }, label: {
        Text("History")
          .fontWeight(.bold)
          .padding([.leading, .trailing], 5)
      })
      .padding(.bottom, 10)
      .buttonStyle(EmbossedButtonStyle())
  }
  
  
}



struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(selectedTab: .constant(1), index: 1)
      .environmentObject(HistoryStore())
      .background(Color.gray)
  }
}




