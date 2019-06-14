class Rover
  ORIENTATIONS = ["N", "E", "S", "W"]
  SPINS_ADJUST = { L: -1, R: 1 }
  
  attr_reader :orientation, :crashed
  
  def initialize(coords = "0 0 N", max_coords = [5, 5], crashed = false)
    x, y, @orientation = coords.split(" ")
    @x, @y             = [x, y].map(&:to_i)
    @crashed           = crashed
    @max_coords        = max_coords
  end
  
  def position
    [@x, @y]
  end
  
  def spin(direction)
    idx          = ORIENTATIONS.find_index(@orientation)
    new_idx      = idx + SPINS_ADJUST[direction.to_sym]
    @orientation = ORIENTATIONS[new_idx % ORIENTATIONS.length]
  end
  
  def move
    case @orientation
    when "N"
      @y += 1
    when "E"
      @x += 1
    when "S"
      @y -= 1
    when "W"
      @x -= 1
    end
    @crashed = did_crash?
  end
  
  def run(instruction)
    return if @crashed
    if is_spin?(instruction)
      spin(instruction)
    elsif instruction === "M"
      move
    else
      "Invalid instruction: #{instruction}"
    end
  end
  
  def to_s
    @crashed ? "CRASHED!!!" : "#{@x} #{@y} #{@orientation}"
  end
  
  def is_spin?(instruction)
    SPINS_ADJUST.keys.include?(instruction.to_sym)
  end
  
  def did_crash?
    @x < 0 || @y < 0 || @x > @max_coords[0] || @y > @max_coords[1]
  end
end