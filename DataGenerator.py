from faker import Faker
from random import randint, choice
from datetime import datetime

class DataGenerator:
    def __init__(self, seed=0) -> None:
        self.fake = Faker(seed)
    
    def generate_random_date_between(self, start_date: datetime, end_date: datetime) -> str:
        random_date = self.fake.date_between(start_date=start_date, end_date=end_date)
        return random_date.strftime('%Y-%m-%d')

    def generate_phone_number(self) -> str:
        first_digit = str(randint(1, 9))
        phone_number = self.fake.msisdn()[1:9]
        return first_digit + phone_number

    def generate_bank_account_number(self) -> str:
        return 'PL' + str(self.fake.random_number(digits=26, fix_len=True))

    def custom_email(self, name: str, surname: str) -> str:
        email_username = f"{name.lower()}.{surname.lower()}"
        email = f"{email_username}@wiseway.com"
        return email

class TableDataGenerator(DataGenerator):
    def __init__(self, seed=0) -> None:
        super().__init__(seed)

    def generate_teachers_data(self, num_rows: int) -> list[tuple[str, str, str, int, str, str, str, int, str]]:
        PLATFORM_START_DATE = datetime(2015, 1, 1).strftime('%Y-%m-%d')
        NUM_OF_START_TEACHERS = 10
        AVAILABLE_PAY = [pay for pay in range(4800, 6200, 200)]

        teachers = []
        for _ in range(num_rows):
            id = self.fake.uuid4()
            name = self.fake.first_name()
            surname = self.fake.last_name()
            age = self.fake.random_int(min=18, max=70)
            email = self.custom_email(name, surname)
            phone_number = self.generate_phone_number()
            pay = choice(AVAILABLE_PAY)
            bank_account_number = self.generate_bank_account_number()
        
            if NUM_OF_START_TEACHERS:
                hire_date = PLATFORM_START_DATE
                NUM_OF_START_TEACHERS -= 1
            else:
                hire_date = self.generate_random_date_between(
                    start_date=datetime(2015, 1, 1), 
                    end_date=datetime(2018, 12, 31)
                )
            teachers.append(
                (id, name, surname, age, email, phone_number, hire_date, pay, bank_account_number)
            )
        return teachers

    def generate_students_data(self, num_rows: int) -> list[tuple[str, str, str, int]]:
        students = []
        for _ in range(num_rows):
            id = self.fake.uuid4()
            name = self.fake.first_name()
            surname = self.fake.last_name()
            age = self.fake.random_int(min=18, max=70)
            students.append(
                (id, name, surname, age)
            )
        return students