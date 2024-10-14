-- Insert New Consumer (No transaction for this)
INSERT INTO Consumers (Name, MeterNumber, Address, PhoneNumber)
VALUES ('Jane Smith', 'MTR54321', '789 Pine St', '1234567890');

-- Capture the ConsumerID for further operations.
DECLARE @ConsumerID INT = SCOPE_IDENTITY();

-- Insert New Energy Producer (No transaction for this)
INSERT INTO Energy_Producers (ProducerName, ProducerType)
VALUES ('WindCo', 'Wind');

-- Capture the ProducerID for further operations.
DECLARE @ProducerID INT = SCOPE_IDENTITY();

-- Start Transaction for Payments, Orders, and Transactions
BEGIN TRANSACTION;

BEGIN TRY
    -- Insert Payment
    INSERT INTO Payments (ConsumerID, AmountPaid, PaymentDate)
    VALUES (@ConsumerID, 300.00, '2024-10-12 10:00:00');

    -- Capture the PaymentID for use in the Orders table.
    DECLARE @PaymentID INT = SCOPE_IDENTITY();

    -- Insert Order
    INSERT INTO Orders (PaymentID, ConsumerID, OrderDate, EnergyAmount, OrderStatus)
    VALUES (@PaymentID, @ConsumerID, '2024-10-12 10:30:00', 150.00, 'Pending');

    -- Capture the OrderID for use in the Transactions table.
    DECLARE @OrderID INT = SCOPE_IDENTITY();

    -- Insert Transaction with new Producer
    INSERT INTO Transactions (OrderID, ConsumerID, TransactionDate, ProducerID, EnergyAmount, TransactionStatus)
    VALUES (@OrderID, @ConsumerID, '2024-10-12 11:00:00', @ProducerID, 150.00, 'In Progress');

    -- Commit Transaction if everything succeeds
    COMMIT TRANSACTION;
    PRINT 'Transaction successful';

END TRY
BEGIN CATCH
    -- If any error occurs in any of the steps, rollback everything.
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred, transaction rolled back';
END CATCH;

-- Fetch and display the result using JOINs
-- Example of a query that joins Consumers, Payments, Orders, Transactions, and Energy_Producers to retrieve all the details.

SELECT 
    c.ConsumerID, 
    c.Name, 
    c.MeterNumber, 
    p.PaymentID, 
    p.AmountPaid, 
    o.OrderID, 
    o.OrderDate, 
    t.TransactionID, 
    t.TransactionDate, 
    ep.ProducerName, 
    t.EnergyAmount, 
    t.TransactionStatus
FROM Consumers c
JOIN Payments p ON c.ConsumerID = p.ConsumerID
JOIN Orders o ON p.PaymentID = o.PaymentID
JOIN Transactions t ON o.OrderID = t.OrderID
JOIN Energy_Producers ep ON t.ProducerID = ep.ProducerID
WHERE c.ConsumerID = 