import Swinject
import MovieDomain
import MovieData

final class AppContainer {
    static let shared = AppContainer()

    private let container = Container()

    private init() {
        registerAll()
    }

    private func registerAll() {

        // MARK: - Data Layer
        container.register(MovieRepositoryProtocol.self) { _ in
            MovieRepositoryImpl(apiKey: "487035a582a1e82376b42010973387a6")
        }
        .inObjectScope(.container)

        // MARK: - Domain Layer
        container.register(FetchMoviesUseCase.self) { r in
            FetchMoviesUseCase(
                repository: r.resolve(MovieRepositoryProtocol.self)!
            )
        }

        // MARK: - ViewModel
        container.register(MovieViewModel.self) { r in
            MovieViewModel(
                useCase: r.resolve(FetchMoviesUseCase.self)!
            )
        }
        .inObjectScope(.container)
    }

    func makeMovieViewModel() -> MovieViewModel {
        container.resolve(MovieViewModel.self)!
    }

    static func makePreview() -> MovieViewModel {
        MovieViewModel(useCase: FetchMoviesUseCase(repository: PreviewMovieRepository()))
    }
}
