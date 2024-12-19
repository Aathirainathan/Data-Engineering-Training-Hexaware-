import csv
rows = []
filepath='Myfiles.csv'
with open(filepath, 'r',newline="") as file:
    content = file.readlines()
    header = content[:1]
    rows = content[1:]
print(header)
print(rows)