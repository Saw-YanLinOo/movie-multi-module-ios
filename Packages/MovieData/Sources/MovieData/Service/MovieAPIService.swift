import Foundation

struct MovieAPIService: Sendable {
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchPopularMovies() async throws -> MovieListResponse {
        try await fetch(endpoint: "/movie/popular")
    }

    func fetchNowPlayingMovies() async throws -> MovieListResponse {
        try await fetch(endpoint: "/movie/now_playing")
    }

    func fetchMovieCredits(movieId: Int) async throws -> CreditsResponse {
        try await fetch(endpoint: "/movie/\(movieId)/credits")
    }

    private func fetch<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
