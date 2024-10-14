CREATE TABLE Consumers (
    ConsumerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    MeterNumber NVARCHAR(50) UNIQUE NOT NULL,
    Address NVARCHAR(MAX),
    PhoneNumber NVARCHAR(20) UNIQUE
);