import Swinject

final class AppContainer {
    static let shared = AppContainer()

    private let container = Container()
    private let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                DataAssembly(),
                ViewModelAssembly(),
            ],
            container: container
        )
    }

    func makeMovieViewModel() -> MovieViewModel {
        container.resolve(MovieViewModel.self)!
    }
}
