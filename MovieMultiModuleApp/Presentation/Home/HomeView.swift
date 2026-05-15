import SwiftUI
import MovieDomain

struct HomeView: View {
    @StateObject private var viewModel = AppContainer.shared.makeMovieViewModel()
    @State private var featuredIndex: Int? = 0

    private var featuredMovies: [Movie] { Array(viewModel.nowPlayingMovies.prefix(4)) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 300)
                    } else if let error = viewModel.errorMessage {
                        ContentUnavailableView(error, systemImage: "exclamationmark.triangle")
                            .frame(maxWidth: .infinity, minHeight: 300)
                    } else {

                        // Featured
                        GeometryReader { geo in
                            VStack(alignment: .leading, spacing: 12) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(Array(featuredMovies.enumerated()), id: \.offset) { index, movie in
                                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                FeaturedMovieCard(movie: movie)
                                                    .frame(width: geo.size.width)
                                            }
                                            .buttonStyle(.plain)
                                            .id(index)
                                        }
                                    }
                                    .scrollTargetLayout()
                                }
                                .scrollTargetBehavior(.viewAligned)
                                .scrollPosition(id: $featuredIndex)
                                .contentMargins(.horizontal, 16, for: .scrollContent)
                                .frame(height: 280)

                                HStack(spacing: 6) {
                                    ForEach(0..<featuredMovies.count, id: \.self) { i in
                                        Capsule()
                                            .fill(i == (featuredIndex ?? 0) ? Color.yellow : Color.gray.opacity(0.3))
                                            .frame(width: i == (featuredIndex ?? 0) ? 20 : 6, height: 6)
                                            .animation(.easeInOut, value: featuredIndex)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .frame(height: 360)

                        // Now Showing
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeader(title: "Now Showing")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 14) {
                                    ForEach(viewModel.nowPlayingMovies) { movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            MovieCard(movie: movie)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)

                        // Popular
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeader(title: "Popular")
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.popularMovies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieCard(movie: movie, width: 160, height: 160)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 12)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.primary)
                    }
                }
            }
            .task { await viewModel.loadMovies() }
        }
    }
}

private struct SectionHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.primary)
            Spacer()
            Button("See All") { }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    HomeView()
}
