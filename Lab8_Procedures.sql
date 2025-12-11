USE AptekaDB;
GO

-- 1. CategoryList
CREATE OR ALTER PROCEDURE dbo.sp_SetCategory
    @category_id INT = NULL OUTPUT,
    @name NVARCHAR(100) = NULL,
    @description NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    
        IF @name IS NULL OR LTRIM(RTRIM(@name)) = N''
        BEGIN
            RAISERROR(N'Назва категорії є обовʼязковою.', 16, 1);
        END

        IF @category_id IS NULL
        BEGIN
            -- вставка нового запису
            INSERT INTO CategoryList (name, description)
            VALUES (@name, @description);

            SET @category_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            
            UPDATE CategoryList
            SET
                name = ISNULL(@name, name),
                description = ISNULL(@description, description)
            WHERE category_id = @category_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Категорію з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

-- 2. ManufacturerList
CREATE OR ALTER PROCEDURE dbo.sp_SetManufacturer
    @manufacturer_id INT = NULL OUTPUT,
    @company_name NVARCHAR(150) = NULL,
    @country NVARCHAR(100) = NULL,
    @address NVARCHAR(200) = NULL,
    @phone NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @company_name IS NULL OR LTRIM(RTRIM(@company_name)) = N''
        BEGIN
            RAISERROR(N'Назва виробника є обовʼязковою.', 16, 1);
        END

        IF @manufacturer_id IS NULL
        BEGIN
            INSERT INTO ManufacturerList (company_name, country, address, phone, email)
            VALUES (@company_name, @country, @address, @phone, @email);

            SET @manufacturer_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE ManufacturerList
            SET
                company_name = ISNULL(@company_name, company_name),
                country      = ISNULL(@country, country),
                address      = ISNULL(@address, address),
                phone        = ISNULL(@phone, phone),
                email        = ISNULL(@email, email)
            WHERE manufacturer_id = @manufacturer_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Виробника з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


-- 3. SupplierList
CREATE OR ALTER PROCEDURE dbo.sp_SetSupplier
    @supplier_id INT = NULL OUTPUT,
    @company_name NVARCHAR(150) = NULL,
    @address NVARCHAR(200) = NULL,
    @phone NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @company_name IS NULL OR LTRIM(RTRIM(@company_name)) = N''
        BEGIN
            RAISERROR(N'Назва постачальника є обовʼязковою.', 16, 1);
        END

        IF @supplier_id IS NULL
        BEGIN
            INSERT INTO SupplierList (company_name, address, phone, email)
            VALUES (@company_name, @address, @phone, @email);

            SET @supplier_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE SupplierList
            SET
                company_name = ISNULL(@company_name, company_name),
                address      = ISNULL(@address, address),
                phone        = ISNULL(@phone, phone),
                email        = ISNULL(@email, email)
            WHERE supplier_id = @supplier_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Постачальника з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


-- 4. EmployeeList
CREATE OR ALTER PROCEDURE dbo.sp_SetEmployee
    @employee_id INT = NULL OUTPUT,
    @first_name NVARCHAR(50) = NULL,
    @last_name NVARCHAR(50) = NULL,
    @middle_name NVARCHAR(50) = NULL,
    @position NVARCHAR(100) = NULL,
    @phone NVARCHAR(20) = NULL,
    @login NVARCHAR(50) = NULL,
    @password NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF (@first_name IS NULL OR LTRIM(RTRIM(@first_name)) = N'')
           OR (@last_name IS NULL OR LTRIM(RTRIM(@last_name)) = N'')
        BEGIN
            RAISERROR(N'Імʼя та прізвище працівника є обовʼязковими.', 16, 1);
        END

        IF @login IS NULL OR LTRIM(RTRIM(@login)) = N''
        BEGIN
            RAISERROR(N'Логін є обовʼязковим.', 16, 1);
        END

        -- перевірка унікальності логіна
        IF EXISTS(
            SELECT 1
            FROM EmployeeList
            WHERE login = @login
              AND (@employee_id IS NULL OR employee_id <> @employee_id)
        )
        BEGIN
            RAISERROR(N'Користувач з таким логіном уже існує.', 16, 1);
        END

        IF @employee_id IS NULL
        BEGIN
            INSERT INTO EmployeeList
            (first_name, last_name, middle_name, position, phone, login, password)
            VALUES
            (@first_name, @last_name, @middle_name, @position, @phone, @login, @password);

            SET @employee_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE EmployeeList
            SET
                first_name  = ISNULL(@first_name, first_name),
                last_name   = ISNULL(@last_name, last_name),
                middle_name = ISNULL(@middle_name, middle_name),
                position    = ISNULL(@position, position),
                phone       = ISNULL(@phone, phone),
                login       = ISNULL(@login, login),
                password    = ISNULL(@password, password)
            WHERE employee_id = @employee_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Працівника з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

