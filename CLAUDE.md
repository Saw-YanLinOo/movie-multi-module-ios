# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

```bash
# Build via xcodebuild
xcodebuild -project MovieMultiModuleApp.xcodeproj \
  -scheme MovieMultiModuleApp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  build

# Run tests
xcodebuild -project MovieMultiModuleApp.xcodeproj \
  -scheme MovieMultiModuleApp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  test

# Build a single package (e.g. MovieDomain)
cd Packages/MovieDomain && swift build
cd Packages/MovieDomain && swift test
```

## Architecture

Clean architecture across three layers, split into local Swift packages:

```
AppContainer (Swinject)
    │
    ├── MovieData (Package)          ← Data layer
    │   ├── MovieAPIService          ← URLSession, TMDB REST calls
    │   ├── DTOs                     ← Codable response models
    │   └── MovieRepositoryImpl      ← Implements MovieRepositoryProtocol
    │
    ├── MovieDomain (Package)        ← Domain layer (no external deps)
    │   ├── Movie                    ← Core domain model
    │   └── MovieRepositoryProtocol  ← Dependency inversion boundary
    │
    └── App target
        ├── DI/AppContainer          ← Swinject container, single source of truth
        ├── ViewModel/MovieViewModel ← @MainActor ObservableObject, calls repo directly, injected via @EnvironmentObject
        ├── Presentation/            ← SwiftUI views and components
        └── Models/                  ← Preview helpers (Movie+Mock, PreviewMovieRepository)
```

## Key Conventions

**Dependency flow** — dependencies only point inward: `App → Domain ← Data`. `MovieData` imports `MovieDomain`; the app imports both. Views never import `MovieData` directly.

**DI** — All production dependencies are registered in `AppContainer`. Resolve with `AppContainer.shared.makeMovieViewModel()`. For SwiftUI previews use `AppContainer.makePreview()` which swaps in `PreviewMovieRepository`.

**ViewModel injection** — `MovieViewModel` is passed from `MovieMultiModuleAppApp` down the view hierarchy via `.environmentObject(viewModel)`. Views access it with `@EnvironmentObject private var viewModel: MovieViewModel`.

**API** — TMDB v3. API key lives in `AppContainer.registerAll()`. Image base URL is `MovieAPIService.imageBaseURL` (`https://image.tmdb.org/t/p/w500`). Endpoints used: `/movie/popular`, `/movie/now_playing`, `/movie/{id}/credits`.

**Concurrency** — `MovieViewModel` is `@MainActor`. Repository and service layers are `Sendable` structs using `async/await` with `URLSession`. Swift 6 strict concurrency is enabled.

**Packages** — `MovieDomain` has no external dependencies. `MovieData` depends only on `MovieDomain` (path: `../MovieDomain`). Neither package imports SwiftUI.
