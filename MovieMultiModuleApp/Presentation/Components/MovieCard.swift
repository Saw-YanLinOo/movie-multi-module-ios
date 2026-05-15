import SwiftUI
import MovieDomain

struct MovieCard: View {
    let movie: Movie
    var width: CGFloat = 130
    var height: CGFloat = 190

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
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
                                    .foregroundStyle(.secondary)
                            )
                    @unknown default:
                        Rectangle().fill(Color(.systemGray5))
                    }
                }
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", movie.rating))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.black.opacity(0.55))
                .clipShape(Capsule())
                .padding(8)
            }

            Text(movie.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .frame(width: width, alignment: .leading)

            Text(movie.year)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
        }
    }
}
