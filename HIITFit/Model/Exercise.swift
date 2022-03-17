//

import Foundation
import SwiftUI

struct Exercise {
  let name: String
  let videoFileName: String
    
  enum ExerciseLabels: String, CaseIterable {
    case squat = "Squat"
    case stepUp = "Step-Up"
    case burpee = "Burpee"
    case sunSalute = "Sun-Salute"
    
    var description: String {
      switch self {
      case .squat:
        return "Squat"
      case .stepUp:
        return "Step-Up"
      case .burpee:
        return "Burpee"
      case .sunSalute:
        return "Sun-Salute"
      }
    }
  }

}

extension Exercise {
  static var exercises: [Exercise] {
    var exercises: [Exercise] = []
    for exercise in ExerciseLabels.allCases {
      exercises.append(Exercise(name: String(describing: exercise), videoFileName: exercise.rawValue.lowercased()))
    }
    return exercises
  }
}

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercises: [String:Int] = [:]
}
