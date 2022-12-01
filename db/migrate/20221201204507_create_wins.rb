class CreateWins < ActiveRecord::Migration[6.1]
  def change
    create_table :wins do |t|
      t.integer :user_id, null: false
      t.integer :opponent_user_id, null: false
      t.integer :hands_played, null: false

      t.timestamps
    end
  end
end
