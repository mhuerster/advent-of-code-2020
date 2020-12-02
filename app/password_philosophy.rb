class PasswordPhilosophy
  class Password < Struct.new(:min, :max, :target, :password); end
  attr_reader :input_filename
  MIN = /\A\d+/.freeze
  MAX = /-(\d+)/.freeze
  TARGET_LETTER = /\d\s([a-z])/.freeze
  PASSWORD = /:\s+(.*)\z/.freeze

  def initialize(input_filename = '')
    @input_filename = input_filename
  end

  def count_valid_passwords
    passwords.count { |line| valid?(line) }
  end

  def valid?(input_string)
    rules = parse(input_string)

    (rules.min..rules.max).cover?(rules.password.count(rules.target))
  end

  def parse(input_string)
    Password.new(
      min(input_string),
      max(input_string),
      target(input_string),
      password(input_string),
    )
  end

  private

  def min(input_string)
    input_string.scan(MIN).flatten.first.to_i
  end

  def max(input_string)
    input_string.scan(MAX).flatten.first.to_i
  end

  def target(input_string)
    TARGET_LETTER.match(input_string)[1]
  end

  def password(input_string)
    PASSWORD.match(input_string)[1]
  end

  def passwords
    @passwords ||= File.readlines(input_filename, chomp: true)
  end
end
