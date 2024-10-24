import csv
from DataGenerator import TableDataGenerator
from pathlib import Path
import json
from typing import Generator


def save_to_csv(
        data_generator: Generator[tuple, None, None]|Generator[tuple[tuple], None, None], 
        num_rows: int,
        header: list[str]|list[list[str]], 
        filename: Path|list[Path]) -> None:
    try:
        if isinstance(filename, list):
            with open(filename[0], mode='w', newline='') as file_1:
                with open(filename[1], mode='w', newline='') as file_2:
                    with open(filename[2], mode='w', newline='') as file_3:
                        writer_1 = csv.writer(file_1)
                        writer_2 = csv.writer(file_2)
                        writer_3 = csv.writer(file_3)
                        writer_1.writerow(header[0])
                        writer_2.writerow(header[1])
                        writer_3.writerow(header[2])
                        for data in data_generator(num_rows):
                            writer_1.writerow(data[0])
                            writer_2.writerow(data[1])
                            writer_3.writerow(data[2])
                
        with open(filename, mode='w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(header)
            for data in data_generator(num_rows):
                writer.writerow(data)

    except Exception as e:
        Exception(f"Error while saving to {filename}: {e}")
    else:
        print(f"Data successfully saved to {filename}")


def load_json_data(filepath: Path) -> dict:
    try:
        with open(filepath, 'r') as file:
            return json.load(file)
    except Exception as e:
        Exception(f"Error while loading {filepath}: {e}")


DATA_DIRECTORY = Path('data')
TABLE_STRUCTURES = load_json_data(DATA_DIRECTORY / 'table_structures.json')

def save_table_data(table_name, table_header, data_generator, num_rows):
    if isinstance(table_header, list):
        filename = [DATA_DIRECTORY / f"{name}.csv" for name in table_name]
    else: filename = DATA_DIRECTORY / f"{table_name}.csv"

    save_to_csv(data_generator, num_rows, table_header, filename)

if __name__ == "__main__":
    tdg = TableDataGenerator(seed=37)

    save_table_data(
        table_name='teacher', 
        table_header=TABLE_STRUCTURES['teacher'].keys(), 
        data_generator=tdg.generate_teachers_data, 
        num_rows=250
    )
    save_table_data(
        table_name='student', 
        table_header=TABLE_STRUCTURES['student'].keys(), 
        data_generator=tdg.generate_students_data, 
        num_rows=10_000
    )
    save_table_data(
        table_name='subject', 
        table_header=TABLE_STRUCTURES['subject'].keys(), 
        data_generator=tdg.generate_subjects_data,
        num_rows=len(tdg.get_possible_subjects())
    )
    save_table_data(
        table_name='offer', 
        table_header=TABLE_STRUCTURES['offer'].keys(), 
        data_generator=tdg.generate_offer_data,
        num_rows=250
    )
    save_table_data(
        table_name=['class', 'feedback', 'attendance'],
        table_header=[
            TABLE_STRUCTURES['class'].keys(), 
            TABLE_STRUCTURES['feedback'].keys(), 
            TABLE_STRUCTURES['attendance'].keys()
        ],
        data_generator=tdg.generate_class_feedback_attendance_data,
        num_rows=100
    )
    
    
    
            