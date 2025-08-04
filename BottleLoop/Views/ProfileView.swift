import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if let user = session.user {
                    Text(user.email).font(.headline)
                    if let sub = user.subscription {
                        Text("Plan: \(sub.planName)")
                        if let next = sub.nextPickup {
                            Text("Next Pickup: \(next.formatted(date: .abbreviated, time: .shortened))")
                        }
                        Text(sub.active ? "Active" : "Inactive").foregroundColor(sub.active ? .green : .red)
                    }
                }
                Button("Logout") { session.logout() }
                    .buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}