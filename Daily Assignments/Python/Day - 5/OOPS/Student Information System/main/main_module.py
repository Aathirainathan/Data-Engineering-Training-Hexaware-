import sys
import os

base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.append(base_dir)

from entity.student import Student
from entity.course import Course
from entity.enrollment import Enrollment
from entity.sis import SIS
from entity.teacher import Teacher
from entity.payment import Payment
from dao.sisserviceprovider import SISServiceProvider
from exception.custom_exceptions import (
    DuplicateEnrollmentException,
    CourseNotFoundException,
    StudentNotFoundException,
    TeacherNotFoundException,
    PaymentValidationException,
    InvalidStudentDataException,
    InvalidCourseDataException,
    InvalidEnrollmentDataException,
    InvalidTeacherDataException,
    InsufficientFundsException
)

def main():
    sis = SIS()

    student1 = Student(1, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890')
    student2 = Student(2, 'Jane', 'Smith', '1996-09-25', 'jane.smith@example.com', '0987654321')
    student3 = Student(3, 'Tom', 'Brown', '1997-11-30', 'tom.brown@example.com', '1122334455')
    
    course1 = Course(1, 'Mathematics', 'MATH101', 'Dr. Alice')
    course2 = Course(2, 'Physics', 'PHYS101', 'Dr. Bob')
    course3 = Course(3, 'Chemistry', 'CHEM101', 'Dr. Carol')
    
    teacher1 = Teacher(1, 'Alice', 'Johnson', 'alice.johnson@example.com')
    teacher2 = Teacher(2, 'Bob', 'Smith', 'bob.smith@example.com')
    teacher3 = Teacher(3, 'Carol', 'White', 'carol.white@example.com')

    sis.students.append(student1)
    sis.students.append(student2)
    sis.students.append(student3)
    
    sis.courses.append(course1)
    sis.courses.append(course2)
    sis.courses.append(course3)

    sis.teachers.append(teacher1)
    sis.teachers.append(teacher2)
    sis.teachers.append(teacher3)

    try:
        sis.AddEnrollment(student1, course1, '2024-01-01')
        sis.AddEnrollment(student1, course1, '2024-01-01')
    except DuplicateEnrollmentException as e:
        print(f"Error: {e}")

    try:
        sis.AddEnrollment(student2, course2, '2024-01-01')
        sis.AddEnrollment(student3, course3, '2024-01-02')
    except Exception as e:
        print(f"Error: {e}")
        
    print()

    try:
        sis.assign_course_to_teacher(course1, teacher1)
        sis.assign_course_to_teacher(course1, teacher1)
        sis.assign_course_to_teacher(course3, teacher3)
    except Exception as e:
        print(f"Error: {e}")
        
    print() 
    
    try:
        sis.add_payment(student1, 5000, '2024-01-20')
        sis.add_payment(student2, 6000, '2024-02-15')
    except Exception as e:
        print(f"Error: {e}")

    print()
    try:
        enrollments_for_john = sis.GetEnrollmentsForStudent(student1)
        print(f"\nEnrollments for {student1.first_name} {student1.last_name}:")
        for enrollment in enrollments_for_john:
            print(f'Enrolled in {enrollment.course.course_name} on {enrollment.enrollment_date}')
    except Exception as e:
        print(f"Error: {e}")
    print()

    try:
        courses_for_alice = sis.GetCoursesForTeacher(teacher1)
        print(f"\nCourses assigned to {teacher1.first_name} {teacher1.last_name}:")
        for course in courses_for_alice:
            print(course.course_name)
    except Exception as e:
        print(f"Error: {e}")
    print()

    try:
        non_existent_student = Student(4, 'Mike', 'Jones', '1998-12-01', 'mike.jones@example.com', '9999999999')
        sis.AddEnrollment(non_existent_student, course1, '2024-01-01')
    except StudentNotFoundException as e:
        print(f"Error: {e}")
    print()

    try:
        non_existent_teacher = Teacher(4, 'Nina', 'Green', 'nina.green@example.com')
        sis.assign_course_to_teacher(course1, non_existent_teacher)
    except TeacherNotFoundException as e:
        print(f"Error: {e}")
        
    

if __name__ == '__main__':
    main()
