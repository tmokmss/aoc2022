require "prettyprint"
require "set"
require_relative "./lib"

input = if ARGV.length < 1
    [
      [[72, 97], [:mult, 13], 19, 5, 6],
      [[55, 70, 90, 74, 95], [:square], 7, 5, 0],
      [[74, 97, 66, 57], [:add, 6], 17, 1, 0],
      [[86, 54, 53], [:add, 2], 13, 1, 2],
      [[50, 65, 78, 50, 62, 99], [:add, 3], 11, 3, 7],
      [[90], [:add, 4], 2, 4, 6],
      [[88, 92, 63, 94, 96, 82, 53, 53], [:add, 8], 5, 4, 7],
      [[70, 60, 71, 69, 77, 70, 98], [:mult, 7], 3, 2, 3],
    ]
  else
    [
      [[79, 98], [:mult, 19], 23, 2, 3],
      [[54, 65, 75, 74], [:add, 6], 19, 2, 0],
      [[79, 60, 97], [:square], 13, 1, 3],
      [[74], [:add, 3], 17, 0, 1],
    ]
  end

round = 0
inspects = Hash.new(0)
loop do
  (0...input.size).each do |monkey|
    mon = input[monkey]
    mon[0].each do |old|
      inspects[monkey] += 1
      item = case mon[1][0]
        when :mult
          old * mon[1][1]
        when :add
          old + mon[1][1]
        when :square
          old * old
        end
      item = item / 3
      if item % mon[2] == 0
        input[mon[3]][0].push(item)
      else
        input[mon[4]][0].push(item)
      end
    end
    mon[0] = []
  end
  round += 1
  break if round >= 20
end
p inspects.values.sort.reverse[0..1].inject(:*)

input = if ARGV.length < 1
    [
      [[72, 97], [:mult, 13], 19, 5, 6],
      [[55, 70, 90, 74, 95], [:square], 7, 5, 0],
      [[74, 97, 66, 57], [:add, 6], 17, 1, 0],
      [[86, 54, 53], [:add, 2], 13, 1, 2],
      [[50, 65, 78, 50, 62, 99], [:add, 3], 11, 3, 7],
      [[90], [:add, 4], 2, 4, 6],
      [[88, 92, 63, 94, 96, 82, 53, 53], [:add, 8], 5, 4, 7],
      [[70, 60, 71, 69, 77, 70, 98], [:mult, 7], 3, 2, 3],
    ]
  else
    [
      [[79, 98], [:mult, 19], 23, 2, 3],
      [[54, 65, 75, 74], [:add, 6], 19, 2, 0],
      [[79, 60, 97], [:square], 13, 1, 3],
      [[74], [:add, 3], 17, 0, 1],
    ]
  end

round = 0
inspects = Hash.new(0)
mult = input.map { |m| m[2] }.inject(:*)
loop do
  (0...input.size).each do |monkey|
    mon = input[monkey]
    mon[0].each do |old|
      inspects[monkey] += 1
      item = case mon[1][0]
        when :mult
          old * mon[1][1]
        when :add
          old + mon[1][1]
        when :square
          old * old
        end
      if item % mon[2] == 0
        input[mon[3]][0].push(item % mult)
      else
        input[mon[4]][0].push(item % mult)
      end
    end
    mon[0] = []
  end
  round += 1
  break if round >= 10000
end
p inspects.values.sort.reverse[0..1].inject(:*)
