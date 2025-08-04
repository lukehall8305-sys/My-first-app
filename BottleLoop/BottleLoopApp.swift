import SwiftUI

@main
struct BottleLoopApp: App {
    @StateObject private var session = SessionViewModel()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                MainTabView()
                    .environmentObject(session)
            } else {
                AuthenticationView()
                    .environmentObject(session)
            }
        }
    }
}