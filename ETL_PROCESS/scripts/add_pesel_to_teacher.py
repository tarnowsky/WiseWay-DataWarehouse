import csv
import random

def generate_pesel(year_of_birth):
    current_year = 2020
    birth_year = current_year - int(year_of_birth)
    year_str = str(birth_year)[-2:]
    
    if birth_year >= 2000:
        month = random.randint(1, 12) + 20
    else:
        month = random.randint(1, 12)
    
    day = random.randint(1, 28)  # To avoid complications with different month lengths
    month_str = f"{month:02d}"
    day_str = f"{day:02d}"
    
    random_digits = ''.join([str(random.randint(0, 9)) for _ in range(5)])
    
    pesel = f"{year_str}{month_str}{day_str}{random_digits}"
    return pesel

def add_pesel_to_teacher(file_path):
    with open(file_path, mode='r', newline='') as infile:
        reader = csv.reader(infile)
        rows = list(reader)
    
    
    for row in rows:
        year_of_birth = row[3]
        pesel = generate_pesel(year_of_birth)
        row.append(pesel)
    
    with open(file_path, mode='w', newline='') as outfile:
        writer = csv.writer(outfile)
        writer.writerows(rows)

if __name__ == "__main__": 
    file_path = 'ETL_PROCESS\\sources\\teacher.csv'
    add_pesel_to_teacher(file_path)