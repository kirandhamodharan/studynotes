import numpy as np
import math

# Generate some mock training data
trueWeight = np.array([1,2,3,4,5])
def generate():
    x = np.random.randn(len(trueWeight))
    y = trueWeight.dot(x) + np.random.randn()
    return (x, y)
trainingData = [generate() for i in range(1000000)]


def phi(x):
    return np.array(x)

# This is average of all individual records
def trainingLoss(w) -> float:
    loss = 0
    for x, y in trainingData:
        loss += (phi(x).dot(w) - y) **2
    averageLoss = loss / len(trainingData)
    #loss = sum((phi(x).dot(w) - y) **2 for x,y in trainingData) # This is an optimized way to write the loop
    return averageLoss

# This is average gradient of all individual records
def gradientTrainingLoss(w) -> float:
    gradient = 0
    for x, y in trainingData:
        gradient += (2 * (phi(x).dot(w) - y) * phi(x))
    gradientTrainLoss = gradient / len(trainingData)
    return gradientTrainLoss

def individualTrainingLoss(w, i) -> float:
    data = trainingData[i]
    x = data[0]
    y = data[1]
    # x, y = trainingData[i]
    return (phi(x).dot(w) - y) **2

def individualGradientTrainingLoss(w, i) -> float:
    data = trainingData[i]
    x = data[0]
    y = data[1]
    return 2 * (phi(x).dot(w) - y) * phi(x)

##########################################################################
initialWeights = np.zeros(len(trueWeight))
# Optimization algorithms

def stochasticGradientDescent(epoch):
    w = initialWeights
    numberOfUpdates = 0
    n = len(trainingData)
    for i in range(epoch):
        for j in range(n):
            tLoss = individualTrainingLoss(w, j)
            gTLoss = individualGradientTrainingLoss(w, j)
            numberOfUpdates += 1
            eta = 1 / math.sqrt(numberOfUpdates)
            w = w - eta * gTLoss
        print(f"i:{i}   w: {w}  loss:{tLoss}    gTLoss:{gTLoss}")



def gradientDescent(epoch):
    w = initialWeights
    tLoss = trainingLoss(w)
    gTLoss = gradientTrainingLoss(w)
    print(f"i:{i}   w: {w}  loss:{tLoss}    gTLoss:{gTLoss}")
    w = w - eta * gTLoss




# print(trainingLoss((1,1)))
# print(gradientTrainingLoss((1,1)))
#gradientDescent(500)
stochasticGradientDescent(500)