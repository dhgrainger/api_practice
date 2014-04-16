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

  recipeId = recipes["matches"][0]["id"]



  source = 'http://api.yummly.com/v1/api/recipe/' + recipeId + '?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238&'
  resp = Net::HTTP.get_response(URI.parse(source))
  data = resp.body
  info = JSON.parse(data)



  puts info["attribution"]["text"]

  info["ingredientLines"].each {|ingredient| puts ingredient}
  info["nutritionEstimates"].each do |attribute|

    if attribute["description"] == 'Carbohydrate, by difference'
      puts "#{attribute["description"]} #{attribute["value"]} #{attribute["unit"]["name"]}"
    end
    if attribute["description"] == 'Protein'
      puts "#{attribute["description"]} #{attribute["value"]} #{attribute["unit"]["name"]}"
    end
    if attribute["description"] == 'Total lipid (fat)'
      puts "#{attribute["description"]} #{attribute["value"]} #{attribute["unit"]["name"]}"
    end
  end

