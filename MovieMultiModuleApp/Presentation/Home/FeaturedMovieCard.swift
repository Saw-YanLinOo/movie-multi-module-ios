import SwiftUI
import MovieDomain

struct FeaturedMovieCard: View {
    let movie: Movie

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
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
                                    .font(.system(size: 40))
                                    .foregroundStyle(.secondary)
                            )
                    @unknown default:
                        Rectangle().fill(Color(.systemGray5))
                    }
                }
                .frame(width: geo.size.width - 24, height: geo.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.7)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            ForEach(movie.genres.prefix(2), id: \.self) { genre in
                                Text(genre)
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.9))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(.white.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }

                        Text(movie.title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                    }

                    Spacer()

                    Button { } label: {
                        Image(systemName: "play.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.yellow)
                            .clipShape(Circle())
                    }
                }
                .padding(16)
            }
            .frame(width: geo.size.width - 24)
        }
    }
}
