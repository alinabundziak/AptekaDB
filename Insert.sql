USE AptekaDB;
GO


INSERT INTO CategoryList (name, description)
VALUES
(N'Çíåáîëþþ÷³', N'Ïðåïàðàòè äëÿ çíÿòòÿ áîëþ'),
(N'Ïðîòèçàñòóäí³', N'Ë³êè â³ä çàñòóäè òà ãðèïó'),
(N'Àíòèá³îòèêè', N'Ïðåïàðàòè ïðîòè áàêòåð³àëüíèõ ³íôåêö³é'),
(N'Â³òàì³íè', N'Â³òàì³íí³ êîìïëåêñè');


INSERT INTO ManufacturerList (company_name, country, address, phone, email)
VALUES
(N'ÔàðìàËàéô', N'Óêðà¿íà', N'Êè¿â, âóë. Õðåùàòèê, 10', N'+380501112233', N'info@pharmalife.ua'),
(N'HealthCorp', N'Í³ìå÷÷èíà', N'Áåðë³í, Hauptstrasse 5', N'+49301234567', N'contact@healthcorp.de'),
(N'BioMed', N'Ïîëüùà', N'Âàðøàâà, ul. Prosta 3', N'+48551122334', N'office@biomed.pl');


INSERT INTO SupplierList (company_name, address, phone, email)
VALUES
(N'ÌåäÏîñòà÷', N'Ëüâ³â, âóë. Ãîðîäîöüêà, 50', N'+380671234567', N'sales@medpostach.ua'),
(N'GlobalMed', N'Êè¿â, âóë. Ñàãàéäà÷íîãî, 12', N'+380931112233', N'info@globalmed.com');


INSERT INTO EmployeeList (first_name, last_name, middle_name, position, phone, login, password)
VALUES
(N'²âàí', N'Ïåòðåíêî', N'²âàíîâè÷', N'Ïðîâ³çîð', N'+380501234567', N'ipetrenko', N'pass123'),
(N'Îëåíà', N'Êîâàëü', N'Ïåòð³âíà', N'Êàñèð', N'+380671112233', N'okoval', N'qwerty'),
(N'Ìàð³ÿ', N'Áîíäàð', N'²ãîð³âíà', N'Àäì³í³ñòðàòîð', N'+380931234567', N'mbondar', N'admin123');


INSERT INTO ClientList (first_name, last_name, middle_name, phone, prescription_number)
VALUES
(N'Àíäð³é', N'Ñèäîðåíêî', N'Îëåãîâè÷', N'+380631234567', N'RX-1001'),
(N'Êàòåðèíà', N'Ëèñåíêî', N'Áîðèñ³âíà', N'+380681112244', N'RX-1002'),
(N'Îêñàíà', N'Ìåëüíèê', N'Ñòåïàí³âíà', N'+380991234000', NULL);


INSERT INTO MedicineList
(name, active_substance, form, dosage, price, expiry_date, manufacturer_id, category_id, prescription_required)
VALUES
(N'Ïàðàöåòàìîë', N'Ïàðàöåòàìîë', N'Òàáëåòêè', N'500 ìã', 75.00, '2026-12-31', 1, 1, 0),
(N'²áóïðîôåí', N'²áóïðîôåí', N'Òàáëåòêè', N'200 ìã', 95.50, '2026-05-30', 2, 1, 0),
(N'Êîëäðåêñ', N'Êîìá³íàö³ÿ', N'Ïîðîøîê', N'1 ïàêåòèê', 120.00, '2025-11-30', 1, 2, 0),
(N'Àìîêñèêëàâ', N'Àìîêñèöèë³í', N'Òàáëåòêè', N'875 ìã', 320.00, '2027-01-15', 3, 3, 1),
(N'Â³òàì³í C', N'Àñêîðá³íîâà êèñëîòà', N'Òàáëåòêè øèïó÷³', N'1000 ìã', 150.00, '2027-06-01', 2, 4, 0);


INSERT INTO MedicineStock (medicine_id, quantity, location, min_quantity)
VALUES
(1, 200, N'Ñêëàä 1', 50),
(2, 150, N'Ñêëàä 1', 30),
(3, 80,  N'Ñêëàä 2', 20),
(4, 40,  N'Ñêëàä 1', 10),
(5, 300, N'Ñêëàä 2', 60);


INSERT INTO DiscountList (name, percentage, start_date, end_date, conditions)
VALUES
(N'Çèìà -10%', 10.00, '2025-12-01', '2026-02-28', N'Çíèæêà íà ïðîòèçàñòóäí³ ïðåïàðàòè'),
(N'Áîíóñ êë³ºíòà', 5.00, '2025-01-01', '2025-12-31', N'Äëÿ ïîñò³éíèõ êë³ºíò³â');


INSERT INTO OrderList (order_date, total_amount, client_id, status)
VALUES
('2025-11-01', 295.00, 1, N'Îïëà÷åíî'),
('2025-11-05', 440.00, 2, N'Îïëà÷åíî'),
('2025-11-06', 150.00, 3, N'Î÷³êóº îïëàòè');


INSERT INTO OrderItemList (order_id, medicine_id, quantity, unit_price, subtotal)
VALUES
(1, 1, 2, 75.00, 150.00),   -- 2x Ïàðàöåòàìîë
(1, 3, 1, 120.00, 120.00),  -- 1x Êîëäðåêñ
(2, 4, 1, 320.00, 320.00),  -- 1x Àìîêñèêëàâ
(2, 5, 2, 60.00, 120.00),   -- 2x Â³òàì³í C (óìîâíà ö³íà)
(3, 5, 1, 150.00, 150.00);  -- 1x Â³òàì³í C


INSERT INTO DeliveryList (delivery_date, supplier_id, employee_id, total_cost)
VALUES
('2025-10-20', 1, 3, 15000.00),
('2025-10-25', 2, 1, 8000.00);


INSERT INTO ReceiptList (receipt_number, issue_date, order_id, total, employee_id)
VALUES
(N'RC-0001', '2025-11-01', 1, 295.00, 2),
(N'RC-0002', '2025-11-05', 2, 440.00, 2);


INSERT INTO ReturnList (order_id, medicine_id, return_date, quantity, reason, refund_amount)
VALUES
(1, 1, '2025-11-03', 1, N'Ïîêóïåöü ïåðåäóìàâ', 75.00);


INSERT INTO PaymentList (order_id, payment_date, amount, method)
VALUES
(1, '2025-11-01', 295.00, N'Ãîò³âêà'),
(2, '2025-11-05', 440.00, N'Êàðòà'),
(3, '2025-11-07', 150.00, N'Ãîò³âêà');

SELECT * FROM CategoryList;
SELECT * FROM ManufacturerList;
SELECT * FROM SupplierList;
SELECT * FROM EmployeeList;
SELECT * FROM ClientList;
SELECT * FROM MedicineList;
SELECT * FROM MedicineStock;
SELECT * FROM DiscountList;
SELECT * FROM OrderList;
SELECT * FROM OrderItemList;
SELECT * FROM DeliveryList;
SELECT * FROM ReceiptList;
SELECT * FROM ReturnList;
SELECT * FROM PaymentList;
