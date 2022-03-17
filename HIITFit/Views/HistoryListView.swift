
import SwiftUI

struct HistoryListView: View {
  @EnvironmentObject var history: HistoryStore
  
  var body: some View {
    ScrollView {
      ForEach(history.exerciseDays) {day in
        Section(header:
                  HStack {
          Text(day.date.formatted(as: "MMM d"))
            .font(.title3)
            .fontWeight(.medium)
            .padding()
          Spacer()
        }, footer:
                  Divider()
                  .padding(.top, 40)
        ) {
          
          ScrollView(.horizontal) {
            HStack(spacing: 30) {
              ForEach(day.exercises.sorted(by: >), id: \.key) { exercise, reps in
                VStack {
                  IndentView {
                    Text("\(reps)")
                      .fontWeight(.bold)
                      .font(.title)
                      .frame(minWidth: 60)
                  }
                  .foregroundColor(Color("exercise-history"))
                  .padding([.top, .bottom], 20)
                  Text(exercise)
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(Color.primary)
                }
                .frame(maxWidth: .infinity)
              }
            }
            .padding([.leading, .trailing], 20)
            }
          
          
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
}

struct HistoryListView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryListView()
      .environmentObject(HistoryStore(debugData: true))
  }
}
