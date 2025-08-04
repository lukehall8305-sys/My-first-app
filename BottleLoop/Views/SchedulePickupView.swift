import SwiftUI

struct SchedulePickupView: View {
    @State private var date = Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now
    @State private var message: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                DatePicker("Pickup Date", selection: $date, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                Button("Schedule Pickup") { Task { await submit() } }
                    .buttonStyle(.borderedProminent)
                if let message { Text(message).foregroundColor(.green) }
                Spacer()
            }
            .padding()
            .navigationTitle("Schedule Pickup")
        }
    }

    private func submit() async {
        do {
            _ = try await APIService.shared.schedulePickup(date: date)
            message = "Pickup scheduled!"
        } catch {
            message = "Failed: \(error.localizedDescription)"
        }
    }
}