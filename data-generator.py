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

def get_data_methods(object):
    return [method for method in dir(object) if method.endswith('_data')]

if __name__ == "__main__":
    tdg = TableDataGenerator(seed=37)
    METHODS = get_data_methods(tdg)
    
    for table_name, table_attr in TABLE_STRUCTURES.items():
        method_name = next((m for m in METHODS if table_name in m), None)
        if method_name:
            method = getattr(tdg, method_name)
            save_to_csv(
                method(int(table_attr['num_rows'])),
                [*table_attr.keys()][1:], 
                DATA_DIRECTORY/f'{table_name}.csv'
            )