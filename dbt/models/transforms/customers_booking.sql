SELECT 
    c.id,
    c.first_name,
    c.last_name,
    b.booking_reference,
    b.hotel,
    b.booking_date,
    b.cost
FROM {{ ref('customer') }} AS c
INNER JOIN {{ ref('combined_hotel_bookings') }} AS b
ON c.id = b.id