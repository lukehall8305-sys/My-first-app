import SwiftUI

struct StatsView: View {
    @State private var stats: StatsResponse?
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                if let stats {
                    Text("\(stats.totalBottles)")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.green)
                    Text("Bottles Recycled").font(.title2)
                    Text("Pickups Completed: \(stats.pickupsCompleted)").font(.headline)
                } else if isLoading {
                    ProgressView()
                } else {
                    Text("No data available")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Your Impact")
            .task { await load() }
        }
    }

    private func load() async {
        isLoading = true
        defer { isLoading = false }
        do { stats = try await APIService.shared.fetchStats() } catch { /* handle */ }
    }
}