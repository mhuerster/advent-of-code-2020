class TobogganTrajectory
  attr_reader :map_filename, :x_increment, :y_increment

  TREE = '#'.freeze

  def initialize(x, y, map_filename = 'spec/fixtures/toboggan_trajectory/test.txt')
    @x_increment = x
    @y_increment = y
    @map_filename = map_filename
  end

  def count_trees
    input_map.each_with_index.reduce(0) do |tree_count, coords|
      row, idx = coords

      # due to something you read about once involving arboreal genetics and biome stability, the
      # same pattern repeats to the right many times
      # modulo row length is for the pattern repeat
      x_displacement = ((idx * x_increment) / y_increment) % row.length

      if idx % y_increment == 0 && row[x_displacement] == TREE
        tree_count + 1
      else
        tree_count
      end
    end
  end

  private

  def input_map
    @input_map ||= File.readlines(map_filename, chomp: true)
  end
end

## Part 2 script ##
#
# Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal
# stop, after all.
# Determine the number of trees you would encounter if, for each of the following slopes, you
# start at the top-left corner and traverse the map all the way to the bottom:

# CANDIDATES = [
# [1, 1], #Right 1, down 1.
# [3, 1], #Right 3, down 1. (This is the slope you already checked.)
# [5, 1], #Right 5, down 1.
# [7, 1], #Right 7, down 1.
# [1, 2], #Right 1, down 2.
# ].freeze

# CANDIDATES.reduce(0) do |product, candidate|
# x, y = candidate
# instance = TobogganTrajectory.new(x, y, 'spec/fixtures/toboggan_trajectory/actual.txt')
# product * instance.count_trees
# end
