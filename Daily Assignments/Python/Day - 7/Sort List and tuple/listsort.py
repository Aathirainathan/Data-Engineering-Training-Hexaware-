#list.sort()
#sorted()

strs = ['a', 'BB', 'zzzz', 'CCz']
print(sorted(strs))
print(sorted(strs,reverse=True))
print(sorted(strs,key=len))
print(sorted(strs,key=str.lower))

def MyFn(strs):
    
 return strs[-1]
print(sorted(strs, key=MyFn))