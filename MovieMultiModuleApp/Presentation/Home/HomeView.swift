import SwiftUI

struct HomeView: View {
    let movies = MockMovie.all
    let featuredMovies = [MockMovie.featured] + Array(MockMovie.all.prefix(3))
    @State private var featuredIndex: Int? = 0
    @State private var cardWidth: CGFloat = 300

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

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
                        HStack {
                            Text("Now Showing")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.primary)
                            Spacer()
                            Button("See All") {}
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.yellow)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(movies) { movie in
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
                        HStack {
                            Text("Popular")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.primary)
                            Spacer()
                            Button("See All") {}
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.yellow)
                        }

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(movies.reversed()) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCard(movie: movie, width: 160, height: 160)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
