tuple = (1, 2, 'hi')
print(len(tuple)) ## 3
print(tuple[2]) ## hi
tuple[2] = 'bye' ## NO, tuples cannot be changed
tuple = (1, 2, 'bye') ## this works