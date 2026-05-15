# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test

```bash
swift build
swift test
swift test --filter MovieDataTests.<TestName>
```

## Purpose

Data layer — owns all TMDB networking. Implements `MovieRepositoryProtocol` from `MovieDomain` and exposes nothing beyond that contract to the app.

## Contents

- **`MovieAPIService`** — `Sendable` struct wrapping `URLSession`. All requests go through the generic `fetch<T>(endpoint:)` method which appends the API key and decodes the response.
- **`DTOs`** — `MovieListResponse`, `MovieDTO`, `CreditsResponse`, `CastDTO`. Codable. Never leave this package — `MovieRepositoryImpl` maps them to `Movie` domain models before returning.
- **`MovieRepositoryImpl`** — `public final class` conforming to `MovieRepositoryProtocol`. Holds a `MovieAPIService` and a static `genreMap` (`[Int: String]`) for mapping TMDB genre IDs to names.

## Key Details

- **Image URLs** — construct as `MovieAPIService.imageBaseURL + posterPath` (`https://image.tmdb.org/t/p/w500`).
- **Genre mapping** — TMDB returns genre IDs in movie list responses; full genre names are resolved locally via `genreMap`. Credits endpoints return names directly.
- **DTO → Domain mapping** — happens inside `mapToMovie(_:)` in `MovieRepositoryImpl`. Rating is rounded to 1 decimal. Year is the first 4 characters of `release_date`.
- Adding a new endpoint: add a method to `MovieAPIService` → add a DTO if needed → implement the new `MovieRepositoryProtocol` method in `MovieRepositoryImpl`.
