require 'json'
require 'pry'
require 'net/http'
#This file lets you enter a search parameter such as beef or onion soup get a recipe and receive back 10 recipes from the recipe puppy api
#For each recipe each ingredient queries the nutritionix api to get nutrionial info
def nutrition(ingredient)
  source = 'https://api.nutritionix.com/v1_1/search/' + ingredient + '?fields=item_name%2Cnf_calories%2Cnf_total_fat%2Cnf_protein%2Cnf_total_carbohydrate&appId=43789ff5&appKey=84ab1be2928c84bd4126e84663c54998'
  resp = Net::HTTP.get_response(URI.parse(source))
  data = resp.body
  values = JSON.parse(data)

  # puts "Name: #{values["hits"][0]["fields"]["item_name"]}"
  # puts "Total Calories: #{values["hits"][0]["fields"]["nf_calories"]}"
  # puts "Fat: #{((values["hits"][0]["fields"]["nf_total_fat"].to_f)*9)} "
  # puts "Carbs: #{((values["hits"][0]["fields"]["nf_total_carbohydrates"].to_f)*4)} "
  # puts "Protein: #{((values["hits"][0]["fields"]["nf_protein"].to_f)*4)} "

# Here I find the
  name = values["hits"][0]["fields"]["item_name"]
  calories = values["hits"][0]["fields"]["nf_calories"].to_f
  fat = ((values["hits"][0]["fields"]["nf_total_fat"].to_f)*9)
  carbs = ((values["hits"][0]["fields"]["nf_total_carbohydrates"].to_f)*4)
  protein = ((values["hits"][0]["fields"]["nf_protein"].to_f)*4)

  ingredient = {name: name, calories: calories, fat: fat, carbs: carbs, protein: protein}
end


  params = gets.chomp

  search = 'http://www.recipepuppy.com/api/?q=' + params

  # source = 'http://www.recipepuppy.com/api/?q=chicken'
  # source = 'https://api.nutritionix.com/v1_1/item?upc=49000036756&appId=43789ff5&appKey=84ab1be2928c84bd4126e84663c54998'
  resp = Net::HTTP.get_response(URI.parse(search))
  data = resp.body
  recipes = JSON.parse(data)


  # iterating through ten recipes really burns through my 500 nutritionix api calls per day
  # recipe = recipes["results"].each do |recipe|
    recipe = recipes["results"][0]
    ingredients = recipe["ingredients"].split(", ")
    puts recipe["title"]
    values = []
    ingredients.each do |ingredient|
      if ingredient.include? ' '
        replace = ingredient.split(' ').join('%20')
        values << {name: ingredient, values: nutrition(replace)}
      else
        values << {name: ingredient, values: nutrition(ingredient)}
      end
    end
    binding.pry
    # puts "#{values[:calories].inject(:+)} calories"
    # print "\n\n\n"
    x= 0
    y = 0
    z = 0
    w = 0
    values.each do |value|
      x += value[:values][:calories]
      y += value[:values][:fat]
      z += value[:values][:protein]
      w += value[:values][:carbs]
    end
    puts "#{x} total calories"
    puts "#{y} calories from fats"
    puts "#{z} calories from protein"
    puts "#{w} calories from carbs"
  # end







