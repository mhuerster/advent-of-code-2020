class PassportProcessing
  attr_reader :batch_filename
  class Field < Struct.new(:code, :validator); end

  PASSPORT_SEPARATOR = "\n\n".freeze
  FIELD_SEPARATOR    = ":".freeze

  BIRTH_YEAR      = Field.new('byr', :valid_birth_year?).freeze
  ISSUE_YEAR      = Field.new('iyr', :valid_issue_year?).freeze
  EXPIRATION_YEAR = Field.new('eyr', :valid_expiration_year?).freeze
  HEIGHT          = Field.new('hgt', :valid_height?).freeze
  HAIR_COLOR      = Field.new('hcl', :valid_hair_color?).freeze
  EYE_COLOR       = Field.new('ecl', :valid_eye_color?).freeze
  PASSPORT_ID     = Field.new('pid', :valid_passport_id?).freeze
  COUNTRY_ID      = Field.new('cid', :valid_country_id?).freeze

  ALL_PASSPORT_FIELDS = [
    BIRTH_YEAR,
    ISSUE_YEAR,
    EXPIRATION_YEAR,
    HEIGHT,
    HAIR_COLOR,
    EYE_COLOR,
    PASSPORT_ID,
    COUNTRY_ID,
  ].freeze

  REQUIRED_FIELDS = ALL_PASSPORT_FIELDS - [COUNTRY_ID]

  def initialize(batch_filename)
    @batch_filename = batch_filename
  end

  def count_valid_passports
    passport_strings.count { |ps| valid?(ps) }
  end

  def valid?(passport_string)
    REQUIRED_FIELDS.all? do |field|
      passport_value = passport_data_hash(passport_string)[field.code]
      !passport_value.nil? && send(field.validator, passport_value)
    end
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  def valid_birth_year?(str)
    str.length == 4 && (1920..2002).cover?(str.to_i)
  end

  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  def valid_issue_year?(str)
    str.length == 4 && (2010..2020).cover?(str.to_i)
  end

  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  def valid_expiration_year?(str)
    str.length == 4 && (2020..2030).cover?(str.to_i)
  end

  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  def valid_height?(str)
    value, unit = str.scan(/(\d+)(cm|in)/).flatten
    if unit == 'cm'
      (150..193).cover?(value.to_i)
    elsif unit == 'in'
      (59..76).cover?(value.to_i)
    else
      false
    end
  end

  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  def valid_hair_color?(str)
    /#([0-9]|[a-f]){6}/.match?(str)
  end

  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  def valid_eye_color?(str)
    %w(amb blu brn gry grn hzl oth).include?(str)
  end

  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  def valid_passport_id?(str)
    /\d{9}/.match?(str) && str.length == 9
  end

  private

  # cid (Country ID) - ignored, missing or not.
  def valid_country_id?(str); true; end

  # Each passport is represented as a sequence of key:value pairs separated by spaces or newlines.
  def passport_data_hash(passport_string)
    passport_string.split(/\s/).map { |field| field.split(FIELD_SEPARATOR) }.to_h
  end

  # Passports are separated by blank lines.
  def passport_strings
    File.read(batch_filename).split(PASSPORT_SEPARATOR)
  end
end
