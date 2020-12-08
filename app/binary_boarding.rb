class BinaryBoarding
  MAX_ROW = 127
  MAX_COLUMN = 7

  LOWER = %w[F L].freeze
  UPPER = %w[B R].freeze

  class << self
    # e.g. FBFBBFFRLR => row 44, column 5
    def seat_id(boarding_pass)
      row_str = boarding_pass[0, 7]     # FBFBBFF
      column_str = boarding_pass[7, 10] # RLR

      row = decode(row_str, MAX_ROW)
      column = decode(column_str, MAX_COLUMN)

      # Every seat also has a unique seat ID: multiply the row by 8, then add the column.
      row * 8 + column
    end

    def decode(str, max, min = 0)
      return max if str.empty?

      char = str[0]
      mdpt = midpoint(min, max)

      if LOWER.include?(char)
        decode(str[1..-1], mdpt - 1, min)
      elsif UPPER.include?(char)
        decode(str[1..-1], max, mdpt)
      else
        raise 'invalid character'
      end
    end

    private

    def midpoint(min, max)
      max - (max - min) / 2
    end
  end
end

# Part 1 driver code
boarding_passes = File.readlines('spec/fixtures/binary_boarding/input.txt', chomp: true)
decoder = BinaryBoarding.new
seat_ids = boarding_passes.map { |bp| BinaryBoarding.seat_id(bp) }
seat_ids.max

# Part 2 driver code
max_actual_seat_id = seat_ids.max
min_actual_seat_id = seat_ids.min
sorted_seat_ids = seat_ids.sort
offset = min_actual_seat_id

(min_actual_seat_id..max_actual_seat_id).find { |seat_id| sorted_seat_ids[seat_id - offset] != seat_id }
