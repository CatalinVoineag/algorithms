require 'byebug'

class Bubble
  def sort(array)
    i = 0

    while i < array.size
      j = 0
      while j < array.size - 1 - i
        if array[j] > array[j + 1]
          tmp = array[j]
          array[j] = array[j + 1]
          array[j + 1] = tmp
        end
        j += 1
      end
      i += 1
    end

    array
  end
end
