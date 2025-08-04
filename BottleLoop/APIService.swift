import Foundation

enum APIError: Error {
    case invalidURL
    case network(Error)
    case decoding(Error)
    case server(status: Int)
}

class APIService {
    static let shared = APIService()
    private init() {}

    private let baseURL = URL(string: "https://api.bottleloop.com")!

    private func request<T: Decodable>(_ path: String, method: String = "GET", body: Data? = nil) async throws -> T {
        guard let url = URL(string: path, relativeTo: baseURL) else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                throw APIError.server(status: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as APIError {
            throw error
        } catch {
            if (error as? DecodingError) != nil { throw APIError.decoding(error) }
            throw APIError.network(error)
        }
    }

    // MARK: - Auth
    func login(email: String, password: String) async throws -> User {
        struct Payload: Codable { let email: String; let password: String }
        let body = try JSONEncoder().encode(Payload(email: email, password: password))
        return try await request("/auth/login", method: "POST", body: body)
    }

    func register(email: String, password: String) async throws -> User {
        struct Payload: Codable { let email: String; let password: String }
        let body = try JSONEncoder().encode(Payload(email: email, password: password))
        return try await request("/auth/register", method: "POST", body: body)
    }

    func logout() async { /* token revocation etc. */ }

    // MARK: - Pickups
    func schedulePickup(date: Date) async throws -> Pickup {
        struct Payload: Codable { let date: Date }
        let body = try JSONEncoder().encode(Payload(date: date))
        return try await request("/pickups", method: "POST", body: body)
    }

    func fetchPickups() async throws -> [Pickup] {
        return try await request("/pickups")
    }

    // MARK: - Stats
    func fetchStats() async throws -> StatsResponse {
        return try await request("/stats")
    }
}

struct StatsResponse: Codable {
    let totalBottles: Int
    let pickupsCompleted: Int
}