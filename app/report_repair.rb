# Problem: https://adventofcode.com/2020/day/1
# Given a list of positive integers, find the n entries that sum to 2020
# Return the product of those integers

class ReportRepair
  attr_reader :report_filename, :number_of_target_entries, :report_eof

  SUM_TARGET = 2020

  def initialize(report_filename, number_of_target_entries)
    @report_filename = report_filename
    @number_of_target_entries = number_of_target_entries
  end

  def run
    entries.inject(:*)
  end

  def entries
    report.combination(number_of_target_entries).find { |comb| comb.inject(:+) == SUM_TARGET }
  end

  private

  def report
    @report ||= File.readlines(report_filename).map(&:to_i)
  end
end
