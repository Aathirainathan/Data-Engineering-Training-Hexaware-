strs = ['a', 'BB', 'zzzz', 'CCz']
def MyFn(strs):
    
 return strs[-1]
print(sorted(strs, key=MyFn))