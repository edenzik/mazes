##Eden Zik
#Mazes Extra Credit Assignment
##v1.0
#Unit Testing
#This is unit testing with RSpec to show that a maze can be constructed.
#Tests are self documented by their "it" clauses in Rspec.
#To run:
# $ rspec test.rb
# From the base directory

require_relative "maze.rb"
require "rspec/expectations"

RSpec.describe Maze do
	before(:all) do
		@n = 9
		@m = 9
		@maze = Maze.new(@n,@m)
	end
	it "should be able to be loaded" do
		@maze.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
		@maze.dimensions == [@n,@m]
	end
	it "should be able to be drawn" do
		@maze.display.lines.length == @m
		@maze.display.length == @m*@n
	end
	it "should be solveable" do
		@maze.solve(1,1,5,5)
	end
	it "should be traceable" do
		@maze.trace(1,1,5,5)
	end
	it "should be re designable" do
		@maze.redesign
	end
end



