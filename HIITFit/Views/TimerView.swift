//

import SwiftUI

struct TimerView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var timerFinished: Bool
  @State private var timeRemaining = 3
  let exercise: String
  let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color("background")
          .edgesIgnoringSafeArea(.all)
        circle(size: geometry.size)
          .overlay(
            GradientBackground()
              .mask(circle(size: geometry.size))
          )
        VStack {
          Text(exercise)
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.white)
            .padding(.top, 20)
          Spacer()
          IndentView {
            timerText
          }
          Spacer()
          RaisedButton("Done") {
            presentationMode.wrappedValue.dismiss()
          }
          .opacity(timerFinished ? 1 : 0)
          .disabled(!timerFinished)
          .padding([.leading, .trailing], 30)
          .padding(.bottom, 60)
        }
        .onAppear {
          timerFinished = false
        }
      }
    }
  }

  var timerText: some View {
    Text("\(timeRemaining)")
      .font(.system(size: 90, design: .rounded))
      .fontWeight(.heavy)
      .frame(
        minWidth: 180,
        maxWidth: 200,
        minHeight: 180,
        maxHeight: 200)
      .padding()
      .onReceive(timer) { _ in
        if self.timeRemaining > 0 {
          self.timeRemaining -= 1
        } else {
          timerFinished = true
        }
      }
  }
  
  func circle(size: CGSize) -> some View {
    Circle()
      .frame(
        width: size.width,
        height: size.height)
      .position(
        x: size.width * 0.5,
        y: -size.width * 0.2)
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView(timerFinished: .constant(false), exercise: "Push-ups")
      .previewLayout(.sizeThatFits)
  }
}
