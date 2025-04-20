SELECT
   booking_date,
   hotel,
   cost,
   AVG(cost) OVER (
    ORDRER BY booking_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
   ) AS thirty_day_avg_cost
   cost - AVG(cost) OVER (
    ORDRER BY booking_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
   ) AS cost_diff
FROM {{ ref('customers_booking') }}