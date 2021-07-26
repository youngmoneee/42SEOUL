#!/usr/bin/ruby -w
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    var.rb                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: youngpar <youngpar@student.42seoul.kr      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/25 14:30:31 by youngpar          #+#    #+#              #
#    Updated: 2021/05/25 14:30:31 by youngpar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

def my_var()
  hash = { a: 10, b: 10.to_s, c: nil, d: 10.0 }
  puts "my variables :"
  hash.each { |key, val| 
    puts "\t #{key} contains: #{val.nil? ? val.inspect : val.to_s} and is a type : #{val.class}"
  }
end

my_var()
