//

import SwiftUI

struct RaisedButton: View {
  let text: String
  let action: () -> Void
  
  init(_ text: String, action: @escaping () -> Void) {
    self.text = text
    self.action = action
  }
  
  var body: some View {
    Button(action: { action() },
           label: {
      Text(text)
        .raisedButtonTextStyle()
    })
      .buttonStyle(RaisedButtonStyle())
  }
}


extension Text {
  func raisedButtonTextStyle() -> some View {
    self
      .font(.body)
      .fontWeight(.bold)
  }
}

struct RaisedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .padding([.top, .bottom], 12)
      .background(
        Capsule()
          .foregroundColor(Color("background"))
          .shadow(color: Color("drop-shadow"), radius: 4, x: 6, y: 6)
          .shadow(color: Color("drop-highlight"), radius: 4, x: -6, y: -6)
      )
  }
}



struct RaisedButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      RaisedButton("Get started") { print ("Get started") }
        .padding(20)
    }
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
    
    ZStack {
      RaisedButton("Get started") { print ("Get started") }
        .padding(20)
    }
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
    .preferredColorScheme(.dark)
  }
}

