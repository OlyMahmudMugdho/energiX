SELECT 
    c.ConsumerID, 
    c.Name, 
    p.PaymentID, 
    p.AmountPaid, 
    o.OrderID, 
    o.EnergyAmount, 
    o.OrderStatus, 
    t.TransactionID, 
    t.TransactionDate, 
    ep.ProducerName, 
    t.EnergyAmount AS TransactionEnergyAmount, 
    t.TransactionStatus
FROM Consumers c
JOIN Payments p ON c.ConsumerID = p.ConsumerID
JOIN Orders o ON p.PaymentID = o.PaymentID
JOIN Transactions t ON o.OrderID = t.OrderID
JOIN Energy_Producers ep ON t.ProducerID = ep.ProducerID
WHERE c.ConsumerID = 1;  -- Replace with specific ConsumerID
