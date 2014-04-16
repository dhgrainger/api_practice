 require 'json'
 require 'net/http'
 require 'nutritionix'
 # followed the tutorial and this does not work... onstant Nutritionix::Api_1_1 ... back to the drawing board

  app_id = '43789ff5'
  app_key = '84ab1be2928c84bd4126e84663c54998'
  provider = Nutritionix::Api_1_1.new(app_id, app_key)
  search_params = {
    offset: 0,
    limit: 1,
    fields: ['item_name', 'nf_calories', 'nf_total_fat', 'nf_protein', 'nf_total_carbohydrate'],
    query: 'potato'
  }
  results_json = provider.nxql_search(search_params)
  puts "Results: #{results_json}"
