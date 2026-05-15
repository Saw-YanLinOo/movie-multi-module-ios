# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test

```bash
swift build
swift test
swift test --filter MovieDomainTests.<TestName>
```

## Purpose

Pure domain layer — no external dependencies, no networking, no SwiftUI. Defines the contract between the data and presentation layers.

## Contents

- **`Movie`** — core domain model (`Identifiable`, `Sendable`, `Hashable`). All layers use this type; DTOs never leave `MovieData`.
- **`MovieRepositoryProtocol`** — the dependency inversion boundary. `MovieData` implements it; `MovieViewModel` depends on it directly.

## Rules

- No imports other than `Foundation` (or none at all).
- All public types must conform to `Sendable` — this package targets Swift 6.
- Adding a new data operation: add method to `MovieRepositoryProtocol` → implement in `MovieRepositoryImpl` (MovieData) → call from `MovieViewModel`.
