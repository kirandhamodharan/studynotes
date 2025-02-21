import numpy as np

trainingData = [
    (1, 1),
    (2, 3),
    (4, 3)
]

def phi(x):
    return np.array([1, x])

def trainingLoss(w) -> float:
    loss = 0
    for x, y in trainingData:
        loss += (phi(x).dot(w) - y) **2
    averageLoss = loss / len(trainingData)
    return averageLoss

def gradientTrainingLoss(w) -> float:
    gradient = 0
    for x, y in trainingData:
        gradient += (2 * (phi(x).dot(w) - y) * phi(x))
    gradientTrainLoss = gradient / len(trainingData)
    return gradientTrainLoss

##########################################################################
initialWeights = np.zeros(2)
# Optimization algorithm
def gradientDescent(epoch):
    w = initialWeights
    eta = 0.1
    for i in range(epoch):
        tLoss = trainingLoss(w)
        gTLoss = gradientTrainingLoss(w)
        print(f"i:{i}   w: {w}  loss:{tLoss}    gTLoss:{gTLoss}")
        w = w - eta * gTLoss




# print(trainingLoss((1,1)))
# print(gradientTrainingLoss((1,1)))
gradientDescent(1000)