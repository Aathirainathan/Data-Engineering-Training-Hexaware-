import csv

with open('Myfile.csv', 'r') as read_object:
    csv_reader =csv.reader(read_object)
    
    list_data = list(csv_reader)
    print(list_data)