//

import Foundation

class HistoryStore: ObservableObject {
  @Published var exerciseDays: [ExerciseDay] = [] {
    didSet {
      do {
        try save()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  enum FileError: Error {
    case loadFucked
    case saveFucked
    case urlFucked
  }
  
  init() { }
  
  init(withChecking: Bool) throws {
        #if DEBUG
    //    createDevData()
        #endif
    
    do {
      try load()
    } catch {
      throw error
    }
  }
  
  func addExercise(_ exercise: String, reps: Int) {
    let today = Date()
    
    if !exerciseDays.isEmpty && today.isSameDay(as: exerciseDays[0].date) {
      exerciseDays[0].exercises[exercise] = reps
    } else {
      exerciseDays.insert(ExerciseDay(date: today, exercises: [exercise:reps]), at: 0)
    }
  }
  
  func getURL() -> URL? {
    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    return documentsURL.appendingPathComponent("history.plist")
  }
  
  func save() throws {
    guard let dataURL = getURL() else { throw FileError.urlFucked }
    let plistData = exerciseDays.map {
      [$0.id.uuidString,
       $0.date,
       $0.exercises]
    }
    do {
      let data = try PropertyListSerialization.data(fromPropertyList: plistData, format: .binary, options: .zero)
      try data.write(to: dataURL, options: .atomic)
    } catch {
      throw FileError.saveFucked
    }
    
  }
  
  func load() throws {
    guard let dataURL = getURL() else { throw FileError.urlFucked }
    guard let data = try? Data(contentsOf: dataURL) else { return }
    do {
      let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
      let convertedPlistData = plistData as? [[Any]] ?? []
      exerciseDays = convertedPlistData.map{
        ExerciseDay(date: $0[1] as? Date ?? Date(),
                    exercises: $0[2] as? [String:Int] ?? [:])
      }
    } catch {
      throw FileError.loadFucked
    }
    
  }
  
}



