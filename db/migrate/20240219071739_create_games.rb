class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.integer :copies
      t.string :players
      t.string :play_time
      t.string :genre

      t.timestamps
    end
  end
end
