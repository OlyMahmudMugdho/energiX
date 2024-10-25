-- Assuming ConsumerID is known (e.g., 1), otherwise fetch it using a SELECT query.
INSERT INTO Payments (ConsumerID, AmountPaid, PaymentDate)
VALUES (1, 500.00, '2024-10-13 09:00:00');
