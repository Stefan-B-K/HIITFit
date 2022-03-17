//

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int
  let maximumRating = 5
  
  let onColor = Color.red
  let offColor = Color.gray
  
  var body: some View {
    HStack {
      ForEach(1 ..< maximumRating + 1) { index in
        Button {} label: {
          Image(systemName: "waveform.path.ecg")
            .foregroundColor(index > rating ? offColor : onColor)
            .font(.headline)
        }
        .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
      }
    }
    .padding([.leading, .trailing], 15)
  }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
      return RatingView(rating: .constant(0))
        .previewLayout(.sizeThatFits)
    }
}
