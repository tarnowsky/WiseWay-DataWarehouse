START_DATE = 2000
END_DATE = 2020

# INSERT_TEMPLATE = 'insert into dbo.swieta ("data", "swieto", "wolne") values (\'%s\', \'%s\', %s);\n'
# POSSIBLE_HOLIDAYS = [
#     ('12-25', 'boze narodzenie', 1), 
#     ('01-21', 'dzien babci', 0), 
#     ('01-22', 'dzien dziadka', 0), 
#     ('12-24', 'wigilia', 0), 
#     ('05-26', 'dzien mamy', 0), 
#     ('06-01', 'dzien dziecka', 0), 
#     ('06-23', 'dzien taty', 0), 
#     ('01-01', 'nowy rok', 1), 
#     ('02-14', 'walentynki', 0),
# ]


# with open("holidays_insert.sql", "w") as f:
#     for year in range(START_DATE, END_DATE):
#         f.write(f'-- {year}\n')
#         for holiday in POSSIBLE_HOLIDAYS:
#             f.write(INSERT_TEMPLATE % (f'{year}-{holiday[0]}', holiday[1], holiday[2]))

INSERT_TEMPLATE_VAC_1 = "INSERT INTO dbo.wakacje VALUES('%s-01-21','%s-02-24','Ferie zimowe');"
INSERT_TEMPLATE_VAC_2 = "INSERT INTO dbo.wakacje VALUES('%s-06-27','%s-08-31','Letnie wakacje');"

with open("vacations_insert.sql", "w") as f:
    for year in range(START_DATE, END_DATE):
        f.write(f'\n-- {year}\n')
        f.write(INSERT_TEMPLATE_VAC_1 % (year, year))
        f.write('\n')
        f.write(INSERT_TEMPLATE_VAC_2 % (year, year))