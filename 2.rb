require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/2.txt"
  else
    "sample/2.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map { |i| i.split }

scores = {
  X: 1,
  Y: 2,
  Z: 3,
}

score = 0

parsed.each do |opp, me|
  if opp == "A"
    if me == 'X'
      score += 3
    elsif me == 'Y'
      score += 6
    end
  elsif opp == "B"
    if me == 'Y'
      score += 3
    elsif me == 'Z'
      score += 6
    end
  elsif opp == "C"
    if me == 'Z'
      score += 3
    elsif me == 'X'
      score += 6
    end
  end
  score += scores[me.to_sym]
end


p score


scores2 = {
  X: 0,
  Y: 3,
  Z: 6,
}


score2 = 0

parsed.each do |opp, me|
  hand = ''
  if opp == "A"
    if me == 'X'
      hand = 'Z'
    elsif me == 'Y'
      hand = 'X'
    else 
      hand = 'Y'
    end
  elsif opp == "B"
    if me == 'X'
      hand = 'X'
    elsif me == 'Y'
      hand = 'Y'
    else 
      hand = 'Z'
    end
  elsif opp == "C"
    if me == 'X'
      hand = 'Y'
    elsif me == 'Y'
      hand = 'Z'
    else 
      hand = 'X'
    end
  end
  score2 += scores[hand.to_sym]
  score2 += scores2[me.to_sym]
end

p score2
