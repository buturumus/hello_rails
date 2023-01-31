# app/models/movie.rb

class Movie < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged 

  paginates_per 3

  belongs_to :user
  has_many :ratings
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :description, presence: true

  def self.find_mine(current_user)
    return Movie.exists?(user_id: current_user.id) ?
      Movie.where(user_id: current_user.id) :
      []
  end

  def avg_rating
    scores = 0
    for rating in self.ratings do
      scores += rating.score
    end
    if self.ratings.count != 0
      avg_rating = (scores.to_f/self.ratings.count).round(1)
      avg_rating = avg_rating.to_i if avg_rating == avg_rating.to_i
    else
      avg_rating = 0
    end
    return avg_rating
  end

  def absent_categories
    cc = []
    for c in Category.all
      cc.append c if ! self.category_ids.include? c.id
    end
    return cc
  end

end

