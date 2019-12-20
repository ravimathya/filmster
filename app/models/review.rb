class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, :movie, presence: true
end