-- 5. ClientList
CREATE OR ALTER PROCEDURE dbo.sp_SetClient
    @client_id INT = NULL OUTPUT,
    @first_name NVARCHAR(50) = NULL,
    @last_name NVARCHAR(50) = NULL,
    @middle_name NVARCHAR(50) = NULL,
    @phone NVARCHAR(20) = NULL,
    @prescription_number NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @phone IS NULL OR LTRIM(RTRIM(@phone)) = N''
        BEGIN
            RAISERROR(N'Номер телефону клієнта є обовʼязковим.', 16, 1);
        END

        -- унікальний телефон
        IF EXISTS(
            SELECT 1
            FROM ClientList
            WHERE phone = @phone
              AND (@client_id IS NULL OR client_id <> @client_id)
        )
        BEGIN
            RAISERROR(N'Клієнт з таким телефоном уже існує.', 16, 1);
        END

        IF @client_id IS NULL
        BEGIN
            INSERT INTO ClientList
            (first_name, last_name, middle_name, phone, prescription_number)
            VALUES
            (@first_name, @last_name, @middle_name, @phone, @prescription_number);

            SET @client_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE ClientList
            SET
                first_name          = ISNULL(@first_name, first_name),
                last_name           = ISNULL(@last_name, last_name),
                middle_name         = ISNULL(@middle_name, middle_name),
                phone               = ISNULL(@phone, phone),
                prescription_number = ISNULL(@prescription_number, prescription_number)
            WHERE client_id = @client_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Клієнта з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


-- 6. MedicineList
CREATE OR ALTER PROCEDURE dbo.sp_SetMedicine
    @medicine_id INT = NULL OUTPUT,
    @name NVARCHAR(150) = NULL,
    @active_substance NVARCHAR(150) = NULL,
    @form NVARCHAR(100) = NULL,
    @dosage NVARCHAR(50) = NULL,
    @price DECIMAL(10,2) = NULL,
    @expiry_date DATE = NULL,
    @manufacturer_id INT = NULL,
    @category_id INT = NULL,
    @prescription_required BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @name IS NULL OR LTRIM(RTRIM(@name)) = N''
        BEGIN
            RAISERROR(N'Назва лікарського засобу є обовʼязковою.', 16, 1);
        END

        IF @price IS NOT NULL AND @price < 0
        BEGIN
            RAISERROR(N'Ціна не може бути відʼємною.', 16, 1);
        END

        -- перевірка виробника 
        IF @manufacturer_id IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM ManufacturerList WHERE manufacturer_id = @manufacturer_id)
        BEGIN
            RAISERROR(N'Виробника з таким ID не існує.', 16, 1);
        END

        -- перевірка категорії 
        IF @category_id IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM CategoryList WHERE category_id = @category_id)
        BEGIN
            RAISERROR(N'Категорії з таким ID не існує.', 16, 1);
        END

        IF @medicine_id IS NULL
        BEGIN
            INSERT INTO MedicineList
            (name, active_substance, form, dosage, price, expiry_date,
             manufacturer_id, category_id, prescription_required)
            VALUES
            (@name, @active_substance, @form, @dosage, @price, @expiry_date,
             @manufacturer_id, @category_id, ISNULL(@prescription_required, 0));

            SET @medicine_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE MedicineList
            SET
                name                 = ISNULL(@name, name),
                active_substance     = ISNULL(@active_substance, active_substance),
                form                 = ISNULL(@form, form),
                dosage               = ISNULL(@dosage, dosage),
                price                = ISNULL(@price, price),
                expiry_date          = ISNULL(@expiry_date, expiry_date),
                manufacturer_id      = ISNULL(@manufacturer_id, manufacturer_id),
                category_id          = ISNULL(@category_id, category_id),
                prescription_required = ISNULL(@prescription_required, prescription_required)
            WHERE medicine_id = @medicine_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Лікарського засобу з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


