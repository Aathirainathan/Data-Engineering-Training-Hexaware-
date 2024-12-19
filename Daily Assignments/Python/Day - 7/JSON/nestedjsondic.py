import  json
with open('data.json')  as json_file:
    data = json.load(json_file)
    
    print(data['Courses'][0])
    print(data['Courses'][1])
    
    for i in data['Courses']:
        print("Namelist:", i['Name'])
        print("created by:", i["Created by"])