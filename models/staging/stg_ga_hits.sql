-- This model flattens the nested data into one row per user action (hit). This is the key technical demo!
-- models/staging/stg_ga_hits.sql
SELECT
    -- Unique Session/Hit ID
    CONCAT(fullVisitorId, CAST(visitStartTime AS STRING)) AS session_id,
    hits.hitNumber AS hit_number,
    
    -- Unnested & Renamed Dimensions
    fullVisitorId AS user_id,
    device.deviceCategory AS device_category,
    trafficSource.medium AS traffic_medium,
    hits.page.pageTitle AS page_title,
    
    -- Event & Transaction Data
    hits.eCommerceAction.action_type AS ecommerce_action_type,
    hits.eCommerceAction.step AS checkout_step,
    hits.transaction.transactionId AS transaction_id,
    
    -- Revenue (must be divided by 1,000,000 to get real dollars)
    hits.transaction.transactionRevenue / 1000000 AS transaction_revenue
    
-- Crucial Step: UNNEST the nested array 'hits' to create one row per action
FROM {{ source('google_analytics', 'ga_sessions_sample') }},
UNNEST(hits) AS hits

-- Filter out irrelevant hits (e.g., sessions with no tracked action)
WHERE hits.type != 'EXCEPTION'