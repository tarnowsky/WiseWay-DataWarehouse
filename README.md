# WiseWay Data Warehouse

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Built With](https://img.shields.io/badge/Built%20with-MS%20Visual%20Studio-blue)](https://visualstudio.microsoft.com/)
[![Uses](https://img.shields.io/badge/Uses-MS%20SQL%20Server-brightgreen)](https://www.microsoft.com/en-us/sql-server/)

Welcome to the WiseWay Data Warehouse project! This repository houses the core components for analyzing the wealth of data generated by WiseWay™, our imaginary online tutoring platform connecting millions of learners and tutors across countless learning opportunities.

## 🚀 Project Overview

This project provides a robust and efficient data warehouse solution, meticulously designed to transform raw operational data into actionable insights. By integrating data from various sources, including transactional databases and even external spreadsheets, we've built a foundation optimized for Multi-dimensional Online Analytical Processing (MOLAP). This allows for powerful and rapid analysis of key performance indicators across our vast ecosystem of lectures, tutors, and learners.

**Key Features:**

* **Seamless Data Integration:** ETL scripts efficiently pull and transform data from multiple MS SQL Server databases and diverse data structures like Excel spreadsheets.
* **Redundancy-Free Loading:** Intelligent scripts ensure that the data warehouse can be loaded multiple times without creating duplicate records, maintaining data integrity.
* **Optimized for MOLAP:** The data warehouse schema is specifically designed to facilitate efficient MOLAP cube creation and analysis, enabling swift exploration of multi-dimensional data.
* **Comprehensive Data Coverage:** Captures the rich history of millions of lectures, thousands of tutors and learners, and hundreds of learning opportunities within the WiseWay™ platform.
* **Built with Industry Standards:** Developed using MS Visual Studio and MS SQL Server Management Studio, leveraging familiar and powerful tools.
* **Automated Data Generation:** Includes Python scripts to generate realistic sample data for testing and development purposes.

## 🛠️ Technologies Used

* **ETL (Extract, Transform, Load):** [Specify ETL tool/language if applicable, e.g., SSIS packages, Python scripts]
* **Data Warehouse:** Microsoft SQL Server
* **Database Querying:** T-SQL, SQL
* **Development Environment:** Microsoft Visual Studio
* **Data Generation:** Python
* **Data Sources:** Microsoft SQL Server databases, Microsoft Excel spreadsheets

## 📂 Repository Structure
```
WiseWay_DataWarehouse/
├── ETL_PROCESS/
│   ├── ETL/
│   │   └── ...          # other ETL related scripts
│   └── SSIS/ETL_DataWarehouse/
│       └── ...          # SSIS packages for ETL
├── WAREHOUSE/
│   └── ...              # Data warehouse schema definitions
├── scripts/
│   └── ...              # other utility scripts
├── sources/
│   └── ...              # Location of source data files (e.g., Excel)
├── SQL/
│   └── VS22-IMPL/
│       └── WiseWarehouse/
│           └── ...      # SQL scripts for database objects
├── data/
│   └── ...              # data files
├── .DS_Store
├── .gitignore
├── DataGenerator.py
├── LICENSE
├── README.md
├── create_tables_2.sql   # SQL script for table creation
├── data-generator.py
└── requirements.txt      # Python dependencies
```

## ⚙️ Getting Started

Follow these steps to set up and run the WiseWay Data Warehouse project in your local environment.

### Prerequisites

* **Microsoft Visual Studio 2022:** Ensure you have Visual Studio 2022 with the SQL Server Integration Services (SSIS) extension installed.
* **Microsoft SQL Server:** You'll need an instance of MS SQL Server to host the data warehouse.
* **SQL Server Management Studio (SSMS):** Required for managing the SQL Server instance and executing SQL scripts.
* **Python 3.x:** Necessary to run the data generation scripts. Install the required dependencies using:
    ```bash
    pip install -r requirements.txt
    ```
* **Database Connections:** Ensure you have the necessary connection details and permissions to access the source databases and the target WiseWay data warehouse.

### Installation and Setup

1.  **Clone the Repository:**
    ```bash
    git clone [repository URL]
    cd WiseWay_DataWarehouse
    ```

2.  **Set up the Data Warehouse Database:**
    * Using SSMS, connect to your MS SQL Server instance.
    * Execute the SQL scripts located in `SQL/VS22-IMPL/WiseWarehouse/` and `create_tables_2.sql` to create the database schema and tables. Review the scripts to understand the database structure.

3.  **Configure SSIS Packages (ETL):**
    * Open the SSIS solution located in `ETL_PROCESS/SSIS/ETL_DataWarehouse/` in Visual Studio 2022.
    * Configure the Connection Managers within the SSIS packages to correctly point to your source SQL Server databases, Excel files (located within `sources/`), and the target WiseWay data warehouse.

4.  **(Optional) Generate Sample Data:**
    * Navigate to the project root directory in your terminal.
    * Run the data generation scripts:
        ```bash
        python DataGenerator.py
        python data-generator.py
        ```
    * Execute the appropriate SSIS packages (or other scripts in `ETL_PROCESS/ETL/`) to load the generated data into the data warehouse.

5.  **Run ETL Processes:**
    * Execute the configured SSIS packages in Visual Studio or deploy them to your SQL Server Integration Services catalog for scheduled execution. Ensure any other ETL scripts in `ETL_PROCESS/ETL/` are also run as needed.

## 📄 License

This project is licensed under the MIT License
