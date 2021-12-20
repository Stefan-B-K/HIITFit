//

import SwiftUI

struct HeaderView: View {
  let headerName: String
  
  var body: some View {
    VStack {
      Text(headerName)
        .font(.largeTitle)
      HStack {
        ForEach(0..<4) { index in
          Image(systemName: "\(index).circle")
        }
      }
      .font(.title2)
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        HeaderView(headerName: "Squat")
          .previewLayout(.sizeThatFits)
        HeaderView(headerName: "Squat")
          .preferredColorScheme(.dark)
          .environment(\.sizeCategory, .accessibilityLarge)
          .previewLayout(.sizeThatFits)
      }
    }
}
