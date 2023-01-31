# app/models/rating.rb

class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :score, numericality: {in: 1..10}

  def self.find_mine(movie, user)
    return Rating.exists?(movie_id: movie.id, user_id: user.id) ?
      Rating.where(movie_id: movie.id, user_id: user.id).first :
      0
  end

end
