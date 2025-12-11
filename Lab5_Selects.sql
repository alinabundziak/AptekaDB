USE AptekaDB;
GO

-- Запит 1: всі ліки з категоріями та виробниками
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

-- Запит 2: доступні ліки в аптеці (там, де stock.quantity > min_quantity)
SELECT
    ms.stock_id,
    m.name AS MedicineName,
    ms.quantity,
    ms.min_quantity,
    ms.location
FROM MedicineStock ms
JOIN MedicineList m ON ms.medicine_id = m.medicine_id
WHERE ms.quantity > ms.min_quantity;

-- Запит 3: замовлення з клієнтами та сумами
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status,
    c.first_name + N' ' + c.last_name AS ClientName,
    c.phone
FROM OrderList o
LEFT JOIN ClientList c ON o.client_id = c.client_id;

-- Запит 4: деталі замовлення (що саме купив клієнт)
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

-- Запит 5: квитанції + працівники, які їх видали
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

-- Запит 6: поставки від постачальників + працівник, який прийняв
SELECT
    d.delivery_id,
    d.delivery_date,
    d.total_cost,
    s.company_name AS SupplierName,
    e.first_name + N' ' + e.last_name AS EmployeeName
FROM DeliveryList d
LEFT JOIN SupplierList s ON d.supplier_id = s.supplier_id
LEFT JOIN EmployeeList e ON d.employee_id = e.employee_id;

-- Запит 7: повернення товару з назвами ліків і клієнтом
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