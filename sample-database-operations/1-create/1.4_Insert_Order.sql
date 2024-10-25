-- Assuming PaymentID is known (e.g., 1).
INSERT INTO Orders (PaymentID, ConsumerID, OrderDate, EnergyAmount, OrderStatus)
VALUES (1, 1, '2024-10-13 10:00:00', 200.00, 'Pending');
