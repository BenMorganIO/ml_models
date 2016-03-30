class KNearestNeighbor
  DATA = {
    [1.0, 1.0] => 'A',
    [1.0, 1.1] => 'A',
    [0.0, 0.0] => 'B',
    [0.0, 0.1] => 'B'
  }.freeze

  attr_reader :point
  attr_accessor :distances

  def initialize(x, y)
    @distances = {}
    @point = [x, y]
  end

  def classify(k = 3)
    DATA.each { |value, label| distances[distance(value)] = label }
    top_neighbors = distances.keys.sort.first(3)
    mode distances.fetch_values(*top_neighbors)
  end

  private

  def distance(value)
    distance_x = value[0] - @point[0]
    distance_y = value[1] - @point[1]
    (distance_x ** 2 + distance_y ** 2 ) ** 0.5
  end

  def mode(values)
    counter = Hash.new(0)
    values.each { |label| counter[label] += 1 }
    counter.max { |a, b| a[1] <=> b[1] }.first
  end
end

KNearestNeighbor.new(0.0, 0.2).classify
# => 'B'
