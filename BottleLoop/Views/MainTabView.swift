import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SchedulePickupView()
                .tabItem { Label("Schedule", systemImage: "calendar") }
            HistoryView()
                .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
            StatsView()
                .tabItem { Label("Stats", systemImage: "chart.bar.xaxis") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
    }
}