-- 7. MedicineStock
CREATE OR ALTER PROCEDURE dbo.sp_SetMedicineStock
    @stock_id INT = NULL OUTPUT,
    @medicine_id INT = NULL,
    @quantity INT = NULL,
    @location NVARCHAR(100) = NULL,
    @min_quantity INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @medicine_id IS NULL
        BEGIN
            RAISERROR(N'Необхідно вказати ID лікарського засобу.', 16, 1);
        END

        -- перевірка, що ліки існують
        IF NOT EXISTS (SELECT 1 FROM MedicineList WHERE medicine_id = @medicine_id)
        BEGIN
            RAISERROR(N'Лікарського засобу з таким ID не існує.', 16, 1);
        END

        IF @quantity IS NOT NULL AND @quantity < 0
        BEGIN
            RAISERROR(N'Кількість на складі не може бути відʼємною.', 16, 1);
        END

        IF @min_quantity IS NOT NULL AND @min_quantity < 0
        BEGIN
            RAISERROR(N'Мінімальна кількість не може бути відʼємною.', 16, 1);
        END

        IF @stock_id IS NULL
        BEGIN
            INSERT INTO MedicineStock
            (medicine_id, quantity, location, min_quantity)
            VALUES
            (@medicine_id, ISNULL(@quantity, 0), @location, ISNULL(@min_quantity, 0));

            SET @stock_id = SCOPE_IDENTITY();
        END
        ELSE
        BEGIN
            UPDATE MedicineStock
            SET
                medicine_id  = ISNULL(@medicine_id, medicine_id),
                quantity     = ISNULL(@quantity, quantity),
                location     = ISNULL(@location, location),
                min_quantity = ISNULL(@min_quantity, min_quantity)
            WHERE stock_id = @stock_id;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Запис складу з таким ID не знайдено.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


-- 8. Продаж лікарських засобів конкретному клієнту
-- типу клієнт купує декілька ліків там ібупрофен і панкреатин до прикладу 
-- можна реалізувати типу 
CREATE OR ALTER PROCEDURE dbo.sp_CreateSale
    @order_id INT = NULL OUTPUT,   
    @client_id INT,                
    @medicine_id INT,              
    @quantity INT                  
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
      
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.ClientList
            WHERE client_id = @client_id
        )
        BEGIN
            RAISERROR(N'Клієнта з таким ID не існує.', 16, 1);
        END

        IF NOT EXISTS (
            SELECT 1
            FROM dbo.MedicineList
            WHERE medicine_id = @medicine_id
        )
        BEGIN
            RAISERROR(N'Лікарського засобу з таким ID не існує.', 16, 1);
        END

        DECLARE @price DECIMAL(10,2);
        SELECT @price = price
        FROM dbo.MedicineList
        WHERE medicine_id = @medicine_id;

        DECLARE @currentQty INT;
        SELECT @currentQty = quantity
        FROM dbo.MedicineStock
        WHERE medicine_id = @medicine_id;

        IF @currentQty IS NULL
        BEGIN
            RAISERROR(N'На складі немає цього лікарського засобу.', 16, 1);
        END

        IF @currentQty < @quantity
        BEGIN
            RAISERROR(N'Недостатньо товару на складі.', 16, 1);
        END

        INSERT INTO dbo.OrderList (order_date, total_amount, client_id, status)
        VALUES (CAST(GETDATE() AS DATE), @quantity * @price, @client_id, N'Оплачено');

        SET @order_id = SCOPE_IDENTITY();

        INSERT INTO dbo.OrderItemList (order_id, medicine_id, quantity, unit_price, subtotal)
        VALUES (@order_id, @medicine_id, @quantity, @price, @quantity * @price);

        UPDATE dbo.MedicineStock
        SET quantity = quantity - @quantity
        WHERE medicine_id = @medicine_id;

        PRINT N'Продаж успішно виконано.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO



-- 1. CategoryList: створення та оновлення
DECLARE @NewCategoryId INT;
EXEC dbo.sp_SetCategory
    @category_id = @NewCategoryId OUTPUT,
    @name        = N'Гомеопатичні',
    @description = N'Гомеопатичні засоби';
