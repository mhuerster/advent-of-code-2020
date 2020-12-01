# Problem: https://adventofcode.com/2020/day/1
# Given a list of positive integers, find the two entries that sum to 2020
# Return the product of those two integers

class ReportRepair
  attr_reader :report_filename

  SUM_TARGET = 2020.freeze

  def initialize(report_filename)
    @report_filename = report_filename
  end

  def run
    entries.inject(:*)
  end

  def entries
    IO.foreach(report_filename) do |left_line|
      left_addend = left_line.to_i
      next if left_addend > SUM_TARGET

      IO.foreach(report_filename) do |right_line|
        right_addend = right_line.to_i
        if left_addend + right_addend == SUM_TARGET
          return [left_addend, right_addend]
        end
      end
    end
  end
end
