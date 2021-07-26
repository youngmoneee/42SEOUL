#!/usr/bin/ruby -w

def where input
  states = {
    "Oregon" => "OR",
    "Alabama" => "AL",
    "New Jersey" => "NJ",
    "Colorado" => "CO"
  }
  capitals_cities = {
    "OR" => "Salem",
    "AL" => "Montgomery",
    "NJ" => "Trenton",
    "CO" => "Denver"
  }
  if input.length == 1
    if capitals_cities.has_value?(input[0])
      puts states.key(capitals_cities.key(input[0]))
    else
      puts "Unknown capital city"
    end
  end
end
where ARGV
