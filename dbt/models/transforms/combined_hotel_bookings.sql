SELECT *
FROM {{(ref('hotel_booking_1'))}}
UNION ALL
SELECT * 
FROM {{(ref('hotel_booking_2'))}}