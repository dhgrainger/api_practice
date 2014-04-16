require 'json'
require 'pry'
require 'net/http'
# more practive using the yummly api

puts "Enter an ingedient you like"
params = gets.chomp

if params.include? ' '
  params = params.split(' ').join('+')
end

  search = 'http://api.yummly.com/v1/api/recipes?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238&q=' + params + '&requirePictures=true'

  # source = 'http://www.recipepuppy.com/api/?q=chicken'
  # source = 'https://api.nutritionix.com/v1_1/item?upc=49000036756&appId=43789ff5&appKey=84ab1be2928c84bd4126e84663c54998'
  resp = Net::HTTP.get_response(URI.parse(search))
  data = resp.body
  recipes = JSON.parse(data)

  recipes["matches"].each do |recipe|
    puts recipe["recipeName"]
    recipe["ingredients"].each {|ingredient| puts ingredient }
    puts recipe["id"]
  end
