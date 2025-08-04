import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var name: String?
    var email: String
    var subscription: Subscription?
}

struct Subscription: Codable, Identifiable {
    let id: UUID
    var planName: String
    var nextPickup: Date?
    var active: Bool
}

struct Pickup: Codable, Identifiable {
    let id: UUID
    var scheduledDate: Date
    var status: PickupStatus
    var bottleCount: Int?

    enum PickupStatus: String, Codable {
        case pending, completed, missed, cancelled
    }
}