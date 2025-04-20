SELECT 
    booking_date,
    hotel,
    COUNT(id) AS booking_count
FROM {{ ref('customers_booking') }}