import csv
filepath='Myfile.csv'
with open(filepath,'w',newline="") as file:#append mode 'a' not to overwrite data
    csvwriter=csv.writer(file)
    csvwriter.writerow(["Id","Name","Age","Courses_Enrolled"])
    data=[[1,"Aparna",20,3],
         [2,"Stella",20,1],
        [3,"kishore",21,4]]
    csvwriter.writerows(data)
print("writing had been completed")
    