BULK INSERT dbo.olist_order_reviews_dataset
FROM 'C:\Users\CHARU\Downloads\Olist Customers Dataset\olist_order_reviews_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);