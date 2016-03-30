# k-Nearest Neighbor

```ruby
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
    distance_x = value[0] - point[0]
    distance_y = value[1] - point[1]
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
```

```python
from numpy import *
import operator

GROUP = array([1.0, 1.1], [1.0, 1.0],
              [0.0, 0.0], [0.0, 0.1])

LABELS = ['A', 'A', 'B', 'B']

def classify(inX, dataSet, labels, k)
  dataSetSize = dataSet.shape[0]
  diffMat = tile(inX, (dataSetSize, 1)) - dataSet
  sqDiffMat = diffMat ** 2
  sqDistances = sqDiffMat.sum(axis = 1)
  distances = sqDistances ** 0.5
  sortedDisIndicies = distances.argsort()
  classCount={}
  for i in range(k):
    voteIlabel = labels[sortedDistIndicies[i]]
    classCount[voteIlabel] = classCount.get(voiteIlabel, 0) + 1
  sortedClassCount = sorted(classCount.iteritems(), key = operator.itemgetter(1), reverse = True)
  return sortedClassCount[0][0]

classify([0, 0], GROUP, LABELS, 3)
```

<p id="knn-equation" class="equation"></p>

<script>
  var element = document.getElementById('knn-equation');
  katex.render("d = \\sqrt{(xA_0 - xB_0)^2 + (xA_1 - xB_1)^2}", element);
</script>

**Pros**: high accuracy, insensitive to outliers, no assumptions about data.

**Cons**: computationally expensive, requires a lot of memory.

**Works with**: numeric values, nominal values.

The kNN algorithm is one of the simpliest algorithms for marchine learning.
Its primarily based off of Pythagoris' Theorem where you want to find the closest "neighbor" to a given point.

<img src="https://upload.wikimedia.org/wikipedia/commons/1/17/Hertzsprung-Russel_StarData.png"
     class="diagram"/>

The diagram to the left is called the _Hertzsprung-Russel Diagram_ and is often used for _classifying_ stars.
Lets say we're given a star and we need to classify if its either a Super Giant, Giant, Sequence, or White Dwarf.
The kNN agorithm is very effective in this.

Its basically a 3 step process (as you can see in the ruby code for the method `classify`):

1. **Find the distance of your star to all the stars.**
   This is where Pythagoris is used.
   We just iterate over each star in the dataset and find the distance.

2. **Sort the distances and take the closest stars.**
   After you've sorted the distances, you're going to which stars are the closest neighbors.
   But, how do consider "close"?
   This is where the _k_ comes in.
   You're simply going to take the closest k stars; 3 stars, 10 stars, 20 stars.

3. **Find the mode of the closest stars.**
   Once you have a list of all the closest stars, you're going to perform the mode operation.
   Remember Grade 6 when you were learning about mean, median, and mode?
   Just to jog your memory, mode was the item that appeared the most.
   Once you do that, you've got your nearest neighbor "class" :)

In the example to the right, we're given two clusters: Cluster A and Cluster B.
Given the point of `[0.0, 0.2]`, is it in the A Cluster or the B Cluster?
