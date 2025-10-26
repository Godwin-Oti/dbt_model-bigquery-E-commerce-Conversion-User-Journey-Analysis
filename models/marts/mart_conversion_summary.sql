-- models/marts/mart_conversion_summary.sql
SELECT
    device_category,
    traffic_medium,
    
    -- Total Performance
    COUNT(session_id) AS total_sessions,
    SUM(session_revenue) AS total_revenue,
    
    -- Key Ratios
    (SUM(is_conversion) * 100.0) / COUNT(session_id) AS conversion_rate_pct,
    (SUM(session_revenue) / NULLIF(SUM(is_conversion), 0)) AS average_order_value -- AOV

FROM {{ ref('fact_sessions') }}
GROUP BY 1, 2