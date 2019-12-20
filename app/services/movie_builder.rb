class MovieBuilder
    def initialize(tmdb_id:)
        @tmdb_id = tmdb_id
        @movie = Movie.find_or_initialize_by(tmdb_id: tmdb_id)
    end

    def build!
        return @movie unless @movie.new_record?
        # fetch movie data from API using params[:tmdb_id] and create a new Movie based on the response data
        Tmdb::Api.key("12ce4e2bef2c5b2385bff21967591bd8")

        @fetched_movie = Tmdb::Movie.detail(params[:tmdb_id])

        # create a new Movie based on the response data
        @movie.title = @fetched_movie.title
        @movie.plot = @fetched_movie.overview
        @movie.release_date = @fetched_movie.release_date
        @movie.released = true if (@fetched_movie.release_date[0...4].to_i <= Time.now.year)
        @movie.runtime = @fetched_movie.runtime
        @movie.popularity = @fetched_movie.popularity
        # @movie.genre = @fetched_movie.genres.collect { |x| x[:name] }
        if @movie.genre == nil
        @movie.genre = ""
        end
        @fetched_movie.genres.each { |x| @movie.genre += "#{x.name} "}
        @movie.language = @fetched_movie.original_language
        @movie.budget = @fetched_movie.budget
        @movie.average_vote = @fetched_movie.vote_average
        @movie.vote_count = @fetched_movie.vote_count
        @movie.poster = @fetched_movie.poster_path
        @movie.homepage = @fetched_movie.homepage
        @movie.tmdb_id = @fetched_movie.id
        @movie.imdb_id = @fetched_movie.imdb_id
        @movie.save!

        return @movie
    end
end