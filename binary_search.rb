require 'byebug'

class BinarySearch
  def search(array:, number:)
    low = 0
    high = array.size


    while low < high do
      middle_point = (low + (high - low) / 2).floor
      value = array[middle_point]

      if value == number
        return array[middle_point]
      elsif value > number
        high = middle_point
      else
        low = middle_point + 1
      end
    end

    return nil
  end
end
