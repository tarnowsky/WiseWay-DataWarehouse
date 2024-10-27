from faker import Faker
from random import randint, choice
from datetime import datetime
from typing import Generator


class DataGenerator:
    def __init__(self, start_date: datetime, end_date: datetime, seed=0) -> None:
        self.fake = Faker(seed)
        self.start_date = start_date
        self.end_date = end_date
    
    def _generate_random_date_between(self) -> str:
        random_date = self.fake.date_between(start_date=self.start_date, end_date=self.end_date)
        return random_date.strftime('%Y-%m-%d')

    def _generate_random_date_time(self) -> str:
        available_hours = [
            '14:00:00',
            '16:00:00',
            '18:00:00',
        ]
        return self._generate_random_date_between() + ' ' + choice(available_hours)

    def _generate_phone_number(self) -> str:
        first_digit = str(randint(1, 9))
        phone_number = self.fake.msisdn()[1:9]
        return first_digit + phone_number

    def _generate_bank_account_number(self) -> str:
        return 'PL' + str(self.fake.random_number(digits=26, fix_len=True))

    def _custom_email(self, name: str, surname: str) -> str:
        email_username = f"{name.lower()}.{surname.lower()}"
        email = f"{email_username}@wiseway.com"
        return email


class TableDataGenerator(DataGenerator):

    __TEACHERS_IDS = []
    __STUDENTS_IDS = []
    __SUBJECTS_IDS = []
    __OFFERS_IDS = []

    '''
    Check the num_rows parameter in .json file.
    It needs to be the same as the len of the list below.
    '''
    __POSIBLE_SUBJECTS = [
        "Matematyka",
        "Fizyka",
        "Chemia",
        "Biologia",
        "Geografia",
        "Historia",
        "Informatyka",
        "Język_polski",
        "Język_angielski",
        "Język_niemiecki",
    ]

    def __init__(self, start_date, end_date, seed=0) -> None:
        super().__init__(start_date, end_date, seed)
        self.attendance_id = 0
        self.feedback_id = 0

    def generate_teachers_data(self, num_rows: int) -> Generator[tuple,None,None]:
        PLATFORM_START_DATE = '2015-01-01'
        NUM_OF_START_TEACHERS = 10
        AVAILABLE_PAY = [pay for pay in range(4800, 6200, 200)]

        for i in range(num_rows):
            id = i + 1
            name = self.fake.first_name()
            surname = self.fake.last_name()
            age = self.fake.random_int(min=18, max=70)
            email = self._custom_email(name, surname)
            phone_number = self._generate_phone_number()
            pay = choice(AVAILABLE_PAY)
            bank_account_number = self._generate_bank_account_number()

            if PLATFORM_START_DATE == self.start_date and NUM_OF_START_TEACHERS:
                hire_date = PLATFORM_START_DATE
                NUM_OF_START_TEACHERS -= 1
            else:
                hire_date = self._generate_random_date_between()

            self.__TEACHERS_IDS.append(id)
            yield id, name, surname, age, email, phone_number, hire_date, pay, bank_account_number

    def generate_students_data(self, num_rows: int) -> Generator[tuple, None, None]:
        for i in range(num_rows):
            id = i + 1
            name = self.fake.first_name()
            surname = self.fake.last_name()
            age = self.fake.random_int(min=18, max=70)

            self.__STUDENTS_IDS.append(id)
            yield id, name, surname, age

    def generate_subjects_data(self, num_rows: int) -> Generator[tuple, None, None]:
        if num_rows != len(self.__POSIBLE_SUBJECTS):
            raise ValueError("Number of rows in subjects table must be equal to the number of subjects.")

        for i in range(num_rows):
            subject_id = i + 1
            name = self.__POSIBLE_SUBJECTS[i]
            self.__SUBJECTS_IDS.append(subject_id)
            yield subject_id, name

    def generate_offer_data(self, num_rows: int) -> Generator[tuple, None, None]:
        for i in range(num_rows):
            offer_id = i + 1
            subject_id = choice(self.__SUBJECTS_IDS)
            teacher_id = choice(self.__TEACHERS_IDS)
            duration = self.fake.random_int(min=30, max=120, step=30)
            level = self.fake.random_int(min=1, max=3)
            self.__OFFERS_IDS.append(offer_id)
            yield offer_id, subject_id, teacher_id, level, duration

    def generate_class_feedback_attendance_data(self, num_rows: int) -> Generator[tuple[tuple], None, None]:
        for i in range(num_rows):
            class_id = i + 1
            class_data = self.generate_class_data(class_id)
            number_of_students = self.fake.random_int(min=1, max=5)
            attendance_data, present_students = self.generate_attendance_data(class_id, number_of_students)
            feedback_data = self.generate_feedback_data(class_id, present_students)
            yield class_data, feedback_data, attendance_data

    def generate_class_data(self, class_id: int) -> tuple:
        offer_id = choice(self.__OFFERS_IDS)
        student_id = choice(self.__STUDENTS_IDS)
        date = self._generate_random_date_time()
        return class_id, offer_id, student_id, date

    def generate_feedback_data(self, class_id: int, number_of_students: int) -> list[tuple]:
        feedback_records = []
        for _ in range(number_of_students):
            self.feedback_id += 1
            feedback_id = self.feedback_id
            feedback = self.fake.random_int(min=1, max=5)
            feedback_records.append((feedback_id, class_id, feedback))
        return feedback_records

    def generate_attendance_data(self, class_id: int, number_of_students: int) -> list[tuple]:
        attendance_records = []
        present_students = number_of_students
        for _ in range(number_of_students):
            self.attendance_id += 1
            attendance_id = self.attendance_id
            present = self.fake.boolean()
            present_students -= 1 if not present else 0
            attendance_records.append((attendance_id, class_id, present))
        return attendance_records, present_students
    
    def get_possible_subjects(self):
        return self.__POSIBLE_SUBJECTS
    
