-- This model aggregates the cleaned hits back up to the session level to calculate core KPIs.
-- This model is configured as a dbt table, using {{ ref('stg_ga_hits') }} as its input.
-- models/core/fact_sessions.sql
{{ config(
    materialized='table',
    cluster_by=['user_id', 'device_category'] 
) }}
---- Optimize for common reporting queries

WITH session_data AS (
    SELECT * FROM {{ ref('stg_ga_hits') }}
),

session_metrics AS (
    SELECT
        session_id,
        user_id,
        MAX(device_category) AS device_category,
        MAX(traffic_medium) AS traffic_medium,
        
        -- Business Insight 1: Conversion Funnel (Did they reach a checkout step?)
        MAX(CASE WHEN checkout_step IS NOT NULL THEN 1 ELSE 0 END) AS reached_checkout_flag,
        
        -- Business Insight 2: Transaction Success
        MAX(CASE WHEN transaction_id IS NOT NULL THEN 1 ELSE 0 END) AS is_conversion,
        
        -- Business Insight 3: Revenue
        SUM(transaction_revenue) AS session_revenue
        
    FROM session_data
    GROUP BY 1, 2
)

SELECT * FROM session_metrics