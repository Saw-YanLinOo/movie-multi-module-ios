import Combine
import Foundation
import MovieDomain

@MainActor
final class MovieViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let useCase: FetchMoviesUseCase

    init(useCase: FetchMoviesUseCase) {
        self.useCase = useCase
    }

    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            async let popular = useCase.fetchPopular()
            async let nowPlaying = useCase.fetchNowPlaying()
            popularMovies = try await popular
            nowPlayingMovies = try await nowPlaying
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func fetchCredits(movieId: Int) async -> [String] {
        do {
            return try await useCase.fetchCredits(movieId: movieId)
        } catch {
            return []
        }
    }
}
