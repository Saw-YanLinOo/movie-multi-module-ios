public struct FetchMoviesUseCase: Sendable {
    private let repository: any MovieRepositoryProtocol

    public init(repository: any MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchPopular() async throws -> [Movie] {
        try await repository.fetchPopularMovies()
    }

    public func fetchNowPlaying() async throws -> [Movie] {
        try await repository.fetchNowPlayingMovies()
    }

    public func fetchCredits(movieId: Int) async throws -> [String] {
        try await repository.fetchMovieCredits(movieId: movieId)
    }
}
