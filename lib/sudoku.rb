require 'erb'

class Sudoku
  def initialize(sudoku)
    raise "This is not the proper size" if sudoku.map {|e| e.size } != [9,9,9,9,9,9,9,9,9]
    @sudoku = {}
    j = 0
    sudoku.each do |row|
      9.times do |i|
        if i <= 2 && j <= 2
          b = 0
        elsif i <= 5 && j <= 2
          b = 1
        elsif i > 5 && j <= 2
          b = 2
        elsif i <= 2 && j <= 5
          b = 3
        elsif i <= 5 && j <= 5
          b = 4
        elsif i > 5 && j <= 5
          b = 5
        elsif i <= 2 && j > 5
          b = 6
        elsif i <= 5 && j > 5
          b = 7
        else
          b = 8
        end
        @sudoku[i.to_s + j.to_s + b.to_s] = row[i]      #assign keys to each sudoku number. first number represents its column, second represents its column, third represents its box
      end
      j += 1
    end
  end

  def print
    @sudoku.values.each_slice(9).to_a.each do |row| 
      row.map! do |e| 
        if e.nil?
          "n"
        else
          e
        end
      end
      puts row.join(" ")
    end
  end

  def solve!
    unsolved = {}
    @keysizes = []
    @sudoku.each do |key, value|
      if value.nil?
        unsolved[key] = [1,2,3,4,5,6,7,8,9]
      end
    end

    until solved
      #Simple elimination method
      unsolved.each do |key, value|
        value.reject! do |number| 
          (@sudoku.row(key[1].to_i) + @sudoku.column(key[0].to_i) + @sudoku.box(key[2].to_i)).include?(number)
        end
        @sudoku[key] = value[0] if value.size == 1
        unsolved.delete_if { |key, value| value.empty? }
      end

      
      #Naked multiples method
      unsolved.each do |key, value|
        if unsolved.row(key[1].to_i).has_naked_multiple?(value)
          unsolved.each do |nkey, nvalue|
            nvalue.reject! { |n| value.include?(n) } if (!(nvalue-value).empty? && key[1] == nkey[1])
          end
        end
        if unsolved.column(key[0].to_i).has_naked_multiple?(value)
          unsolved.each do |nkey, nvalue|
            nvalue.reject! { |n| value.include?(n) } if (!(nvalue-value).empty? && key[0] == nkey[0])
          end
        end
        if unsolved.box(key[2].to_i).has_naked_multiple?(value)
          unsolved.each do |nkey, nvalue|
            nvalue.reject! { |n| value.include?(n) } if (!(nvalue-value).empty? && key[2] == nkey[2])
          end
        end

        @sudoku[key] = value[0] if value.size == 1
        unsolved.delete_if { |key, value| value.empty? }
      end

      if unsolvable
        puts "Impossible to solve. Best solution (n if no solution):"
        break
      end  
    end
    print
  end

  private

  def solved
    @sudoku.values.compact.size == 81                   # Array#compact removes all nils. A solved puzzle has no nils to remove.
  end

  def unsolvable
    @keysizes << @sudoku.values.compact.size
    @keysizes[-1] == @keysizes[-3]                      # if no values have added to the Sudoku over two passes, it is unsolvable
  end                                                   # two passes required because it may take one extra pass to push values to Sudoku

end

class Hash
  def row(i)
    self.select { |key, value| key[1].to_i == i }.values
  end

  def column(i)
    self.select { |key, value| key[0].to_i == i }.values
  end

  def box(i)
    self.select { |key, value| key[2].to_i == i }.values
  end
end

class Array
  def has_naked_multiple?(item)
    self.select {|e| (e-item).empty? }.size == item.size
  end
end


b = Sudoku.new([[4,nil,9,1,3,7,nil,nil,nil],[nil,nil,nil,8,2,9,nil,6,nil],[2,nil,7,nil,nil,nil,nil,9,nil],[nil,5,6,nil,nil,8,nil,nil,9],[nil,nil,nil,3,5,1,nil,nil,6],[1,nil,nil,nil,nil,nil,8,5,nil],[nil,nil,nil,nil,1,nil,9,2,4],[6,2,nil,7,nil,3,nil,nil,nil],[nil,nil,nil,nil,8,2,6,7,3]])
c = Sudoku.new([[nil,3,nil,nil,nil,nil,4,nil,7],[1,nil,8,nil,5,nil,nil,nil,nil],[nil,nil,nil,nil,nil,2,nil,9,nil],[nil,nil,6,5,1,nil,2,4,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,4,2,nil,7,9,3,nil,nil],[nil,1,nil,2,nil,nil,nil,nil,nil],[nil,nil,nil,nil,8,nil,1,nil,4],[8,nil,5,nil,nil,nil,nil,3,nil]])
d = Sudoku.new([[3,nil,nil,nil,nil,nil,4,nil,7],[1,nil,8,nil,5,nil,nil,nil,nil],[nil,nil,nil,nil,nil,2,nil,9,nil],[nil,nil,6,5,1,nil,2,4,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,4,2,nil,7,9,3,nil,nil],[nil,1,nil,2,nil,nil,nil,nil,nil],[nil,nil,nil,nil,8,nil,1,nil,4],[8,nil,5,nil,nil,nil,nil,3,nil]])
e = Sudoku.new([[1,2,3,4,5,6,7,8,9],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil,nil,nil,nil]])

e.solve!

