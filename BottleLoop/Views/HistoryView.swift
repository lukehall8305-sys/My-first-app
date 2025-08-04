import SwiftUI

struct HistoryView: View {
    @State private var pickups: [Pickup] = []
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            List(pickups) { p in
                VStack(alignment: .leading) {
                    Text(p.scheduledDate, style: .date).font(.headline)
                    Text("Status: \(p.status.rawValue.capitalized)").font(.subheadline)
                }
            }
            .overlay { if isLoading { ProgressView() } }
            .navigationTitle("History")
            .task { await load() }
        }
    }

    private func load() async {
        isLoading = true
        defer { isLoading = false }
        do { pickups = try await APIService.shared.fetchPickups() } catch { /* handle */ }
    }
}