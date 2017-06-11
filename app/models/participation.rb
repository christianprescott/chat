class Participation < ApplicationRecord
  validates :user, presence: true
  validates :conversation, presence: true, uniqueness: { scope: :user }

  belongs_to :user
  belongs_to :conversation
end
