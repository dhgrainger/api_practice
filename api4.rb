require 'json'
require 'pry'
require 'net/http'
# more practive using the yummly api

puts "Enter an ingedient or ingrdients that you like"
params = gets.chomp

if params.include? ' '
  params = params.split(' ').join('+')
end

  search = 'http://api.yummly.com/v1/api/recipes?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238&q=' + params + '&requirePictures=true'
  resp = Net::HTTP.get_response(URI.parse(search))
  data = resp.body
  recipes = JSON.parse(data)

# not iterating through all of the recipes now because i am going to query each recipe id for more info
#and I dont want to burn through all of my api calls

  puts recipes["matches"][0]["recipeName"]
  puts recipes["matches"][0]["ingredients"].each {|ingredient| puts ingredient }
  puts recipes["matches"][0]["id"]
  recipeId = recipes["matches"][0]["id"]

  # Lemongrass-Pork-Satays-533001
  # http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY
  source = 'http://api.yummly.com/v1/api/recipe/' + recipeId + '?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238'
  resp = Net::HTTP.get_response(URI.parse(search))
  data = resp.body
  attributes = JSON.parse(data)

  binding.pry
  # recipes["matches"].each do |recipe|
  #   puts recipe["recipeName"]
  #   recipe["ingredients"].each {|ingredient| puts ingredient }
  #   puts recipe["id"]
  # end
