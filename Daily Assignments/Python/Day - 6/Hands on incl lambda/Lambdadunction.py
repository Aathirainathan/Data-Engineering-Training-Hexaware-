#lambda function(upper) to convert a string to its


string1 = 'Hexaware'
lower = lambda string: string.lower()
print(lower(string1))

is_event_list = [lambda arg=x: arg*10 for x in (1,5)]
for item in is_event_list:
    print((item()))