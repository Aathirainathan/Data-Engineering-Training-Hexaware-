import csv
rows = []
filepath='Myfiles.csv'
with open(filepath, 'r',newline="") as file:
    csvreader = csv.reader(file)
    header = next(csvreader)
    for row in csvreader:
        rows.append(row)
print(header)
print(rows)

