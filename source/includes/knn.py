from numpy import *
import operator

class KNearestNeighbor:
  GROUP = array([1.0, 1.1], [1.0, 1.0],
                [0.0, 0.0], [0.0, 0.1])

  LABELS = ['A', 'A', 'B', 'B']

  def createDataSet():
    return GROUP, LABELS

  def classify0(inX, dataSet, labels, k)
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
