--  Calculating the Storage utilization of warehouse
SELECT w.warehouse_id, w.warehouse_name,  w.capacity_sqft, SUM(p.volume_cu_ft * i.quantity_on_hand) AS used_volume,
    ROUND(SUM(p.volume_cu_ft * i.quantity_on_hand) * 100.0 / w.capacity_sqft, 2) AS utilization_percentage,
    CASE WHEN SUM(p.volume_cu_ft * i.quantity_on_hand) * 100.0 / w.capacity_sqft > 90 THEN 'Overcapacity'
        WHEN SUM(p.volume_cu_ft * i.quantity_on_hand) * 100.0 / w.capacity_sqft > 75 THEN 'Near Capacity'
        ELSE 'Under Capacity'
    END AS capacity_status
FROM warehouses w
JOIN inventory i ON w.warehouse_id = i.warehouse_id
JOIN products p ON i.product_id = p.product_id
GROUP BY 1, 2, 3
ORDER BY utilization_percentage DESC;
