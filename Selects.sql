USE AptekaDB;
GO

-- Çàïèò 1: âñ³ ë³êè ç êàòåãîð³ÿìè òà âèðîáíèêàìè
SELECT
    m.medicine_id,
    m.name AS MedicineName,
    m.form,
    m.dosage,
    m.price,
    c.name AS CategoryName,
    mf.company_name AS ManufacturerName,
    mf.country
FROM MedicineList m
LEFT JOIN CategoryList c ON m.category_id = c.category_id
LEFT JOIN ManufacturerList mf ON m.manufacturer_id = mf.manufacturer_id;

-- Çàïèò 2: äîñòóïí³ ë³êè â àïòåö³ (òàì, äå stock.quantity > min_quantity)
SELECT
    ms.stock_id,
    m.name AS MedicineName,
    ms.quantity,
    ms.min_quantity,
    ms.location
FROM MedicineStock ms
JOIN MedicineList m ON ms.medicine_id = m.medicine_id
WHERE ms.quantity > ms.min_quantity;

-- Çàïèò 3: çàìîâëåííÿ ç êë³ºíòàìè òà ñóìàìè
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status,
    c.first_name + N' ' + c.last_name AS ClientName,
    c.phone
FROM OrderList o
LEFT JOIN ClientList c ON o.client_id = c.client_id;

-- Çàïèò 4: äåòàë³ çàìîâëåííÿ (ùî ñàìå êóïèâ êë³ºíò)
SELECT
    o.order_id,
    o.order_date,
    c.first_name + N' ' + c.last_name AS ClientName,
    m.name AS MedicineName,
    oi.quantity,
    oi.unit_price,
    oi.subtotal
FROM OrderItemList oi
JOIN OrderList o ON oi.order_id = o.order_id
JOIN ClientList c ON o.client_id = c.client_id
JOIN MedicineList m ON oi.medicine_id = m.medicine_id
ORDER BY o.order_id;

-- Çàïèò 5: êâèòàíö³¿ + ïðàö³âíèêè, ÿê³ ¿õ âèäàëè
SELECT
    r.receipt_id,
    r.receipt_number,
    r.issue_date,
    r.total,
    e.first_name + N' ' + e.last_name AS EmployeeName,
    o.order_id,
    o.order_date
FROM ReceiptList r
JOIN EmployeeList e ON r.employee_id = e.employee_id
JOIN OrderList o ON r.order_id = o.order_id;

-- Çàïèò 6: ïîñòàâêè â³ä ïîñòà÷àëüíèê³â + ïðàö³âíèê, ÿêèé ïðèéíÿâ
SELECT
    d.delivery_id,
    d.delivery_date,
    d.total_cost,
    s.company_name AS SupplierName,
    e.first_name + N' ' + e.last_name AS EmployeeName
FROM DeliveryList d
LEFT JOIN SupplierList s ON d.supplier_id = s.supplier_id
LEFT JOIN EmployeeList e ON d.employee_id = e.employee_id;

-- Çàïèò 7: ïîâåðíåííÿ òîâàðó ç íàçâàìè ë³ê³â ³ êë³ºíòîì
SELECT
    r.return_id,
    r.return_date,
    r.quantity,
    r.reason,
    r.refund_amount,
    m.name AS MedicineName,
    c.first_name + N' ' + c.last_name AS ClientName
FROM ReturnList r
JOIN OrderList o ON r.order_id = o.order_id
JOIN ClientList c ON o.client_id = c.client_id
JOIN MedicineList m ON r.medicine_id = m.medicine_id;
SELECT * FROM [dbo].[MedicineStock]
--UPDATE [dbo].[MedicineStock] SET quantity = 10 WHERE stock_id = 3 
SELECT
    ms.stock_id,
    m.name AS MedicineName,
    ms.quantity,
    
    ms.location
FROM MedicineStock ms
JOIN MedicineList m ON ms.medicine_id = m.medicine_id
WHERE ms.quantity > 0;
