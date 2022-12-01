require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/1.txt"
  else
    "sample/1.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

elfs = [0]
input.each do |i|
  elfs.push(0) if i == ''
  elfs[-1] += i.to_i
end
p elfs
p elfs.sort[-1]

p elfs.sort.reverse[0..2].sum
