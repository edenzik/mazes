###Eden Zik
###Mazes Extra Credit Assignment
####v1.0

To Run
=======

Testing
-------
`$ rspec test.rb`

Demo
-------
`$ ruby demo.rb`

Using
-------
`require 'import_relative "maze"`


Specs
=========
The following are the specification of the Maze assignment (taken from http://cosi105-2015.s3-website-us-west-2.amazonaws.com/content/topics/pa/pa_mazes/):

1. Represent a n by m maze in an appropriately designed class called Maze. Each position in the maze can be designated by two coordinates, x (across) and y (down). For a 4x5 maze the top row of positions (x,y) would be (0,0), (1,0), (2, 0) and (3,0). The constructor of the Maze class should take two parameters for n and m. Note of course that you need to represent the walls between cells not just the cells.
2. Implement a Maze#load(arg) method that initializes the maze using a string of ones and zeros as above
3. Implement a Maze#display method that prints a diagram of the maze on the console. It can be just a simple character based printout like above or any other format you want.
4. Implement a Maze#solve(begX, begY, endX, endY) method that determines if there’s a way to walk from a specified beginning position to a specified ending position. Of course it can return an error or false if there is now way.
5. Implement a Maze#trace(begX, begY, endX, endY) method that is just like solve() but traces the positions that the solution visits.
6. Implement a Maze#redesign() which will reset all the cells and walls and come up with a random new maze of the same size.

Intro
=====

The goal of this assignment was to show good Ruby practices and solve a nontrivial graph problem (of contracting Mazes)

Design
======

The class provided represents a Maze, extending the Array class.

A maze is represented as a 2D array, which is why each cell of the 1D array the maze is extending contains within itself an array - abstracted here by the [][] indexing.

The transpose function is used extensively here to provide the abstraction dictated in the assignment - which demanded (x,y) indexing while still conforming to the restraints of terminal printing, which must be done (y,x). In other words, reading as well as writing is done by line, where as the 2D matrix abstraction is by convention (and as defined in the specs) as being row followed by line. Hence the transpose method only converts the array to its internal representation of (x,y) after reading and before writing. 

Initialize
---------

Initializing the Maze requires a pre-defined dimension, here defined as n and m.

Loading
------

Loading the maze requires a bit string representation of the maze, which is then modded to conform to the dimension of the maze. An exception is thrown if the bit string is not of the right size. Upon the conversion of the bit string to an array, it is concatenated to self (also an array).

Display
------

Displaying the matrix requires transposing (see above). Henceforth, every character is replaced with a representation character - with the special form of # and * used to represent unfilled rows (in the case of developing Maze for debugging) and tracing solutions (respectively).

Tracing
------

Tracing the maze involves computing the shortest path from (begX,begY) to (endX,endY). It is a memoizied algorithm using a cache and a constructed route. At any point, it iterates through all the next positions - a form of depth first search that terminates at each node when the tracing goes out of bounds or hits a wall. This method is isomorphic to creating a new maze, as we will see next.

If the route traced hits a wall (the value is 1) then nil is returned. If the value is nil (current position is out of bounds) nil is returned. If this position has already been traversed, nil is returned. In all three base cases described, no point is added to the route.

If a new point is reached, the point is added to the cache and the route. If the current point is the destination, then we terminate and return the route. Otherwise, we recursively call on every legal adjacent position with a new copy of route for each (they cannot have the same instance of route).

Solve
-----
Solving is only true if there exists some path - that is, the trace method returns a non nill and non empty value.

Redesign
------

There are many algorithms to redesign a maze, and this one involves depth first search as well. It works by clearing the array (mutating all values to nil) followed by a sequential traversal of random legal adjacent positions. Every time a position is reached that has not been traversed, it can be marked with either a wall (1) or space (0). If it contains more than 1 adjacent space, it is a wall - otherwise - it is a space. It must be a wall if it in the corner.

Reflection
=======

This was probably one of the most enjoyable programming assignments I've done. Besides giving me an insight into the actual design of mazes, algorithms which I was not aware existed, it gave me even more practice with Ruby - a skill I gained exclusively from this course. 

Redisinging the Maze properly was hard - but I found a great animation on Wikipedia explaning the process. From that point, it was just a matter of implementation. After the code was done, I focused a lot on making it faster and optimizing the array operations (mostly by the use of caches).

CodeClimate
--------
After an iteration, I have managed to improve my CodeClimate grade to a B (from a C) - a grade based on the complexity of the redesign method. I believe, without sacraficing efficieny (for example, by not caching) it would've been difficult to write this code in a less complex manner. 

Good programming practices were followed throughout - with efficiency being a top priority.
