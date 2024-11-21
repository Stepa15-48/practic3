CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_deleted BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION
);

CREATE TABLE Transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type VARCHAR(10) CHECK (transaction_type IN ('income', 'expense')) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted_at DATETIME NULL,
    deleted_by INT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE NO ACTION,
    FOREIGN KEY (deleted_by) REFERENCES Users(user_id) ON DELETE SET NULL
);

INSERT INTO Users (username, password_hash, email)
VALUES 
('john_doe', 'hashed_password_1', 'john@example.com'),
('jane_smith', 'hashed_password_2', 'jane@example.com'),
('alice_johnson', 'hashed_password_3', 'alice@example.com');

INSERT INTO Categories (user_id, name)
VALUES 
(1, 'Food'),
(1, 'Transportation'),
(2, 'Entertainment'),
(2, 'Utilities'),
(3, 'Health');

INSERT INTO Transactions (user_id, category_id, amount, transaction_type)
VALUES 
(1, 1, 50.00, 'expense'),  -- John Doe spends \$50 on Food
(1, 2, 20.00, 'expense'),  -- John Doe spends \$20 on Transportation
(2, 3, 100.00, 'income'),   -- Jane Smith earns \$100 from Entertainment
(2, 4, 30.00, 'expense'),   -- Jane Samith spends \$30 on Utilities
(3, 5, 75.00, 'expense');    -- Alice Johnson spends \$75 on Health

SELECT * FROM Users;
SELECT * FROM Categories;
SELECT * FROM Transactions;