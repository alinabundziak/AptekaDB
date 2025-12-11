USE AptekaDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetMedicine
    @MedicineID INT = NULL,
    @Name NVARCHAR(150) = NULL,
    @CategoryID INT = NULL,
    @PrescriptionRequired BIT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'medicine_id', 
    @SortDirection BIT = 0                    
AS
BEGIN
    SET NOCOUNT ON;

    -- Перевірка ідентифікатора, якщо заданий
    IF @MedicineID IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM MedicineList WHERE medicine_id = @MedicineID)
    BEGIN
        PRINT 'Incorrect value of @MedicineID';
        RETURN;
    END

    SELECT
        m.medicine_id,
        m.name,
        m.form,
        m.dosage,
        m.price,
        m.expiry_date,
        m.prescription_required,
        c.name AS CategoryName,
        mf.company_name AS ManufacturerName
    FROM MedicineList m
    LEFT JOIN CategoryList c ON m.category_id = c.category_id
    LEFT JOIN ManufacturerList mf ON m.manufacturer_id = mf.manufacturer_id
    WHERE
        (@MedicineID IS NULL OR m.medicine_id = @MedicineID)
        AND (@Name IS NULL OR m.name LIKE @Name + N'%')
        AND (@CategoryID IS NULL OR m.category_id = @CategoryID)
        AND (@PrescriptionRequired IS NULL OR m.prescription_required = @PrescriptionRequired)
    ORDER BY
        CASE
            WHEN @SortDirection = 0 THEN
                CASE @SortColumn
                    WHEN 'medicine_id' THEN CAST(m.medicine_id AS BIGINT)
                    WHEN 'name' THEN 0
                    WHEN 'price' THEN 0
                END
        END ASC,
        CASE
            WHEN @SortDirection = 0 AND @SortColumn = 'name' THEN m.name
        END ASC,
        CASE
            WHEN @SortDirection = 0 AND @SortColumn = 'price' THEN m.price
        END ASC,
        CASE
            WHEN @SortDirection = 1 THEN
                CASE @SortColumn
                    WHEN 'medicine_id' THEN CAST(m.medicine_id AS BIGINT)
                    WHEN 'name' THEN 0
                    WHEN 'price' THEN 0
                END
        END DESC,
        CASE
            WHEN @SortDirection = 1 AND @SortColumn = 'name' THEN m.name
        END DESC,
        CASE
            WHEN @SortDirection = 1 AND @SortColumn = 'price' THEN m.price
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

-- всі ліки, перша сторінка, 10 записів, сортування за ціною по зростанню
EXEC dbo.sp_GetMedicine
    @PageSize = 10,
    @PageNumber = 1,
    @SortColumn = 'price',
    @SortDirection = 0;

-- ліки, що починаються на "Пара"
EXEC dbo.sp_GetMedicine @Name = N'Пара';

-- тільки рецептурні, по категорії "Антибіотики" (припустимо, category_id = 3)
EXEC dbo.sp_GetMedicine @CategoryID = 3, @PrescriptionRequired = 1;

--2 

CREATE OR ALTER PROCEDURE dbo.sp_GetSupplier
    @SupplierID INT = NULL,
    @Name NVARCHAR(150) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'supplier_id', -- 'company_name'
    @SortDirection BIT = 0                    -- 0-ASC, 1-DESC
AS
BEGIN
    SET NOCOUNT ON;

    IF @SupplierID IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM SupplierList WHERE supplier_id = @SupplierID)
    BEGIN
        PRINT 'Incorrect value of @SupplierID';
        RETURN;
    END

    SELECT
        s.supplier_id,
        s.company_name,
        s.address,
        s.phone,
        s.email
    FROM SupplierList s
    WHERE
        (@SupplierID IS NULL OR s.supplier_id = @SupplierID)
        AND (@Name IS NULL OR s.company_name LIKE @Name + N'%')
    ORDER BY
        CASE
            WHEN @SortDirection = 0 THEN
                CASE @SortColumn
                    WHEN 'supplier_id' THEN CAST(s.supplier_id AS BIGINT)
                    WHEN 'company_name' THEN 0
                END
        END ASC,
        CASE
            WHEN @SortDirection = 0 AND @SortColumn = 'company_name' THEN s.company_name
        END ASC,
        CASE
            WHEN @SortDirection = 1 THEN
                CASE @SortColumn
                    WHEN 'supplier_id' THEN CAST(s.supplier_id AS BIGINT)
                    WHEN 'company_name' THEN 0
                END
        END DESC,
        CASE
            WHEN @SortDirection = 1 AND @SortColumn = 'company_name' THEN s.company_name
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO

-- всі постачальники
EXEC dbo.sp_GetSupplier;

-- постачальники, що починаються на "Мед"
EXEC dbo.sp_GetSupplier @Name = N'Мед';

-- друга сторінка, по 1 запису, сорт по назві
EXEC dbo.sp_GetSupplier
    @PageSize = 1,
    @PageNumber = 2,
    @SortColumn = 'company_name',
    @SortDirection = 0;
