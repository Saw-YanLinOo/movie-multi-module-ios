import MovieDomain

struct PreviewMovieRepository: MovieRepositoryProtocol {
    func fetchPopularMovies() async throws -> [Movie] { Movie.previews }
    func fetchNowPlayingMovies() async throws -> [Movie] { Movie.previews }
    func fetchMovieCredits(movieId: Int) async throws -> [String] {
        ["Eddie Redmayne", "Katherine Waterston", "Dan Fogler", "Alison Sudol"]
    }
}
