Sudokude
========

Published on rubygems here: [https://rubygems.org/gems/sudokude](https://rubygems.org/gems/sudokude)

This project initially started as a ruby exercise, just to write a function that could solve Sudoku puzzles. After completion, I decided to turn it into a gem, because, why not?

This is a very simple gem, and it provides two functions

1.  It can solve a sudoku puzzle via `.solve!`
2.  It can print the sudoku puzzle (solved or unsolved) via `.print`

Quickstart
-------------
1.  Initiate an instance of a Sudoku class with `Sudokude::Sudoku.new()`
2.  Pass a nested array for the Sudoku values. Each blank cell should be passed in as `nil`. The array should consist of 9 sub-arrays, one sub-array for each row in a Sudoku puzzle, in order from top to bottom, and left to right. For example, [http://i.imgur.com/RHDkxUV.png](this Sudoku puzzle) will look like:

 ```
 [[4,nil,9,1,3,7,nil,nil,nil],
 [nil,nil,nil,8,2,9,nil,6,nil],
 [2,nil,7,nil,nil,nil,nil,9,nil],
 [nil,5,6,nil,nil,8,nil,nil,9],
 [nil,nil,nil,3,5,1,nil,nil,6],
 [1,nil,nil,nil,nil,nil,8,5,nil],
 [nil,nil,nil,nil,1,nil,9,2,4],
 [6,2,nil,7,nil,3,nil,nil,nil],
 [nil,nil,nil,nil,8,2,6,7,3]]
 ```

3.  Call `.sovle!` on the instance to solve. The gem will either return a solved puzzle, or return an error if the puzzle is not possible to solve