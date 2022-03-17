
import SwiftUI

@main
struct HIITFitApp: App {
  @StateObject private var historyStore: HistoryStore
  @State private var showAlert = false
  
  init() {
    let historyStore: HistoryStore
    do {
      try historyStore = HistoryStore(withChecking: true)
    } catch {
      showAlert = true
      historyStore = HistoryStore()
    }
    _historyStore = StateObject(wrappedValue: historyStore)
    
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(historyStore)
        .alert(isPresented: $showAlert) {
          Alert(title: Text("History"),
                message: Text(
                  """
                  Неуспешно зареждане на историята с упражнения
                  """))
        }
       
    }
  }
}
