class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true
      t.index [:user_id, :conversation_id], unique: true

      t.timestamps
    end
  end
end
