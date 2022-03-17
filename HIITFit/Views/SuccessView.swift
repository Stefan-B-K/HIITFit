//

import SwiftUI

struct SuccessView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var selectedTab: Int
  
  var body: some View {
    ZStack {
      VStack {
        Image(systemName: "hand.raised.fill")
          .resizedToFill(width: 75, height: 75)
          .foregroundColor(.purple)
        Text("Браво!")
          .font(.largeTitle)
          .fontWeight(.bold)
        Text("Завършихте всички четири упражнения. Не забравяйте, че и утре може да постигнете същото. Хранете се и живейте здравословно!")
          .foregroundColor(.gray)
          .frame(width: 340)
          .multilineTextAlignment(.center)
      }
      
      VStack {
        Spacer()
        continueButton
      }
    }
  }
  
  var continueButton: some View {
    Button(
      action: {
        selectedTab = 9
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Text("Продължете")
          .fontWeight(.bold)
          .padding([.leading, .trailing], 5)
      })
      .padding(.bottom, 40)
      .buttonStyle(EmbossedButtonStyle())
  }
}

struct SuccessView_Previews: PreviewProvider {
  static var previews: some View {
    SuccessView(selectedTab: .constant(3))
  }
}
