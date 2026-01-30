puts "🌱 Seeding production (safe mode)..."

# ---- Genres (minimum 2 required) ----
genres = [
  { genre_id: 4, name: "Fighting", search_name: "fighting" },
  { genre_id: 5, name: "Shooter", search_name: "shooter" },
  { genre_id: 10, name: "Racing", search_name: "racing" }
]

genres.each do |g|
  Genre.find_or_create_by!(genre_id: g[:genre_id]) do |genre|
    genre.name = g[:name]
    genre.search_name = g[:search_name]
  end
end

puts "✅ Genres ready: #{Genre.count}"

# ---- Ensure at least 1 game ----
game = Game.first || Game.create!(
  igdb_id: 999999,
  name: "Demo Game",
  search_name: "demogame",
  genres: "[4,5]",
  platforms: "[167]",
  summary: "Production seed game",
  url: "https://example.com",
  total_rating: 80,
  total_rating_count: 100
)

puts "✅ Game ready"

# ---- Ensure user ----
user = User.first || User.create!(
  first_name: "Demo",
  last_name: "User",
  email: "demo@demo.com",
  username: "demo_user",
  password: "123456",
  password_confirmation: "123456",
  location_id: Location.first&.id
)

puts "✅ User ready"

# ---- Ensure listing ----
Listing.find_or_create_by!(game: game, user: user) do |listing|
  listing.price = 1000
  listing.description = "Production seed listing"
  listing.max = 7
  listing.platform = Platform.first
end

puts "🎉 Production seed complete"
