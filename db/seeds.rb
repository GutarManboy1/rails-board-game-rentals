require 'open-uri'
require "nokogiri"
require "csv"
require "faker"

filepath = "db/utf8.csv"
comments = [
  "Mint condition game, never opened",
  "Great condition, only played once.",
  "Good condition, but one piece missing.",
  "Old, but everything's there.",
  "You gotta try this game! You'll love it!",
  "Game has some wear and tear, but all pieces are there.",
  "Hit me up for further recommendations if you like this.",
  "Corner of the board is a bit chewed up (my dog)",
  "Game is all there, but smells slightly of cigarettes.",
  "Contact me directly if you wanna just buy the game from me.",
  "A great game for parties, highly recommend it.",
  "Will not deliver-- pickup only.",
  "Everything's there.  I take cash or PayPay.",
  "Find a cheaper offer? Text me and I'll beat it.",
  "One of my all time favorites!  A must-play for any table-topper.",
  "Someone spilled coffee on the board so it's warped and stained.",
  "All pieces included.",
  "Game pieces are all there, but instructions are missing.",
  "I deliver!!!",
  "I'm on a bike, so I only deliver within 3 miles...sorry.",
  "Little known game, but well worth a try.",
  "Old game, but pieces have been re-painted.",
  "This version is a spin on the old classic!",
  "All your base are belong to us.",
  "The dog chewed up the box, but the pieces are all there.",
  "Great condition, lots of fun!",
  "Used, but otherwise good condition.",
  "Plz help me pay my rent....",
  "Two cards have been replaced with paper slips.",
  "Who lives in a pineapple under the sea?"
]

statuses = ["Approved", "Approved", "Approved", "Denied", "Pending", "Pending"]

CSV.foreach(filepath, headers: :first_row) do |row|
game = Game.find_by(name: row['names'])
game_id = row['game_id']
num_players = row['min_players'] == row['max_players'] ? row['max_players'] : "#{row['min_players']} - #{row['max_players']}"
  unless game
    game = Game.create!(
      name: row['names'],
      players: num_players,
      copies: 0,
      play_time: "#{row['avg_time']}",
      genre: "#{row['category']}"
    )
    file = URI.open("https://api.geekdo.com/xmlapi/boardgame/#{game_id}?")
    document = Nokogiri::XML(file)
    p image_url = document.root.xpath("boardgame").xpath("image").text
    description = document.root.xpath("boardgame").xpath("description").text
    cleaned_description = description.gsub(/<br\s*\/?>/, "\n")
    cleaned_description = cleaned_description.gsub(/&quot;/, '"')
    cleaned_description = cleaned_description.gsub(/&amp;/, '&')
    cleaned_description = cleaned_description.gsub(/&ndash;/, '–')
    cleaned_description = cleaned_description.gsub(/&auml;/, 'ä')
    cleaned_description = cleaned_description.gsub(/&uuml;/, 'ü')
    cleaned_description = cleaned_description.gsub(/&nbsp;/, ' ')
    game.string_url = image_url
    game.description = cleaned_description
    game.save!
  end
end

30.times do
  user = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456")
  user.save!
end

200.times do
  com = comments[rand(30)]
  game_num = rand(1..100)
  dollars = rand(6)
  cents = rand(100)
  cost = "#{dollars}.#{cents}".to_f
  offer = Offer.new(
    pending_request: false,
    comment: com,
    price: cost,
    game_id: game_num,
    user_id: rand(1..30)
  )
  game = Game.find(game_num)
  game.copies += 1
  game.save!
  offer.save!
end

200.times do
  status = statuses[rand(6)]
  today = Date.today
  start = today + rand(100)
  finish = start + rand(14)
  offer = rand(1..200)
  booking = Booking.new(
    status: status,
    start_date: start,
    end_date: finish,
    user_id: rand(1..30),
    offer_id: offer
  )
  current_offer = Offer.find(offer)
  current_offer.update!(pending_request: status == 'Pending')
  booking.save!
end

bookings = Booking.all
bookings.each do |booking|
  if booking.status == "Approved"
    offer = Offer.find(booking.offer_id)
    offer.update!(rented: true)
    offer.save!
  end
end
