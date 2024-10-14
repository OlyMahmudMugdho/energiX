-- Insert New Consumer (No transaction for this)
INSERT INTO CONSUMERS (
    NAME,
    METERNUMBER,
    ADDRESS,
    PHONENUMBER
) VALUES (
    'Jane Smith',
    'MTR54321',
    '789 Pine St',
    '1234567890'
);

-- Capture the ConsumerID for further operations.
DECLARE
    @CONSUMERID INT = SCOPE_IDENTITY();
 
    -- Insert New Energy Producer (No transaction for this)
    INSERT     INTO ENERGY_PRODUCERS (PRODUCERNAME, PRODUCERTYPE) VALUES ('WindCo', 'Wind');
 
    -- Capture the ProducerID for further operations.
    DECLARE    @PRODUCERID INT = SCOPE_IDENTITY();
 
    -- Start Transaction for Payments, Orders, and Transactions
BEGIN
    TRANSACTION;
    BEGIN
        TRY
 -- Insert Payment
        INSERT INTO PAYMENTS (
            CONSUMERID,
            AMOUNTPAID,
            PAYMENTDATE
        ) VALUES (
            @CONSUMERID,
            300.00,
            '2024-10-12 10:00:00'
        );
 
        -- Capture the PaymentID for use in the Orders table.
        DECLARE
            @PAYMENTID INT = SCOPE_IDENTITY();
 
            -- Insert Order
            INSERT    INTO ORDERS (PAYMENTID, CONSUMERID, ORDERDATE, ENERGYAMOUNT, ORDERSTATUS) VALUES (@PAYMENTID, @CONSUMERID, '2024-10-12 10:30:00', 150.00, 'Pending');
 
            -- Capture the OrderID for use in the Transactions table.
            DECLARE   @ORDERID INT = SCOPE_IDENTITY();
 
            -- Insert Transaction with new Producer
            INSERT    INTO TRANSACTIONS (ORDERID, CONSUMERID, TRANSACTIONDATE, PRODUCERID, ENERGYAMOUNT, TRANSACTIONSTATUS) VALUES (@ORDERID, @CONSUMERID, '2024-10-12 11:00:00', @PRODUCERID, 150.00, 'In Progress');
 
            -- Commit Transaction if everything succeeds
            COMMIT    TRANSACTION;
            PRINT     'Transaction successful';
        END TRY BEGIN CATCH
 -- If any error occurs in any of the steps, rollback everything.
        ROLLBACK TRANSACTION;
        PRINT     'Error occurred, transaction rolled back';
    END CATCH;
 
        -- Fetch and display the result using JOINs
        -- Example of a query that joins Consumers, Payments, Orders, Transactions, and Energy_Producers to retrieve all the details.
        SELECT
            C.CONSUMERID,
            C.NAME,
            C.METERNUMBER,
            P.PAYMENTID,
            P.AMOUNTPAID,
            O.ORDERID,
            O.ORDERDATE,
            T.TRANSACTIONID,
            T.TRANSACTIONDATE,
            EP.PRODUCERNAME,
            T.ENERGYAMOUNT,
            T.TRANSACTIONSTATUS
        FROM
            CONSUMERS C
            JOIN PAYMENTS P
            ON C.CONSUMERID = P.CONSUMERID
            JOIN ORDERS O
            ON P.PAYMENTID = O.PAYMENTID
            JOIN TRANSACTIONS T
            ON O.ORDERID = T.ORDERID
            JOIN ENERGY_PRODUCERS EP
            ON T.PRODUCERID = EP.PRODUCERID
        WHERE
            C.CONSUMERID =