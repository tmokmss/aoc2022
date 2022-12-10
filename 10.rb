require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/10.txt"
  else
    "sample/10.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

cycle = 0
register = 1
adding = 0
ans1 = 0
p = 0
display = Array.new(6) {Array.new(40, '-')}

loop do
  cycle += 1
  if [20, 60, 100, 140, 180, 220].include?(cycle)
    p[cycle, register]
    ans1 += cycle * register
  end
  break if cycle > 240
  yy= (cycle-1) / 40
  xx = (cycle-1) % 40
  pp [yy, xx]
  display[yy][xx] = xx >= register -1 && xx <= register + 1 ? '#' : '.'
  if adding == 0
    break if p >= input.size
    line = input[p]
    if line.start_with?("addx")
      _, n = line.split
      adding = n.to_i
    else # noop
    end
    p += 1
  else
    register += adding
    adding = 0
  end
end

p ans1

puts display.map{|line|line.join}.join("\n")
