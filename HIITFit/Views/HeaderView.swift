//

import SwiftUI

struct HeaderView: View {
  @Binding var selectedTab: Int
  let titleText: String
  
  var body: some View {
    VStack {
      Text(titleText)
        .font(.largeTitle)
        .fontWeight(.black)
        .foregroundColor(.white)
      HStack {
        ForEach(0 ..< Exercise.exercises.count) { index in
          ZStack {
            Circle()
              .frame(width: 32, height: 32)
              .foregroundColor(.white)
              .opacity(index == selectedTab ? 0.5 : 0)
            Circle()
              .frame(width: 16, height: 16)
              .foregroundColor(.white)
          }
          .onTapGesture {
            selectedTab = index
          }
        }
      }
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        HeaderView(selectedTab: .constant(1), titleText: "Squat")
          .previewLayout(.sizeThatFits)
          .background(Color.gray)
        HeaderView(selectedTab: .constant(1), titleText: "Squat")
          .preferredColorScheme(.dark)
          .environment(\.sizeCategory, .accessibilityLarge)
          .previewLayout(.sizeThatFits)
      }
    }
}
