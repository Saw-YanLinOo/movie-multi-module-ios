enum APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    enum Endpoint {
        static let popularMovies = "/movie/popular"
        static let nowPlayingMovies = "/movie/now_playing"

        static func movieCredits(id: Int) -> String {
            "/movie/\(id)/credits"
        }
    }
}
