import csv
from DataGenerator import DataGenerator
from DataGenerator import generate_teachers_data

from pathlib import Path

DATA_DIRECTORY = Path('data')

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


def save_to_csv(data: list[tuple], rows: list[str], filename: Path) -> None:
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(rows)
        writer.writerows(data)


if __name__ == "__main__":
    dg = DataGenerator(seed=37)

    save_to_csv(
        generate_teachers_data(3, dg), 
        DataGenerator.TEACHER_EXCEL_ROWS, 
        DATA_DIRECTORY/'teachers_excel.csv'
    )


    print(f"Names saved to teachers_excel.csv")