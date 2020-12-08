class PasswordPhilosophy
  class Password < Struct.new(:pos1, :pos2, :target, :password); end
  attr_reader :input_filename

  FIRST_POSITION = /\A\d+/.freeze
  SECOND_POSITION = /-(\d+)/.freeze
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

    (rules.password[rules.pos1] == rules.target) ^ (rules.password[rules.pos2] == rules.target)
  end

  def parse(input_string)
    Password.new(
      pos1(input_string),
      pos2(input_string),
      target(input_string),
      password(input_string),
    )
  end

  private

  def pos1(input_string)
    input_string.scan(FIRST_POSITION).flatten.first.to_i - 1
  end

  def pos2(input_string)
    input_string.scan(SECOND_POSITION).flatten.first.to_i - 1
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
