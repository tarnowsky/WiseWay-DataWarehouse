import csv
from DataGenerator import TableDataGenerator
from pathlib import Path
import json


def save_to_csv(data: list[tuple], rows: list[str], filename: Path) -> None:
    try:
        with open(filename, mode='w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(rows)
            writer.writerows(data)
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


if __name__ == "__main__":
    tdg = TableDataGenerator(seed=37)

    save_to_csv(
        tdg.generate_teachers_data(3), 
        TABLE_STRUCTURES['teacher'], 
        DATA_DIRECTORY/'teachers_excel.csv'
    )
    pass