require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/7.txt"
  else
    "sample/7.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

class Directory
  attr_accessor :parent, :children

  def initialize(parent)
    @parent = parent
    @children = {}
  end
end

cd = nil
root = nil
input.each_with_index do |line, i|
  if line.start_with?("$ cd ")
    dir = line.split[2]
    if dir == ".."
      cd = cd.parent
    elsif dir == "/"
      cd = Directory.new(nil)
      root = cd
    else
      parent = cd
      cd = Directory.new(parent)
      parent.children[dir] = cd
    end
  elsif line.start_with?("$ ls")
    input[i + 1...input.size].each do |ll|
      break if ll.start_with?("$")
      if ll.start_with?("dir")
      else
        size, name = ll.split
        cd.children[name] = size.to_i
      end
    end
  else
  end
end

def find_1(root)
  found = []
  search_helper(found, root)
  return found
end

def search_helper(found, cd)
  size = 0
  cd.children.each do |key, child|
    if child.is_a?(Directory)
      size += search_helper(found, child)
    else
      size += child
    end
  end
  if size <= 100000
    found.push(size)
  end
  return size
end

p find_1(root).sum

root_size = search_helper([], root)
target = 30000000 - (70000000 - root_size)
# p target

def find_2(root)
  found = []
  search_helper2(found, root)
  return found
end

def search_helper2(found, cd)
  size = 0
  cd.children.each do |key, child|
    if child.is_a?(Directory)
      size += search_helper2(found, child)
    else
      size += child
    end
  end
  found.push(size)
  return size
end
# p root
f2 = find_2(root)
p f2.filter { |i| i - target > 0 }.min
