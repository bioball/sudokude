require 'sudokude'
require 'rspec'

describe "Sudokude" do
  before do
    @puzzle1 = Sudokude::Sudoku.new([
      [4,   nil, 9,   1,   3,   7,   nil, nil, nil],
      [nil, nil, nil, 8,   2,   9,   nil, 6,   nil],
      [2,   nil, 7,   nil, nil, nil, nil, 9,   nil],
      [nil, 5,   6,   nil, nil, 8,   nil, nil, 9  ],
      [nil, nil, nil, 3,   5,   1,   nil, nil, 6  ],
      [1,   nil, nil, nil, nil, nil, 8,   5,   nil],
      [nil, nil, nil, nil, 1,   nil, 9,   2,   4  ],
      [6,   2,   nil, 7,   nil, 3,   nil, nil, nil],
      [nil, nil, nil, nil, 8,   2,   6,   7,   3  ]
    ])

    @puzzle2 = Sudokude::Sudoku.new([
      [nil, 3,   nil, nil, nil, nil, 4,   nil, 7  ],
      [1,   nil, 8,   nil, 5,   nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, 2,   nil, 9,   nil],
      [nil, nil, 6,   5,   1,   nil, 2,   4,   nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, 4,   2,   nil, 7,   9,   3,   nil, nil],
      [nil, 1,   nil, 2,   nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 8,   nil, 1,   nil, 4  ],
      [8,   nil, 5,   nil, nil, nil, nil, 3,   nil]
    ])
  end

  describe "solves" do

    it "an easy puzzle" do
      @puzzle1.solve.should == [
        [4, 6, 9, 1, 3, 7, 2, 8, 5],
        [5, 3, 1, 8, 2, 9, 4, 6, 7],
        [2, 8, 7, 5, 6, 4, 3, 9, 1],
        [7, 5, 6, 2, 4, 8, 1, 3, 9],
        [8, 9, 2, 3, 5, 1, 7, 4, 6],
        [1, 4, 3, 9, 7, 6, 8, 5, 2],
        [3, 7, 8, 6, 1, 5, 9, 2, 4],
        [6, 2, 4, 7, 9, 3, 5, 1, 8],
        [9, 1, 5, 4, 8, 2, 6, 7, 3]
      ]
    end

    it "a hard puzzle" do
      @puzzle2.solve.should == [
        [2, 3, 9, 8, 6, 1, 4, 5, 7],
        [1, 7, 8, 9, 5, 4, 6, 2, 3],
        [6, 5, 4, 7, 3, 2, 8, 9, 1],
        [7, 8, 6, 5, 1, 3, 2, 4, 9],
        [3, 9, 1, 4, 2, 8, 5, 7, 6],
        [5, 4, 2, 6, 7, 9, 3, 1, 8],
        [4, 1, 3, 2, 9, 6, 7, 8, 5],
        [9, 2, 7, 3, 8, 5, 1, 6, 4],
        [8, 6, 5, 1, 4, 7, 9, 3, 2]
      ]
    end
  end

  it "can stringify an instance" do
    @puzzle1.to_s.should == "[[4, nil, 9, 1, 3, 7, nil, nil, nil], [nil, nil, nil, 8, 2, 9, nil, 6, nil], [2, nil, 7, nil, nil, nil, nil, 9, nil], [nil, 5, 6, nil, nil, 8, nil, nil, 9], [nil, nil, nil, 3, 5, 1, nil, nil, 6], [1, nil, nil, nil, nil, nil, 8, 5, nil], [nil, nil, nil, nil, 1, nil, 9, 2, 4], [6, 2, nil, 7, nil, 3, nil, nil, nil], [nil, nil, nil, nil, 8, 2, 6, 7, 3]]"
    @puzzle1.solve.to_s.should == "[[4, 6, 9, 1, 3, 7, 2, 8, 5], [5, 3, 1, 8, 2, 9, 4, 6, 7], [2, 8, 7, 5, 6, 4, 3, 9, 1], [7, 5, 6, 2, 4, 8, 1, 3, 9], [8, 9, 2, 3, 5, 1, 7, 4, 6], [1, 4, 3, 9, 7, 6, 8, 5, 2], [3, 7, 8, 6, 1, 5, 9, 2, 4], [6, 2, 4, 7, 9, 3, 5, 1, 8], [9, 1, 5, 4, 8, 2, 6, 7, 3]]"
  end

  describe "raises an error" do
    it "when an array is not passed in" do
      expect { Sudokude::Sudoku.new("Banana") }.to raise_error(TypeError)
    end

    it "when the matrix is an improper size" do
      expect { Sudokude::Sudoku.new([1,2,3]) }.to raise_error(StandardError, "This is not the proper size")
    end
  end

end