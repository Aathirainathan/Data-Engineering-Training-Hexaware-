import csv
filepath='Myfiles.csv'
with open(filepath,'w',newline="") as file:#append mode 'a' not to overwrite data
    csvwriter=csv.writer(file)
    csvwriter.writerow(["Id","Name","Age","Courses_Enrolled"])
    data=[[6,"arna",20,3],
         [5,"ella",20,1],
        [4,"shore",21,4]]
    csvwriter.writerows(data)
print("writing had been completed")
    