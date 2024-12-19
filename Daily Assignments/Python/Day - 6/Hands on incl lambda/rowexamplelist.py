import csv

with open('Myfile.csv', 'r') as csvfile:
    csvread =csv.reader(csvfile, delimiter = ',')
    
    #for loop
    for row in csvread:
        print(row)
        print(row[0])
        print(row [0], row[1], row[2])