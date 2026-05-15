public protocol MovieRepositoryProtocol: Sendable {
    func fetchPopularMovies() async throws -> [Movie]
    func fetchNowPlayingMovies() async throws -> [Movie]
    func fetchMovieCredits(movieId: Int) async throws -> [String]
}
