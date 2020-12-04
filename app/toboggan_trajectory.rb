require 'pry'
class TobogganTrajectory
  attr_reader :map_filename, :x_increment, :y_increment
  TREE = '#'.freeze

  def initialize(x, y, map_filename = 'spec/fixtures/toboggan_trajectory/test.txt')
    @x_increment = x
    @y_increment = y
    @map_filename = map_filename
  end

  def count_trees
    map.each_with_index.reduce(0) do |tree_count, coords|
      row, x = coords

      # due to something you read about once involving arboreal genetics and biome stability, the
      # same pattern repeats to the right many times
      # modulo is for the pattern repeat
      col = (x*x_increment) % row.length

      return tree_count unless x % y_increment == 0
      row[col] == TREE ? tree_count + 1 : tree_count
    end
  end

  private

  def map
    @map ||= File.readlines(map_filename, chomp: true)
  end
end