SELECT @NewCategoryId AS NewCategoryId;
EXEC dbo.sp_SetCategory
    @category_id = @NewCategoryId,
    @description = N'Оновлений опис гомеопатичних засобів';


-- 2. ManufacturerList
DECLARE @NewManId INT;
EXEC dbo.sp_SetManufacturer
    @manufacturer_id = @NewManId OUTPUT,
    @company_name    = N'NewPharma',
    @country         = N'Україна',
    @address         = N'Київ, вул. Нова, 1',
    @phone           = N'+380501111111',
    @email           = N'info@newpharma.ua';
SELECT @NewManId AS NewManufacturerId;

EXEC dbo.sp_SetManufacturer
    @manufacturer_id = @NewManId,
    @phone           = N'+380509999999';


-- 3. SupplierList
DECLARE @NewSupplierId INT;
EXEC dbo.sp_SetSupplier
    @supplier_id  = @NewSupplierId OUTPUT,
    @company_name = N'Новий Постачальник',
    @address      = N'Львів, вул. Прикладна, 7',
    @phone        = N'+380671234000',
    @email        = N'new@supplier.ua';
SELECT @NewSupplierId AS NewSupplierId;

EXEC dbo.sp_SetSupplier
    @supplier_id = @NewSupplierId,
    @phone       = N'+380671234111';


-- 4. EmployeeList
DECLARE @NewEmpId INT;
EXEC dbo.sp_SetEmployee
    @employee_id = @NewEmpId OUTPUT,
    @first_name  = N'Степан',
    @last_name   = N'Романюк',
    @middle_name = N'Ігорович',
    @position    = N'Провізор',
    @phone       = N'+380991112233',
    @login       = N'sromanyuk',
    @password    = N'secret';
SELECT @NewEmpId AS NewEmployeeId;

EXEC dbo.sp_SetEmployee
    @employee_id = @NewEmpId,
    @position    = N'Старший провізор';


-- 5. ClientList
DECLARE @NewClientId INT;
EXEC dbo.sp_SetClient
    @client_id          = @NewClientId OUTPUT,
    @first_name         = N'Юлія',
    @last_name          = N'Кравець',
    @phone              = N'+380631110000',
    @prescription_number = N'RX-2001';
SELECT @NewClientId AS NewClientId;

EXEC dbo.sp_SetClient
    @client_id  = @NewClientId,
    @phone      = N'+380631110001';


-- 6. MedicineList
DECLARE @NewMedId INT;
EXEC dbo.sp_SetMedicine
    @medicine_id          = @NewMedId OUTPUT,
    @name                 = N'ТестЛіки 200',
    @active_substance     = N'Тестова речовина',
    @form                 = N'Таблетки',
    @dosage               = N'200 мг',
    @price                = 200.00,
    @expiry_date          = '2028-12-31',
    @manufacturer_id      = 1,
    @category_id          = 1,
    @prescription_required = 0;
SELECT @NewMedId AS NewMedicineId;

EXEC dbo.sp_SetMedicine
    @medicine_id = @NewMedId,
    @price       = 220.00;


-- 7. MedicineStock
DECLARE @NewStockId INT;
EXEC dbo.sp_SetMedicineStock
    @stock_id     = @NewStockId OUTPUT,
    @medicine_id  = 1,
    @quantity     = 50,
    @location     = N'Склад 3',
    @min_quantity = 10;
SELECT @NewStockId AS NewStockId;

EXEC dbo.sp_SetMedicineStock
    @stock_id = @NewStockId,
    @quantity = 80;

    --8
  DECLARE @SaleOrder INT;

EXEC dbo.sp_CreateSale
    @order_id = @SaleOrder OUTPUT,
    @client_id = 1,
    @medicine_id = 3,
    @quantity = 2;

SELECT @SaleOrder AS NewSaleOrderID;



SELECT * FROM CategoryList;
SELECT * FROM ManufacturerList;
SELECT * FROM SupplierList;
SELECT * FROM EmployeeList;
SELECT * FROM ClientList;
SELECT * FROM MedicineList;
SELECT * FROM MedicineStock;
SELECT * FROM OrderList;
SELECT * FROM OrderItemList;
SELECT * FROM MedicineStock;

--фіксує продажі лікарст певного клієнта 