from faker import Faker
from random import randint, choice
from datetime import datetime

class DataGenerator:
    PLATFORM_START_DATE = datetime(2015, 1, 1).strftime('%Y-%m-%d')
    NUM_OF_START_TEACHERS = 10
    AVAILABLE_PAY = [pay for pay in range(4800, 6200, 200)]
    TEACHER_EXCEL_ROWS = [
        'id', 
        'name', 
        'surname', 
        'age', 
        'email', 
        'phone_number', 
        'hire_date', 
        'pay', 
        'bank_account_number'
    ]
    AVAILABLE_CLASS_HOURS = [12, 14, 16, 18]

    def __init__(self, seed=0) -> None:
        self.fake = Faker(seed)

    def generate_teachers(self, num_teachers=3):
        teachers = []
        for _ in range(num_teachers):
            id = self.fake.uuid4()
            name = self.fake.first_name()
            surname = self.fake.last_name()
            age = self.fake.random_int(min=18, max=70)
            email = self.__custom_email(name, surname)
            phone_number = self.__generate_phone_number(self.fake)
            pay = choice(self.AVAILABLE_PAY)
            bank_account_number = self.__generate_bank_account_number(self.fake)
        
            if self.NUM_OF_START_TEACHERS:
                hire_date = self.PLATFORM_START_DATE
                self.NUM_OF_START_TEACHERS -= 1
            else:
                hire_date = self.__generate_random_date_between(
                    start_date=datetime(2015, 1, 1), 
                    end_date=datetime(2018, 12, 31), 
                    fake=self.fake
                )
            teachers.append(
                (id, name, surname, age, email, phone_number, hire_date, pay, bank_account_number)
            )
        return teachers
    
    def __generate_random_date_between(self, start_date, end_date):
        random_date = self.fake.date_between(start_date=start_date, end_date=end_date)
        return random_date.strftime('%Y-%m-%d')

    def __generate_phone_number(self):
        first_digit = str(randint(1, 9))
        phone_number = self.fake.msisdn()[1:9]
        return first_digit + phone_number

    def __generate_bank_account_number(self):
        return 'PL' + str(self.fake.random_number(digits=26, fix_len=True))

    def __custom_email(cls, name, surname):
        email_username = f"{name.lower()}.{surname.lower()}"
        email = f"{email_username}@wiseway.com"
        return email