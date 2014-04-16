require 'json'
require 'pry'

require 'net/http'



  source = 'http://api.yummly.com/v1/api/recipes?_app_id=76673592&_app_key=17ee3cd3288f06af85bc442278910238&'
  resp = Net::HTTP.get_response(URI.parse(source))
  data = resp.body
  recipes = JSON.parse(data)
  binding.pry


