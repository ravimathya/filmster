class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, :movie, presence: true

  def reviewed?(movie)
    current_user.reviewed?(@movie)
  end
  
end
