class HandyHaversacks
  CONTAINER = /\A(.*)bags\scontain.*\z/.freeze
  CONTENTS  = /(\d+)\s(\w+\s\w+)\sbag/.freeze

  attr_reader :input_filename
  attr_accessor :rules

  def initialize(input_filename)
    @input_filename = input_filename
    @rules = {}
    parse_rules
  end

  def parse_rules
    File.readlines(input_filename, chomp: true).each do |line|
      container = CONTAINER.match(line)[1].strip
      contents = line.scan(CONTENTS)

      rules[container] = {} unless rules.key?(container)
      contents.each { |count, color| rules[container][color] = count.to_i }
    end

    rules
  end

  def containers(target_color)
    direct = rules.select { |_k, v| v.key?(target_color) }.keys
    return direct if direct.empty?

    (direct + direct.map { |color| containers(color) }.flatten).uniq
  end

  def contents_count(target_color)
    contents = rules[target_color]
    return 0 if contents.empty?

    contents.reduce(0) do |sum, pair|
      color, count = pair
      sum + count + contents_count(color) * count
    end
  end
end
