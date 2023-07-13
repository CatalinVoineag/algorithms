require 'byebug'

class TwoCrystalBalls
  def find_index_where_they_break(array)
    jump_amount = Math.sqrt(array.size).floor

    index = jump_amount

    while array[index] == false
      index += jump_amount
    end

    index -= jump_amount

    while array[index] == false
      index += 1
    end

    array[index] == true ? index : nil
  end
end
