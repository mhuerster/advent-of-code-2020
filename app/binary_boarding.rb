class BinaryBoarding
  MAX_ROW = 127.freeze
  MAX_COLUMN = 7.freeze

  LOWER = ['F', 'L'].freeze
  UPPER = ['B', 'R'].freeze

  class << self

    # e.g. FBFBBFFRLR => row 44, column 5
    def seat_id(boarding_pass)
      row_str = boarding_pass[0,7]     # FBFBBFF
      column_str = boarding_pass[7,10] # RLR

      row = decode(row_str, MAX_ROW)
      column = decode(column_str, MAX_COLUMN)

      # Every seat also has a unique seat ID: multiply the row by 8, then add the column.
      row*8 + column
    end

    def decode(str, max, min=0)
      return max if str.empty?

      char = str[0]
      mdpt = midpoint(min, max)

      if LOWER.include?(char)
        decode(str[1..-1], mdpt-1, min)
      elsif UPPER.include?(char)
        decode(str[1..-1], max, mdpt)
      else
        raise 'invalid character'
      end
    end

    private

    def midpoint(min, max)
      max - (max - min)/2
    end
  end
end

# Driver code
#boarding_passes = File.readlines('spec/fixtures/binary_boarding/input.txt', chomp: true)
#decoder = BinaryBoarding.new
#boarding_passes.map { |bp| BinaryBoarding.seat_id(bp) }.max
