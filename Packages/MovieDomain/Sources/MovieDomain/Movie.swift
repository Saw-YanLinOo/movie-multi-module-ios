public struct Movie: Identifiable, Sendable, Hashable {
    public let id: Int
    public let title: String
    public let overview: String
    public let rating: Double
    public let year: String
    public let genres: [String]
    public let posterURL: String

    public init(
        id: Int,
        title: String,
        overview: String,
        rating: Double,
        year: String,
        genres: [String],
        posterURL: String
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.rating = rating
        self.year = year
        self.genres = genres
        self.posterURL = posterURL
    }
}
