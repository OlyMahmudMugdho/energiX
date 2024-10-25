-- Assuming OrderID is known (e.g., 1) and ProducerID is known (e.g., 1).
INSERT INTO Transactions (OrderID, ConsumerID, TransactionDate, ProducerID, EnergyAmount, TransactionStatus)
VALUES (1, 1, '2024-10-13 11:00:00', 1, 200.00, 'In Progress');
