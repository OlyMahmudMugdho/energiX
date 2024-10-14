CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    PaymentID INT NOT NULL,
    ConsumerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    EnergyAmount DECIMAL(10,2) NOT NULL,
    OrderStatus NVARCHAR(50) CHECK (OrderStatus IN ('Pending', 'Completed', 'Canceled')),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID) ON DELETE CASCADE,
    FOREIGN KEY (ConsumerID) REFERENCES Consumers(ConsumerID) ON DELETE CASCADE
);
