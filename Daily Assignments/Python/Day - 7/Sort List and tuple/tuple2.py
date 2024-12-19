## Select values <= 2
nums = [2, 8, 1, 6]
small = [ n for n in nums if n <= 2 ] ## [2, 1]
## Select fruits containing 'a', change to upper case
fruits = ['apple', 'cherry', 'banana', 'lemon']
afruits = [ s.upper() for s in fruits if 'a' in s ]

print(fruits)
print(afruits)