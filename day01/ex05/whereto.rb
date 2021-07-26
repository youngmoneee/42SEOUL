#!/usr/bin/ruby -w
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    whereto.rb                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: youngpar <youngpar@student.42seoul.kr      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/25 19:34:35 by youngpar          #+#    #+#              #
#    Updated: 2021/05/25 19:34:35 by youngpar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

def youngseo(argv)

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

  if not argv.length == 1
    return ;
  end
  arr = argv[0].split(",").each{|x| x.gsub!(/^\s*|\s*$/, "")}.delete_if {|x| x == ""}
  arr.length.times do |x|
    arr[x] = arr[x].split(" ").map{|y| y.capitalize}.join(" ")
  end

  arr.each do |x|
    if states.has_key?(x)
      puts "#{capitals_cities[states[x]]} is the capital of #{x} (akr: #{states[x]})"
    elsif capitals_cities.has_value?(x)
      puts "#{x} is the capital of #{states.key(capitals_cities.key(x))} (akr: #{capitals_cities.key(x)})"
    else
      puts "#{x} is neither a capital city nor a state"
    end
  end
end

youngseo(ARGV)
