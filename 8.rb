require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/8.txt"
  else
    "sample/8.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip).map{|l| l.chars.map(&:to_i)}

w = input[0].size
h = input.size

visible = Set.new()

(0...h).each do |i|
  maxnow = -1
  (0...w).each do |j|
    if input[i][j] > maxnow
      maxnow = input[i][j]
      visible.add([i, j])
    end
  end
end

(0...h).each do |i|
  maxnow = -1
  (0...w).each do |j|
    if input[i][w- j - 1] > maxnow
      maxnow = input[i][w- j - 1]
      visible.add([i, w- j - 1])
    end
  end
end

(0...w).each do |j|
  maxnow = -1
  (0...h).each do |i|
    if input[i][j] > maxnow
      maxnow = input[i][j]
      visible.add([i, j])
    end
  end
end

(0...w).each do |j|
  maxnow = -1
  (0...h).each do |i|
    if input[h-i-1][j] > maxnow
      maxnow = input[h-i-1][j]
      visible.add([h-i-1, j])
    end
  end
end
p visible.size

def calc_score(ww, hh, w, h, input)
  score = [ww]
  maxnow = input[hh][ww]
  (1...ww).each do |i|
    if input[hh][ww-i] >= maxnow
      score[-1] = i
      break
    end
  end
  score.push(w-ww-1)
  maxnow = input[hh][ww]
  (1...w-ww).each do |i|
    if input[hh][ww+i] >= maxnow
      score[-1] = i
      break
    end
  end
  score.push(hh)
  maxnow = input[hh][ww]
  (1...hh).each do |i|
    if input[hh-i][ww] >= maxnow
      score[-1] = i
      break
    end
  end
  score.push(h-hh-1)
  maxnow = input[hh][ww]
  (1...h-hh).each do |i|
    if input[hh+i][ww] >= maxnow
      score[-1] = i
      break
    end
  end
  return score.inject(:*)
end

maxnow = 0
(0...h).each do |i|
  (0...w).each do |j|
    s = calc_score(i, j, w, h, input)
    if s > maxnow
      maxnow = s
    end
  end
end

p maxnow