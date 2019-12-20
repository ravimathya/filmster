class Movie < ApplicationRecord
    validates :title, :plot, :release_date, :released, :runtime, :popularity, :language, :budget, :average_vote, :vote_count, :poster, :homepage, :tmdb_id, :imdb_id, presence: true  
    
    has_many :reviews, dependent: :destroy
end
  