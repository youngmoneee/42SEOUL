#!/usr/bin/ruby -w

data = [
['Frank', 33],
['Stacy', 15],
['Juan' , 24],
['Dom' , 32],
['Steve', 24],
['Jill' , 24]
]

data.sort_by! {|arr| arr[0]}.sort_by! {|arr| arr[1]}
data.each {|x, y|
  puts x
}
