require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/3.txt"
  else
    "sample/3.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  n = line.size
  [line[0...n / 2], line[n / 2...n]]
end

ans = 0
parsed.each do |a, b|
  aa = Set.new(a.chars)
  bb = Set.new(b.chars)

  c = aa.intersection(bb).to_a[0]
  if c == c.upcase
    ans += c.ord - "A".ord + 27
  else
    ans += c.ord - "a".ord + 1
  end
end

p ans

seen = Set.new
ans2 = 0;
input.each_with_index do |line, i|
  if i%3 == 0
    c= seen.to_a[0]
    seen = Set.new(line.chars)
    next if c.nil?
    if c == c.upcase
      ans2 += c.ord - "A".ord + 27
    else
      ans2 += c.ord - "a".ord + 1
    end
    next
  end
  seen = seen.intersection(Set.new(line.chars))
  p seen
end

c= seen.to_a[0]
if c == c.upcase
  ans2 += c.ord - "A".ord + 27
else
  ans2 += c.ord - "a".ord + 1
end

p ans2