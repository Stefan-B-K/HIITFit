//

import SwiftUI

struct EmbossedButtonStyle: ButtonStyle {
  var buttonShape = EmbossedButtonShape.capsule
  var isOn = true
  
  enum EmbossedButtonShape {
    case round, capsule
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(10)
      .background(
        GeometryReader {geometry in
          shape(size: geometry.size)
            .foregroundColor(Color("background"))
            .shadow(color: Color("drop-shadow"), radius: 1, x: 2, y: 2)
            .shadow(color: Color("drop-highlight"), radius: 1, x: -2, y: -2)
            .offset(x: -1, y: -1)
            .opacity(isOn ? 1 : 0)
        }
      )
  }
  
  @ViewBuilder
  func shape(size: CGSize) -> some View {
    switch buttonShape {
    case .round:
      Circle()
        .stroke(Color("background"), lineWidth: 2)
        .offset(x: -1)                                            // half the stroke
        .resized(size: size)                                      // custom View extension
    case .capsule:
      Capsule()
        .stroke(Color("background"), lineWidth: 2)
    }
  }
}



struct EmbossedButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Button(action: {},
             label: {
        Text("History")
          .fontWeight(.bold)
      })
        .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
    }
    .padding(40)
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
    
    ZStack {
      Button(action: {},
             label: {
        Text("History")
          .fontWeight(.bold)
      })
        .buttonStyle(EmbossedButtonStyle())
    }
    .padding(40)
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
    
    ZStack {
      Button(action: {},
             label: {
        Text("History")
          .fontWeight(.bold)
      })
        .buttonStyle(EmbossedButtonStyle())
    }
    .padding(40)
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
    .preferredColorScheme(.dark)
  }
  
}
