CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ConsumerID INT NOT NULL,
    TransactionDate DATETIME NOT NULL,
    ProducerID INT NOT NULL,
    EnergyAmount DECIMAL(10,2) NOT NULL,
    TransactionStatus NVARCHAR(50) CHECK (TransactionStatus IN ('In Progress', 'Completed', 'Failed')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ConsumerID) REFERENCES Consumers(ConsumerID) ON DELETE CASCADE,
    FOREIGN KEY (ProducerID) REFERENCES Energy_Producers(ProducerID) ON DELETE CASCADE
);
