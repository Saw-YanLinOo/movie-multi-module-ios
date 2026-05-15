# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test

```bash
swift build
swift test
swift test --filter MovieDomainTests.<TestName>
```

## Purpose

Pure domain layer — no external dependencies, no networking, no SwiftUI. This package defines the contract between the data and presentation layers.

## Contents

- **`Movie`** — core domain model (`Identifiable`, `Sendable`, `Hashable`). All other layers use this type; no layer should expose DTOs beyond `MovieData`.
- **`MovieRepositoryProtocol`** — the dependency inversion boundary. `MovieData` implements it; the app and `FetchMoviesUseCase` depend on it.
- **`FetchMoviesUseCase`** — the single entry point for all movie data access. Wraps the repository and exposes `fetchPopular()`, `fetchNowPlaying()`, `fetchCredits(movieId:)`.

## Rules

- No imports other than `Foundation` (or none at all).
- All public types must conform to `Sendable` — this package targets Swift 6.
- `MovieRepositoryProtocol` must also conform to `Sendable`.
- Adding a new data operation means: add method to `MovieRepositoryProtocol` → add wrapper in `FetchMoviesUseCase` → implement in `MovieRepositoryImpl` (MovieData package).
