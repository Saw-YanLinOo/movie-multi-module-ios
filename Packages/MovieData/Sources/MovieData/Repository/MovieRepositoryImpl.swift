import MovieDomain

public final class MovieRepositoryImpl: MovieRepositoryProtocol {
    private let apiService: MovieAPIService

    private static let genreMap: [Int: String] = [
        28: "Action",    12: "Adventure", 16: "Animation", 35: "Comedy",
        80: "Crime",     99: "Documentary", 18: "Drama",   10751: "Family",
        14: "Fantasy",   36: "History",   27: "Horror",   10402: "Music",
        9648: "Mystery", 10749: "Romance", 878: "Sci-Fi",  53: "Thriller",
        10752: "War",    37: "Western"
    ]

    public init(apiKey: String) {
        self.apiService = MovieAPIService(apiKey: apiKey)
    }

    public func fetchPopularMovies() async throws -> [Movie] {
        let response = try await apiService.fetchPopularMovies()
        return response.results.map(mapToMovie)
    }

    public func fetchNowPlayingMovies() async throws -> [Movie] {
        let response = try await apiService.fetchNowPlayingMovies()
        return response.results.map(mapToMovie)
    }

    public func fetchMovieCredits(movieId: Int) async throws -> [String] {
        let response = try await apiService.fetchMovieCredits(movieId: movieId)
        return response.cast.prefix(8).map(\.name)
    }

    private func mapToMovie(_ dto: MovieDTO) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview,
            rating: (dto.voteAverage * 10).rounded() / 10.0,
            year: String(dto.releaseDate.prefix(4)),
            genres: dto.genreIds.compactMap { Self.genreMap[$0] },
            posterURL: dto.posterPath.map { MovieAPIService.imageBaseURL + $0 } ?? ""
        )
    }
}
