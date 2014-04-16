require 'json'
require 'pry'
require 'net/http'

# praciticing using the yummly api

  source = 'http://api.yummly.com/v1/api/recipe/Lemongrass-Pork-Satays-533001?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238&'
  resp = Net::HTTP.get_response(URI.parse(source))
  data = resp.body
  recipes = JSON.parse(data)


  puts recipes["attribution"]["text"]

  recipes["ingredientLines"].each {|ingredient| puts ingredient}
  recipes["nutritionEstimates"].each do |attribute|
    puts "#{attribute["attribute"]} #{attribute["value"]} #{attribute["unit"]["name"]}"
  end
