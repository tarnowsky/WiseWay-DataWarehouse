import csv
from DataGenerator import DataGenerator





def save_to_csv(names, rows, filename='./data/teachers.csv'):
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(rows)
        writer.writerows(names)

if __name__ == "__main__":
    dg = DataGenerator(seed=5673)
    save_to_csv(dg.generate_teachers(3), DataGenerator.TEACHER_EXCEL_ROWS)
    print(f"Names saved to teachers_excel.csv")