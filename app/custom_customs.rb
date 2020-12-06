class CustomCustoms
  class << self
    def run(input_filename)
      lines(input_filename).map { |str| count_yeses(str) }.reduce(:+)
    end

    def lines(input_filename)
      File.read(input_filename).split("\n\n")
    end

    def count_yeses(str)
      str.chars.reject{ |char| /\W/.match?(char) }.uniq.count
    end
  end
end

# Driver code

#CustomCustoms.run('spec/fixtures/custom_customs/test.txt')
#CustomCustoms.run('spec/fixtures/custom_customs/actual.txt')
