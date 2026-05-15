import MovieDomain

// Mock data used only for SwiftUI Previews
extension Movie {
    static let preview = Movie(
        id: 1,
        title: "Fantastic Beasts and Where to Find Them",
        overview: "The adventures of writer Newt Scamander in New York's secret community of witches and wizards seventy years before Harry Potter reads his book in school.",
        rating: 7.5,
        year: "2016",
        genres: ["Adventure", "Family", "Fantasy"],
        posterURL: "https://image.tmdb.org/t/p/w500/rwoCNEjJkgJMEJGMXmTVEMPfqgM.jpg"
    )

    static let previews: [Movie] = [
        Movie(id: 2, title: "The Wolverine", overview: "Wolverine faces his ultimate nemesis.", rating: 6.7, year: "2013", genres: ["Action", "Adventure"], posterURL: "https://image.tmdb.org/t/p/w500/LuN3o9bxJP5HBIno4TIQQ8BH33.jpg"),
        Movie(id: 3, title: "Interstellar", overview: "A team of explorers travel through a wormhole.", rating: 8.6, year: "2014", genres: ["Sci-Fi", "Drama"], posterURL: "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIE.jpg"),
        Movie(id: 4, title: "Dune", overview: "A noble family becomes embroiled in a war.", rating: 8.0, year: "2021", genres: ["Sci-Fi", "Adventure"], posterURL: "https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg"),
        Movie(id: 5, title: "Oppenheimer", overview: "The story of J. Robert Oppenheimer.", rating: 8.9, year: "2023", genres: ["Drama", "History"], posterURL: "https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"),
    ]
}
