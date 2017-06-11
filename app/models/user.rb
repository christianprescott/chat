class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :participations
  has_many :conversations, through: :participations
end
