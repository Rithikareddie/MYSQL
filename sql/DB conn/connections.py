import mysql.connector as SQLC

# Step 1: Database connection
db_config = SQLC.connect(
    host="localhost",
    user="root",
    password="root"
)

# Step 2: Create cursor
cursor = db_config.cursor()

print(db_config)
print(cursor)

# Step 3: Create database
create_database_query = "CREATE DATABASE IF NOT EXISTS cricket"

# Step 4: Execute query
cursor.execute(create_database_query)

print("Database created successfully!")

# Step 5: Select the database
cursor.execute("USE cricket")

# Step 6: Create players table
players_table = """
CREATE TABLE IF NOT EXISTS players(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED,
    gender ENUM('male', 'female'),
    role VARCHAR(40),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"""

cursor.execute(players_table)

print("Table created successfully!")

# Step 7: Insert data
record_insert_query = """
INSERT INTO players(name, age, gender, role)
VALUES (%s, %s, %s, %s)
"""

cursor.execute(
    record_insert_query,
    ("Rohit", 38, "male", "batting")
)

cursor.execute(
    record_insert_query,
    ("Virat", 37, "male", "batting")
)

# Save changes
db_config.commit()

print("Records inserted successfully!")

# Step 8: Get all data
cursor.execute("SELECT * FROM players")

data = cursor.fetchall()

for row in data:
    print(row)

# Step 9: Close connection
cursor.close()
db_config.close()