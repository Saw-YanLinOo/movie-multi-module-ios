import Foundation

struct MovieListResponse: Codable, Sendable {
    let results: [MovieDTO]
}

struct MovieDTO: Codable, Sendable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let genreIds: [Int]
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
    }
}

struct CreditsResponse: Codable, Sendable {
    let cast: [CastDTO]
}

struct CastDTO: Codable, Sendable {
    let name: String
}
