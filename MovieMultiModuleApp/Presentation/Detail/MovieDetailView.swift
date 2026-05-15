import SwiftUI

struct MovieDetailView: View {
    let movie: MockMovie
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Poster
                GeometryReader { geo in
                    AsyncImage(url: URL(string: movie.posterURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure, .empty:
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .overlay(
                                    Image(systemName: "film")
                                        .font(.system(size: 50))
                                        .foregroundStyle(.secondary)
                                )
                        @unknown default:
                            Rectangle().fill(Color(.systemGray5))
                        }
                    }
                    .frame(width: geo.size.width, height: 320)
                    .clipped()
                }
                .frame(height: 320)

                // Title + Rating row
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(movie.year)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                        Text(movie.title)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.primary)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 14))
                        Text(String(format: "%.1f", movie.rating))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(.systemBackground))
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 12)

                VStack(alignment: .leading, spacing: 20) {

                    // Genres
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(movie.genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.yellow)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .background(Color.yellow.opacity(0.12))
                                    .overlay(
                                        Capsule().stroke(Color.yellow.opacity(0.4), lineWidth: 1)
                                    )
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    // Watch Now button
                    Button {
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "play.fill")
                            Text("Watch Now")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal, 16)

                    // Overview
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                        Text(movie.overview)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 16)

                    // Cast
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Cast")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 16)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(movie.cast.enumerated()), id: \.offset) { index, name in
                                    CastCard(name: name, index: index)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }

                    // More Like This
                    VStack(alignment: .leading, spacing: 12) {
                        Text("More Like This")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 16)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(MockMovie.all) { m in
                                    if m.id != movie.id {
                                        MovieCard(movie: m)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MockMovie.featured)
    }
}
