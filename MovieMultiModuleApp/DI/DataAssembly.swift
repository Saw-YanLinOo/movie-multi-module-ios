import Swinject
import MovieDomain
import MovieData

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieRepositoryProtocol.self) { _ in
            MovieRepositoryImpl(apiKey: "487035a582a1e82376b42010973387a6")
        }
        .inObjectScope(.container)
    }
}
