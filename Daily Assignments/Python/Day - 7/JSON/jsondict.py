import json

with open('myfile.json') as json_file:
 data = json.load(json_file)
 print(data)
 
 print("TYPE:", type(data))

