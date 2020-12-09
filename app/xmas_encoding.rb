class XmasEncoding
  attr_reader :preamble_length, :lookback_length, :input_filename

  def initialize(input_filename, preamble_length = 5, lookback_length = 5)
    @preamble_length = preamble_length
    @lookback_length = lookback_length
    @input_filename = input_filename
  end

  def calculate_target
    pair = numbers.each_with_index.find do |number, idx|
      next if idx < preamble_length

      window = numbers[(idx - lookback_length)..(idx - 1)]
      window.permutation(2).none? { |a, b| a + b == number }
    end

    pair[0]
  end

  def encryption_weakness
    @target ||= calculate_target

    start = (0..numbers.length).find do |start_candidate|
      contiguous_addends(numbers, start_candidate, @target).reduce(:+) == @target
    end

    range = contiguous_addends(numbers, start, @target)
    range.min + range.max
  end

  private

  def contiguous_addends(arr, start, target_sum)
    sum = 0
    arr[start..-1].take_while do |n|
      sum += n
      sum <= target_sum
    end
  end

  def numbers
    File.readlines(input_filename, chomp: true).map(&:to_i)
  end
end
