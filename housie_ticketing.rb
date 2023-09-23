
def available_nums
  # get all available numners
  @numbers = []
  # 2-D array each one represent possible column values
  1.upto(9) do |i|
    range = i == 1 ? (i-1)*10+1..(i*10-1) : i == 9 ? (i-1)*10..(i*10-1)+1 : (i-1)*10..(i*10-1)
    @numbers << range.to_a
  end
end

def get_row_values
  # Create a row with 5 values

  # Declare array with size of 9 and nil as default value
  row = Array.new(9, nil)

  #get array index ie (0..8) and shuffle
  bin_index_array = (0...@numbers.length).to_a.shuffle

  5.times do
    bin_index = bin_index_array.pop # as already shuffled get last index value and delete using pop
    row[bin_index] = @numbers[bin_index].pop # here we get last element & delete with in column range i.e if index 0 get element from (1..9)
  end
  row
end

def validate_and_sort_cloumns
  # apply tanspose matix(to 9X3) and sort columns & revert back to 3X9 matrix
  @rows = @rows.transpose.each { |col| sort_col(col) }.transpose
end

def sort_col(column)
  # If My columns consists 2 or 3 then we should sort
  case column.compact.count
  when 0 then @empty_column = true # represent invalid output. as each column consists of alteast one elements
  when 1 then column # do nothing
  when 2 # swap two elements without tampering nil obj
    nil_index = column.index(nil) # as we have only one nil get index
    first_nn, last_nn = [0, 1, 2] - [nil_index] # non nil indexes
    # Swap the two non-nil elements, if first is greater than second number
    if column[first_nn] > column[last_nn]
      column[first_nn], column[last_nn] = column[last_nn], column[first_nn]
    end
  when 3 then column.sort! # just sort the three numbers
  end
end

available_nums
@rows = []
i = 0
loop do
  @empty_column = false
  puts "ITERATING #{i+=1}"
  all_rows = Array.new(3) { get_row_values }
  @rows = all_rows.shuffle
  validate_and_sort_cloumns
  # puts @empty_column
  break unless @empty_column
end

@rows.each do |row|
  puts row.map {|ele| ele.nil? ? "X" : ele}.join("\t") #replace nil with "X"
end
