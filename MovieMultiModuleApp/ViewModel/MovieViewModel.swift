import Combine
import Foundation
import MovieDomain

@MainActor
final class MovieViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: any MovieRepositoryProtocol

    init(repository: any MovieRepositoryProtocol) {
        self.repository = repository
    }

    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            async let popular = repository.fetchPopularMovies()
            async let nowPlaying = repository.fetchNowPlayingMovies()
            popularMovies = try await popular
            nowPlayingMovies = try await nowPlaying
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func fetchCredits(movieId: Int) async -> [String] {
        do {
            return try await repository.fetchMovieCredits(movieId: movieId)
        } catch {
            return []
        }
    }
}
