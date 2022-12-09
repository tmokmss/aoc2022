require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/9.txt"
  else
    "sample/9.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  a, b = line.split
  [a, b.to_i]
end

p parsed

def sgn(n)
  n <=> 0
end

head = [0, 0]
tail = [0, 0]
visited = Set.new()
parsed.each do |dir, num|
  dir = case dir
    when "U"
      [0, 1]
    when "D"
      [0, -1]
    when "R"
      [1, 0]
    when "L"
      [-1, 0]
    end
  num.times do |i|
    newhead = [head[0] + dir[0], head[1] + dir[1]]
    diff = [tail[0] - newhead[0], tail[1] - newhead[1]]
    taildiff = if diff[0].abs <= 1 && diff[1].abs <= 1
        [0, 0]
      else
        [-sgn(diff[0]), -sgn(diff[1])]
      end
    newtail = [tail[0] + taildiff[0], tail[1] + taildiff[1]]
    tail = newtail
    head = newhead
    visited.add(tail)
  end
end

p visited.size

secs = (0...10).map { [0, 0] }
visited = Set.new()
parsed.each do |dir, num|
  dir = case dir
    when "U"
      [0, 1]
    when "D"
      [0, -1]
    when "R"
      [1, 0]
    when "L"
      [-1, 0]
    end
  num.times do
    head = secs[0]
    newhead = [head[0] + dir[0], head[1] + dir[1]]
    secs[0] = newhead
    (1...10).each do |i|
      newhead = secs[i - 1]
      tail = secs[i]
      diff = [tail[0] - newhead[0], tail[1] - newhead[1]]
      taildiff = if diff[0].abs <= 1 && diff[1].abs <= 1
          [0, 0]
        else
          [-sgn(diff[0]), -sgn(diff[1])]
        end
      newtail = [tail[0] + taildiff[0], tail[1] + taildiff[1]]
      secs[i] = newtail
    end
    visited.add(secs[-1])
  end
end

p visited.size
