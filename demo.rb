#Eden Zik
#Mazes Extra Credit Assignment
#v1.0
#Demo file
#This file creates a Maze as specified in the example and iterates through it 10 times to come up with different ways to solve it starting from random start and end points.
#Some of those start/end points are walls (1's) - and hence cannot be solved - which the program would indicate.

require_relative 'maze'

m = 9
n = 9
puts "Initializing Maze"
maze = Maze.new(n,m)

puts "Loading Maze"
maze.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")

puts "Printing Maze:"
puts maze.display

puts "Now let's try to solve the maze starting at random points..."

for i in 1..10

	begX=rand(n-2)+1
	begY=rand(m-2)+1
	endX=rand(n-2)+1
	endY=rand(m-2)+1

	puts "Iteration #{i}"

	puts "Does solution exist to Maze between coordinates (#{begX}, #{begY}) and (#{endX},#{endY})?"
	if maze.solve(begX,begY,endX,endY)
		puts "Yes"
	else
		puts "No"
		next
	end

	puts "Can we trace a solution to the Maze between coordinates (#{begX}, #{begY}) and (#{endX},#{endY})?"
	p maze.trace(begX,begY,endX,endY)

	puts "Can we show the solution between (#{begX}, #{begY}) and (#{endX},#{endY})?"
	puts maze.trace_display(begX,begY,endX,endY)

	puts "\n-----------------------------------\n\n"

end

puts "Now let's try to redesign the maze randomly..."

puts "\n================================\n\n"

for i in 1..10

	puts "Iteration #{i}"

	puts "For example:"

	maze.redesign

	puts maze.display

	puts "\n-----------------------------------\n\n"
end


