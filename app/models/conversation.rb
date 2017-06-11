class Conversation < ApplicationRecord
  has_many :participations
  has_many :users, through: :participations
  has_many :messages

  scope :include_unread, -> { select(<<-SQL)
      #{quoted_table_name}.*, (
        #{Participation.quoted_table_name}.read_at IS NULL OR
        #{Participation.quoted_table_name}.read_at < #{quoted_table_name}.updated_at
      ) as unread
    SQL
  }
end
