class ReviewsController < ApplicationController
  before_action :authenticate_user!

  # def initialize(attribute)
  #   @attribute = attribute
  # end

  def create
    @movie = MovieBuilder.new(tmdb_id: params[:tmdb_id]).build!

    # create a new reviews and connect it to the current_user and the movie
    @review = current_user.reviews.new(review_params.merge(movie_id: @movie.id))
    if @review.save
      flash[:success] = "Review saved!"
      redirect_to root_path
    else
      flash[:alert] = "Woops! It seems there was ab error."
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

end
