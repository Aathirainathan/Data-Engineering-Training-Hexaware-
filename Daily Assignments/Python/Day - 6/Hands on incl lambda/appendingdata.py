import csv 
filepath='myfiles.csv'
with open(filepath,'a',newline="") as file:
    csvwriter=csv.writer(file)
    data=[[7,"annrna",20,3],
         [7,"emmlla",20,1],
        [7,"shmdmvore",21,4]]
    csvwriter.writerows(data)
    print("myprogramisdone")