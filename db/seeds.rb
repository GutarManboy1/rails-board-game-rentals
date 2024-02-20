require 'open-uri'
require "nokogiri"
require "csv"

filepath = "db/utf8.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
game = Game.find_by(name: row['names'])
game_id = row['game_id']
  unless game
    game = Game.create!(
      name: row['names'],
      players: "#{row['min_players']}-#{row['max_players']}",
      copies: 0,
      play_time: "#{row['avg_time']}",
      genre: "#{row['category']}"
    )
    file = URI.open("https://api.geekdo.com/xmlapi/boardgame/#{game_id}?")
    document = Nokogiri::XML(file)
    p image_url = document.root.xpath("boardgame").xpath("image").text
    description = document.root.xpath("boardgame").xpath("description").text
    game.string_url = image_url
    game.description = description
    game.save!
  end
end
