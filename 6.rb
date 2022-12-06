require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/6.txt"
  else
    "sample/6.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)[0]

marker = 0
(0..input.chars.size - 4).each do |i|
  s = Set.new(input.chars[i...i+4])
  break marker = i + 4 if s.size == 4
end

p marker

marker = 0
(0..input.chars.size - 14).each do |i|
  s = Set.new(input.chars[i...i+14])
  break marker = i + 14 if s.size == 14
end

p marker
