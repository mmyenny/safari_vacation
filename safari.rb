require 'pg'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "safari_vacation"
)

class SeenAnimal < ActiveRecord::Base
end

def    json_print data
 puts JSON.pretty_generate(data.as_json)
end

SeenAnimal.create(species: "Snakes", count_of_times_seen: "7", location_of_last_seen: "Desert")

puts "Welcome to the Safari!"
puts "Here's a list of all the animals seen today."
json_print SeenAnimal.all
puts "BREAKING NEWS! We got updated information for the Vulturs"
SeenAnimal.find(5).update(count_of_times_seen: "20", location_of_last_seen: "River")
puts "Here's the updated information for the Vultures"
json_print SeenAnimal.find(5)
puts "Here are all the animals seen in the jungle today."
json_print SeenAnimal.where(location_of_last_seen: "Jungle")
SeenAnimal.where(location_of_last_seen: "Desert").delete_all
puts "We had incorrect information on animals in the desert! Here is the updated animal list!"
json_print SeenAnimal.all
puts "The total number of animals seen today is:"
json_print SeenAnimal.sum("count_of_times_seen")
puts "The total number of times Lions, Tigers, and Bears have been seen today is:"
json_print SeenAnimal.where(species:"Lion").or(SeenAnimal.where(species:"Tiger").or(SeenAnimal.where(species:"Bear"))).sum("count_of_times_seen")

