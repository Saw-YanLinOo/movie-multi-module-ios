import Foundation

struct MovieAPIService: Sendable {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchPopularMovies() async throws -> MovieListResponse {
        try await fetch(endpoint: APIConstants.Endpoint.popularMovies)
    }

    func fetchNowPlayingMovies() async throws -> MovieListResponse {
        try await fetch(endpoint: APIConstants.Endpoint.nowPlayingMovies)
    }

    func fetchMovieCredits(movieId: Int) async throws -> CreditsResponse {
        try await fetch(endpoint: APIConstants.Endpoint.movieCredits(id: movieId))
    }

    private func fetch<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(APIConstants.baseURL)\(endpoint)?api_key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
