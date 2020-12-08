class CustomCustoms
  class << self
    def run(input_filename)
      groups(input_filename).reduce(0) { |sum, group| sum + count_all_yeses(group) }
    end

    def groups(input_filename)
      # groups are separated by double newlines
      File.read(input_filename).split(/\n{2}/).map { |line| line.split(/\n/).map(&:chars) }
    end

    def count_all_yeses(group)
      group.reduce(group.first) { |all_yeses, person| all_yeses = (all_yeses & person) }.count
    end
  end
end

# Driver code

# CustomCustoms.run('spec/fixtures/custom_customs/test.txt')
# CustomCustoms.run('spec/fixtures/custom_customs/actual.txt')
