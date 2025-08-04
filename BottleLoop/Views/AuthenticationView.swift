import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var session: SessionViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        VStack(spacing: 24) {
            Text("BottleLoop")
                .font(.largeTitle).bold()
                .padding(.top, 60)

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(8)

            SecureField("Password", text: $password)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(8)

            if let error { Text(error).foregroundColor(.red) }

            Button(action: submit) {
                if isLoading { ProgressView() } else { Text(isRegistering ? "Register" : "Login").bold().frame(maxWidth: .infinity) }
            }
            .padding().background(Color.green).foregroundColor(.white).cornerRadius(8)
            .disabled(isLoading)

            Button(isRegistering ? "Have an account? Log in" : "No account? Register") { isRegistering.toggle() }
                .font(.footnote)

            Spacer()
        }
        .padding()
    }

    private func submit() {
        guard !email.isEmpty, !password.isEmpty else { error = "Fill all fields"; return }
        error = nil; isLoading = true
        Task {
            do {
                if isRegistering {
                    try await session.register(email: email, password: password)
                } else {
                    try await session.login(email: email, password: password)
                }
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
}