USE AptekaDB;
GO


INSERT INTO CategoryList (name, description)
VALUES
(N'Знеболюючі', N'Препарати для зняття болю'),
(N'Протизастудні', N'Ліки від застуди та грипу'),
(N'Антибіотики', N'Препарати проти бактеріальних інфекцій'),
(N'Вітаміни', N'Вітамінні комплекси');


INSERT INTO ManufacturerList (company_name, country, address, phone, email)
VALUES
(N'ФармаЛайф', N'Україна', N'Київ, вул. Хрещатик, 10', N'+380501112233', N'info@pharmalife.ua'),
(N'HealthCorp', N'Німеччина', N'Берлін, Hauptstrasse 5', N'+49301234567', N'contact@healthcorp.de'),
(N'BioMed', N'Польща', N'Варшава, ul. Prosta 3', N'+48551122334', N'office@biomed.pl');


INSERT INTO SupplierList (company_name, address, phone, email)
VALUES
(N'МедПостач', N'Львів, вул. Городоцька, 50', N'+380671234567', N'sales@medpostach.ua'),
(N'GlobalMed', N'Київ, вул. Сагайдачного, 12', N'+380931112233', N'info@globalmed.com');


INSERT INTO EmployeeList (first_name, last_name, middle_name, position, phone, login, password)
VALUES
(N'Іван', N'Петренко', N'Іванович', N'Провізор', N'+380501234567', N'ipetrenko', N'pass123'),
(N'Олена', N'Коваль', N'Петрівна', N'Касир', N'+380671112233', N'okoval', N'qwerty'),
(N'Марія', N'Бондар', N'Ігорівна', N'Адміністратор', N'+380931234567', N'mbondar', N'admin123');


INSERT INTO ClientList (first_name, last_name, middle_name, phone, prescription_number)
VALUES
(N'Андрій', N'Сидоренко', N'Олегович', N'+380631234567', N'RX-1001'),
(N'Катерина', N'Лисенко', N'Борисівна', N'+380681112244', N'RX-1002'),
(N'Оксана', N'Мельник', N'Степанівна', N'+380991234000', NULL);


INSERT INTO MedicineList
(name, active_substance, form, dosage, price, expiry_date, manufacturer_id, category_id, prescription_required)
VALUES
(N'Парацетамол', N'Парацетамол', N'Таблетки', N'500 мг', 75.00, '2026-12-31', 1, 1, 0),
(N'Ібупрофен', N'Ібупрофен', N'Таблетки', N'200 мг', 95.50, '2026-05-30', 2, 1, 0),
(N'Колдрекс', N'Комбінація', N'Порошок', N'1 пакетик', 120.00, '2025-11-30', 1, 2, 0),
(N'Амоксиклав', N'Амоксицилін', N'Таблетки', N'875 мг', 320.00, '2027-01-15', 3, 3, 1),
(N'Вітамін C', N'Аскорбінова кислота', N'Таблетки шипучі', N'1000 мг', 150.00, '2027-06-01', 2, 4, 0);


INSERT INTO MedicineStock (medicine_id, quantity, location, min_quantity)
VALUES
(1, 200, N'Склад 1', 50),
(2, 150, N'Склад 1', 30),
(3, 80,  N'Склад 2', 20),
(4, 40,  N'Склад 1', 10),
(5, 300, N'Склад 2', 60);


INSERT INTO DiscountList (name, percentage, start_date, end_date, conditions)
VALUES
(N'Зима -10%', 10.00, '2025-12-01', '2026-02-28', N'Знижка на протизастудні препарати'),
(N'Бонус клієнта', 5.00, '2025-01-01', '2025-12-31', N'Для постійних клієнтів');


INSERT INTO OrderList (order_date, total_amount, client_id, status)
VALUES
('2025-11-01', 295.00, 1, N'Оплачено'),
('2025-11-05', 440.00, 2, N'Оплачено'),
('2025-11-06', 150.00, 3, N'Очікує оплати');


INSERT INTO OrderItemList (order_id, medicine_id, quantity, unit_price, subtotal)
VALUES
(1, 1, 2, 75.00, 150.00),   -- 2x Парацетамол
(1, 3, 1, 120.00, 120.00),  -- 1x Колдрекс
(2, 4, 1, 320.00, 320.00),  -- 1x Амоксиклав
(2, 5, 2, 60.00, 120.00),   -- 2x Вітамін C (умовна ціна)
(3, 5, 1, 150.00, 150.00);  -- 1x Вітамін C


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
(1, 1, '2025-11-03', 1, N'Покупець передумав', 75.00);


INSERT INTO PaymentList (order_id, payment_date, amount, method)
VALUES
(1, '2025-11-01', 295.00, N'Готівка'),
(2, '2025-11-05', 440.00, N'Карта'),
(3, '2025-11-07', 150.00, N'Готівка');

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
