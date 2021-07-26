#!/usr/bin/ruby -w
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    croissant.rb                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: youngpar <youngpar@student.42seoul.kr      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/25 16:20:25 by youngpar          #+#    #+#              #
#    Updated: 2021/05/25 16:20:25 by youngpar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

def croissant path
  new = File.new(path, "r")
  if new
    fp = new.sysread(new.stat.size)
    puts fp.split(",\n", -1).sort_by{|x| x.to_i}
  else
    return nil
  end
  new.close
end

croissant("numbers.txt")
