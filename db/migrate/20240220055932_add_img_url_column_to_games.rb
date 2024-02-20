class AddImgUrlColumnToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :string_url, :string
  end
end
