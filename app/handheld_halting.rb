class HandheldHalting
  attr_reader :input_filename

  # Only need named capture groups; intentionally ignoring others
  # rubocop:disable Lint/MixedRegexpCaptureTypes
  INSTRUCTION_MATCHER = /(?<operation>\w{3})\s(?<arg>(\+|-)\d+)/.freeze
  # rubocop:enable Lint/MixedRegexpCaptureTypes
  NOOP = 'nop'.freeze
  ACC = 'acc'.freeze
  JUMP = 'jmp'.freeze

  def initialize(input_filename)
    @input_filename = input_filename
  end

  # rubocop:disable Metrics/MethodLength
  def execute_instructions(idx = 0, acc = 0, executed = [])
    return acc if executed.include?(idx)

    executed << idx
    instruction = instructions[idx]
    case instruction[:operation]
    when NOOP
      idx += 1
    when ACC
      acc += instruction[:arg].to_i
      idx += 1
    when JUMP
      idx += instruction[:arg].to_i
    end

    execute_instructions(idx, acc, executed)
  end
  # rubocop:enable Metrics/MethodLength

  private

  def instructions
    @instructions ||= File.readlines(input_filename, chomp: true).map do |line|
      INSTRUCTION_MATCHER.match(line)
    end
  end
end
