require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/4.txt"
  else
    "sample/4.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  match = /(\d+)-(\d+),(\d+)-(\d+)/.match(line)
  [[match[1].to_i,match[2].to_i], [match[3].to_i,match[4].to_i]]
end

p parsed

ans1 = 0
parsed.each do |e0, e1|
  if e0[0] <= e1[0] && e0[1] >= e1[1]
    ans1 += 1
    next
  end
  if e1[0] <= e0[0] && e1[1] >= e0[1]
    ans1 += 1
    next
  end
end

p ans1

ans2 = 0
parsed.each do |e0, e1|
  if e0[1] >= e1[0] && e0[0] <= e1[1]
    ans2 += 1
    next
  end
  if e1[1] >= e0[0] && e1[0] <= e0[1]
    ans2 += 1
    next
  end
end

p ans2