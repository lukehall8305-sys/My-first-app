import Foundation
import Combine

@MainActor
class SessionViewModel: ObservableObject {
    @Published var user: User?

    var isLoggedIn: Bool { user != nil }

    func login(email: String, password: String) async throws {
        let user = try await APIService.shared.login(email: email, password: password)
        self.user = user
    }

    func register(email: String, password: String) async throws {
        let user = try await APIService.shared.register(email: email, password: password)
        self.user = user
    }

    func logout() {
        Task {
            await APIService.shared.logout()
            self.user = nil
        }
    }
}