require_relative 'lib/rover'

input = <<-INPUT
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
0 0 S
M
INPUT

lines  = input.split("\n")
max    = lines[0].split(" ").map(&:to_i)
rovers = lines[1, lines.length].each_slice(2).to_a

rovers.each do |rover_info|
  coords, moves = rover_info
  rover = Rover.new(coords)
  moves.split("").each { |m| rover.run(m) }
  puts rover
end