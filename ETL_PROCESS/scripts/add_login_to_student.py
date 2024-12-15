import pandas as pd
import random

# Load the CSV file
df = pd.read_csv('data\\student.csv', header=None, names=['id', 'name', 'surname', 'age'])

# Function to generate login
def generate_login(row, existing_logins):
    name = row['name']
    surname = row['surname']
    while True:
        if len(surname) >= 4:
            login = name[0] + surname[:4]
        else:
            login = name[:2] + surname[:3]
        login += str(random.randint(1, 999)).zfill(3)
        if login not in existing_logins:
            existing_logins.add(login)
            return login

# Set to keep track of existing logins
existing_logins = set()

# Add the login column
df['login'] = df.apply(lambda row: generate_login(row, existing_logins), axis=1)

# Save the modified CSV file without the header
df.to_csv('student_with_login.csv', index=False, header=False)