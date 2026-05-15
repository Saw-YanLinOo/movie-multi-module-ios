import Swinject
import MovieDomain

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieViewModel.self) { r in
            MovieViewModel(
                repository: r.resolve(MovieRepositoryProtocol.self)!
            )
        }
        .inObjectScope(.container)
    }
}
