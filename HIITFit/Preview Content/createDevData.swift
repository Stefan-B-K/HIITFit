//

import Foundation

extension HistoryStore {
  func createDevData() {
    // Development data
    exerciseDays = [
      ExerciseDay(
        date: Date().addingTimeInterval(-86400),
        exercises: [
          Exercise.exercises[0].name: 2,
          Exercise.exercises[1].name: 1,
          Exercise.exercises[2].name: 1
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 2),
        exercises: [
          Exercise.exercises[1].name: 2,
          Exercise.exercises[0].name: 2
        ])
    ]
  }
  
  convenience init(debugData: Bool) {
    self.init()
    createDevData()
  }
}
