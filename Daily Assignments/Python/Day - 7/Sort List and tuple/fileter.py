ages = [13, 90, 17, 59, 21, 60, 5]
adults = list(filter(lambda age: age > 18, ages))
print(adults)

from functools import reduce
li =[1,2,3,4,5,6,7]

sum = reduce((lambda x,y:x+y),li)
print (sum)