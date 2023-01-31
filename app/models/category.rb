class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged 

  belongs_to :user
  has_and_belongs_to_many :movies

  validates :name, presence: true

  def self.find_mine(current_user)
    return Category.exists?(user_id: current_user.id) ?
      Category.where(user_id: current_user.id) :
      []
  end
end
