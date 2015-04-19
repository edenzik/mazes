#Eden Zik
#Mazes Extra Credit Assignment
#v1.0
#This is a class that represents a Maze, extending the Array class.
#Refer to the documentation for more functionality information.

class Maze < Array
	#Initializing the Maze using dimensions
	def initialize(n,m)
		@n = n
		@m = m
	end
	#Loads the Maze from a bit string
	def load(arg)
		if not arg.length.eql?(@m*@n)
			raise "Bad dimensions, must be #{@n} by #{@m}"
		end
		self.concat(arg.chars.map{|ele| ele.to_i}.each_slice(@n).to_a.transpose)
	end
	#Displays the matrix
	def display
		self.transpose.map.with_index{
			|row, i| row.map.with_index{
				|ele, j|	ele.nil? ? "#" :
						ele.eql?(2) ? "*" :
						ele.zero? ? " " : 
						i.even? ? 
						j.even? ? "+" :
						"-" : "|"
			}.join("")
		}.join("\n")
	end
	#Gives the dimensions of the maze
	def dimensions
		[@n,@m]
	end
	#Gives an array of all adjacent cells to this one
	def adjacent(x,y)
		[[x+1,y],[x-1,y],[x,y+1],[x,y-1]]
	end
	#Traces the maze to figure out the path to the solution
	def trace(begX, begY, endX, endY, cache=[], route=[])
		return nil if self[begX][begY].eql? 1		#Base cases
		return nil if self[begX][begY].nil?
		return nil if cache.include? [begX,begY]
		cache.push([begX,begY])
		route.push([begX,begY])
		return route if [begX,begY].eql? [endX,endY]
		adjacent(begX,begY).map{|x,y| trace(x,y,endX,endY,cache,Array.new(route))}.compact().flatten(1)
	end
	#Prints a path to the solution (using temporary mutation)
	def trace_display(begX, begY, endX, endY)
		trace = trace(begX,begY,endX,endY)
		return self.display if trace.nil?
		trace.each{|x, y| self[x][y]=2}
		temp = self.display
		trace.each{|x, y| self[x][y]=0}
		temp
	end	
	#Determines whether there exists a solution from beg to end
	def solve(begX, begY, endX, endY)
		is = trace(begX,begY,endX,endY)
		return false if is.nil?
		return false if is.empty?
		true
	end
	#Determines border
	def border(x,y)
		(x+1).eql? @n or x.eql? 0 or (y+1).eql? @m or y.eql? 0
	end
	#Returns corners of this current maze
	def corners
		[[0,0],[0,@m-1],[@n-1,0],[@n-1,@m-1]]
	end
	#Redesigns the maze
	def redesign(begX=rand(@n-2)+1, begY=rand(@m-2)+1, reset=true)
		if reset 					#Initial setup
			self.clear
			self.concat(Array.new(@n) {Array.new(@m)})
			corners.each{|x,y| self[x][y] = 1}
		end
		return if not self[begX][begY].nil?		#Terminates if seen already
		if border(begX,begY)				#Terminates if border	
			self[begX][begY] = 1
			return
		end
		adjacent = adjacent(begX,begY)
		if adjacent.map{|x,y| self[x][y]}.compact.flatten.count(0)>1
			self[begX][begY] = 1
		else
			self[begX][begY]=0
		end
		adjacent.shuffle.map{|x,y| redesign(x,y, false)}
	end
end

