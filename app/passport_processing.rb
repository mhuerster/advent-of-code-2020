class PassportProcessing
  attr_reader :batch_filename

  PASSPORT_SEPARATOR = "\n\n".freeze
  FIELD_SEPARATOR    = ":".freeze

  BIRTH_YEAR      = 'byr'.freeze
  ISSUE_YEAR      = 'iyr'.freeze
  EXPIRATION_YEAR = 'eyr'.freeze
  HEIGHT          = 'hgt'.freeze
  HAIR_COLOR      = 'hcl'.freeze
  EYE_COLOR       = 'ecl'.freeze
  PASSPORT_ID     = 'pid'.freeze
  COUNTRY_ID      = 'cid'.freeze

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
    REQUIRED_FIELDS.all? { |k| passport_data_hash(passport_string).key?(k) }
  end

  private

  # Each passport is represented as a sequence of key:value pairs separated by spaces or newlines.
  def passport_data_hash(passport_string)
    passport_string.split(/\s/).map { |field| field.split(FIELD_SEPARATOR) }.to_h
  end

  # Passports are separated by blank lines.
  def passport_strings
    File.read(batch_filename).split(PASSPORT_SEPARATOR)
  end
end
