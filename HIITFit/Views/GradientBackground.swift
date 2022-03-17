//

import SwiftUI

struct GradientBackground: View {
  var gradient: Gradient {
    Gradient(stops: [
      Gradient.Stop(color: Color("gradient-top"), location: 0),
      Gradient.Stop(color: Color("gradient-bottom"), location: 0.85),
      Gradient.Stop(color: Color("background"), location: 0.85),
      Gradient.Stop(color: Color("background"), location: 1)
    ])
  }

  
  var body: some View {
    LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
      .edgesIgnoringSafeArea(.all)
  }
}

struct GradientBackground_Previews: PreviewProvider {
  static var previews: some View {
    GradientBackground()
      .frame(width: 300, height: 300)
      .previewLayout(.sizeThatFits)
  }
}
