import Foundation

struct MockMovie: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let rating: Double
    let year: String
    let genres: [String]
    let posterURL: String
    let cast: [String]
}

extension MockMovie {
    static let featured = MockMovie(
        id: 1,
        title: "Fantastic Beasts and Where to Find Them",
        overview: "The adventures of writer Newt Scamander in New York's secret community of witches and wizards seventy years before Harry Potter reads his book in school.",
        rating: 7.5,
        year: "2016",
        genres: ["Adventure", "Family", "Fantasy"],
        posterURL: "https://film-grab.com/wp-content/uploads/2024/06/Introduction-17-768x432.jpg",
        cast: ["Eddie Redmayne", "Katherine Waterston", "Dan Fogler", "Alison Sudol"]
    )

    static let all: [MockMovie] = [
        MockMovie(id: 2, title: "The Wolverine", overview: "Wolverine faces his ultimate nemesis and on a deeply personal mission in Japan.", rating: 6.7, year: "2013", genres: ["Action", "Adventure"], posterURL: "https://s.movieinsider.com/images/p/150/981897_m1778810472.jpg", cast: ["Hugh Jackman", "Tao Okamoto"]),
        MockMovie(id: 3, title: "Interstellar", overview: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.", rating: 8.6, year: "2014", genres: ["Sci-Fi", "Drama"], posterURL: "https://s.movieinsider.com/images/p/150/980062_m1778248992.jpg", cast: ["Matthew McConaughey", "Anne Hathaway"]),
        MockMovie(id: 4, title: "Dune", overview: "A noble family becomes embroiled in a war for control over the galaxy's most valuable asset.", rating: 8.0, year: "2021", genres: ["Sci-Fi", "Adventure"], posterURL: "https://cdn.moviestillsdb.com/storage/posters/06/12042730_150.jpg", cast: ["Timothée Chalamet", "Zendaya"]),
        MockMovie(id: 5, title: "Oppenheimer", overview: "The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.", rating: 8.9, year: "2023", genres: ["Drama", "History"], posterURL: "https://film-grab.com/wp-content/uploads/2024/06/Introduction-17-768x432.jpg", cast: ["Cillian Murphy", "Emily Blunt"]),
        MockMovie(id: 6, title: "Inception", overview: "A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea.", rating: 8.8, year: "2010", genres: ["Sci-Fi", "Thriller"], posterURL: "https://s.movieinsider.com/images/p/150/981897_m1778810472.jpg", cast: ["Leonardo DiCaprio", "Joseph Gordon-Levitt"]),
    ]
}
