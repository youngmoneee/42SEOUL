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
    if states.has_key?(input[0])
      puts capitals_cities[states[input[0]]]
    else
      puts "Unknown state"
    end
  end
end
where ARGV
