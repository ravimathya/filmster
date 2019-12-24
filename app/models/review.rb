class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  delegate :username, to: :user

  validates :user, :movie, presence: true

  def reviewed?(movie)
    current_user.reviewed?(@movie)
  end
  
end
