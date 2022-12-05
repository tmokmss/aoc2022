require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/5.txt"
  else
    "sample/5.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n")
parsed = []
input.each do |line|
  break if line.start_with?(" 1")
  arr = []
  line.chars.each_slice(4) do |slice|
    arr.push(slice[1])
  end
  parsed.push(arr)
end

p parsed

mod = Hash.new { |h, k| h[k] = [] }
parsed.each do |p|
  p.each_with_index do |pp, i|
    mod[i+1].unshift(pp) if pp != " "
  end
end

p mod

input.each do |line|
  next unless line.start_with?('move')
  # move 1 from 1 to 2
  arr = line.split(' ')
  num = arr[1].to_i
  from = arr[3].to_i
  to = arr[5].to_i
  num.times do 
    a = mod[from].pop
    mod[to].push(a)
  end
end

p (1..mod.keys.size).map {|i| mod[i][-1]}.join('')

mod = Hash.new { |h, k| h[k] = [] }
parsed.each do |p|
  p.each_with_index do |pp, i|
    mod[i+1].unshift(pp) if pp != " "
  end
end

input.each do |line|
  next unless line.start_with?('move')
  # move 1 from 1 to 2
  arr = line.split(' ')
  num = arr[1].to_i
  from = arr[3].to_i
  to = arr[5].to_i
  a = mod[from][-num..-1]
  mod[to] = mod[to].concat(a)
  num.times do 
    mod[from].pop
  end
end

p (1..mod.keys.size).map {|i| mod[i][-1]}.join('')
