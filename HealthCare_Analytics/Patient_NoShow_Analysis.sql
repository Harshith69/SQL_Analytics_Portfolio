-- Calculating patient no show percent (no show occurs when a patient fails to attend a scheduled appointment without prior notification)
WITH patient_metrics AS ( SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name, COUNT(*) AS total_appointments,
        SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_show_count,
        SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_count
    FROM patients p
    JOIN appointments a ON p.patient_id = a.patient_id
    WHERE a.appointment_date >= CURRENT_DATE - INTERVAL '1 year'
    GROUP BY p.patient_id, patient_name
    HAVING COUNT(*) >= 3)

SELECT patient_id, patient_name, total_appointments, no_show_count, completed_count,
    ROUND(no_show_count * 100.0 / total_appointments, 2) AS no_show_rate,
    CASE WHEN no_show_count * 100.0 / total_appointments > 30 THEN 'High Risk'
        WHEN no_show_count * 100.0 / total_appointments > 15 THEN 'Medium Risk'
        ELSE 'Low Risk' END AS no_show_risk
FROM patient_metrics
ORDER BY no_show_rate DESC;
