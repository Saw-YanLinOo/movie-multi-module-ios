import SwiftUI

@main
struct MovieMultiModuleAppApp: App {
    @StateObject private var viewModel = AppContainer.shared.makeMovieViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
