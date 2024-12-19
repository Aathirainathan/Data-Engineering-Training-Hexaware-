
import sys
import os

base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.append(base_dir)

from util.DatabaseManager import DatabaseManager
from util.db_conn_util import DBConnUtil




if __name__ == "__main__":
    db_manager = DatabaseManager()


    first_name = 'John'
    last_name = 'Doe'
    dob = '1995-08-15'
    email = 'john.doe@example.com'
    phone = '123-456-7890'


    db_manager.insert_student(first_name, last_name, dob, email, phone)


    course_names = ['Introduction to Programming', 'Mathematics 101']
    course_ids = []

    for course_name in course_names:

        course = db_manager.dynamic_query(
            "Courses",
            columns=["course_id"],
            conditions=[f"course_name = '{course_name}'"]
        )
        if course:
            course_ids.append(course[0][0])  

    student_id = db_manager.dynamic_query("Students", columns=["student_id"], conditions=[f"email = '{email}'"])[0][0]

    enrollment_date = "2024-01-01"  
    for course_id in course_ids:
        db_manager.insert_enrollment(student_id, course_id, enrollment_date)

    print(f"John Doe has been enrolled in the following courses: {course_names}")

  
    db_manager.close()
