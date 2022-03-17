//

import SwiftUI

struct ContainerView<Content: View>: View {
  var content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0)
        .foregroundColor(Color("background"))
      VStack {
        Spacer()
        Rectangle()
          .frame(height: 25)
          .foregroundColor(Color("background"))
      }
      content
    }
  }
  
}

struct IndentView<Content: View>: View {
  var content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    ZStack {
      content
        .background(
          GeometryReader { geometry in
            Circle()
              .inset(by: -4)
              .stroke(Color("background"), lineWidth: 8)
              .shadow(color: Color("drop-shadow").opacity(0.5), radius: 6, x: 6, y: 6)
              .shadow(color: Color("drop-highlight"), radius: 6, x: -6, y: -6)
              .foregroundColor(Color("background"))
              .clipShape(Circle().inset(by: -1))
              .resized(size: geometry.size)
          }
        )
    }
  }
}


struct Container_Previews: PreviewProvider {
  static var previews: some View {
    ContainerView {
      VStack {
        RaisedButton("Hello World") {}
        .padding(50)
        Button("Tap me!") {}
        .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
      }
    }
    .padding(50)
    .previewLayout(.sizeThatFits)
    
    VStack {
      IndentView {
        Text("5")
          .font(.system(size: 90, design: .rounded))
          .frame(width: 120, height: 120)
      }
      .padding(.bottom, 50)
      IndentView {
        Image(systemName: "hare.fill")
          .font(.largeTitle)
          .foregroundColor(.purple)
          .padding(20)
      }
    }
    .padding(50)
    .previewLayout(.sizeThatFits)
  }
}
