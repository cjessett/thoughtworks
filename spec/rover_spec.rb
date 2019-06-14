require 'rover'

describe Rover do
  describe "#new" do
    it "should return a Rover instance" do
      rover = Rover.new
      expect(rover).to be_an_instance_of(Rover)
    end
  end
  
  describe "#position" do
    it "should return the position of the rover" do
      rover = Rover.new("1 2 N")
      expect(rover.position).to eq([1, 2])
    end
  end
  
  describe "#orientation" do
    it "should return the orientation of the rover" do
      rover = Rover.new("1 2 N")
      expect(rover.orientation).to eq("N")
    end
  end
  
  describe "#spin" do
    context "when the instruction is L" do
      it "should return W when facing N" do
        rover = Rover.new("1 2 N")
        rover.spin("L")
        expect(rover.orientation).to eq("W")
      end
      
      it "should return N when facing E" do
        rover = Rover.new("1 2 E")
        rover.spin("L")
        expect(rover.orientation).to eq("N")
      end
      
      it "should return E when facing S" do
        rover = Rover.new("1 2 S")
        rover.spin("L")
        expect(rover.orientation).to eq("E")
      end
      
      it "should return S when facing W" do
        rover = Rover.new("1 2 W")
        rover.spin("L")
        expect(rover.orientation).to eq("S")
      end
    end
    
    context "when the instruction is R" do
      it "should return E when facing N" do
        rover = Rover.new("1 2 N")
        rover.spin("R")
        expect(rover.orientation).to eq("E")
      end
      
      it "should return S when facing E" do
        rover = Rover.new("1 2 E")
        rover.spin("R")
        expect(rover.orientation).to eq("S")
      end
      
      it "should return W when facing S" do
        rover = Rover.new("1 2 S")
        rover.spin("R")
        expect(rover.orientation).to eq("W")
      end
      
      it "should return N when facing W" do
        rover = Rover.new("1 2 W")
        rover.spin("R")
        expect(rover.orientation).to eq("N")
      end
    end
  end
  
  describe "#move" do
    it "should change the correct coordinate by 1" do
      rover = Rover.new("1 2 N")
      rover.move
      expect(rover.position).to eq([1, 3])
    end
    
    it "should crash the rover when it moves off the plateau" do
      rover = Rover.new("0 0 S")
      rover.move
      expect(rover.crashed).to be true
    end
    
    it "should crash when the rover moves beyond the max coords" do
      rover = Rover.new("5 5 N")
      rover.move
      expect(rover.crashed).to be true
    end
  end
  
  describe "#run" do
    context "when the instruction is a spin" do
      it "should not change the position" do
        rover = Rover.new("1 2 N")
        rover.run("R")
        expect(rover.position).to eq([1, 2])
      end
      
      it "should update the orientation" do
        rover = Rover.new("1 2 N")
        rover.run("R")
        expect(rover.orientation).to eq("E")
      end
    end
    
    context "when the instruction is a move" do
      it "should not change the orientation" do
        rover = Rover.new("1 2 N")
        rover.run("M")
        expect(rover.orientation).to eq("N")
      end
      
      it "should update the position" do
        rover = Rover.new("1 2 N")
        rover.run("M")
        expect(rover.position).to eq([1, 3])
      end
    end
    
    context "when the rover is crashed" do
      it "should not move" do
        rover = Rover.new("0 0 S", [1, 1], true)
        rover.run("M")
        expect(rover.position).to eq([0, 0])
      end
      
      it "should not spin" do
        rover = Rover.new("0 0 S", [1, 1], true)
        rover.run("R")
        expect(rover.orientation).to eq("S")
      end
      
      it "should tell us it crashed" do
        rover = Rover.new("0 0 S", [1, 1], true)
        expect(rover.to_s).to eq("CRASHED!!!")
      end
    end
  end
end