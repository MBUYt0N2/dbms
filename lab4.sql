WITH timings AS (
    SELECT
        item_name,
        CASE
            WHEN HOUR(timestamp) < 12 THEN 'morning'
            WHEN HOUR(timestamp) >= 12
            AND HOUR(timestamp) <= 15 THEN 'afternoon'
            WHEN HOUR(timestamp) > 15 THEN 'evening'
        END AS time_of_day,
        quantity
    FROM
        purchased
)
SELECT
    item_name,
    time_of_day,
    COUNT(quantity) AS quantity
FROM
    timings
GROUP BY
    item_name,
    time_of_day
ORDER BY
    item_name,
    time_of_day ASC;

-- with t1 as (
--     select
--         registration.event_id,
--         participant.department,
--         count(participant.SRN) as dept
--     from
--         registration
--         join participant on registration.SRN = participant.SRN
--     group by
--         registration.event_id,
--         participant.department
--     order by
--         event_id,
--         dept desc;
-- )
-- select
--     event.event_id,
--     event.event_name,
-- from
--     event
--     join t1 on event.event_id = t1.event_id
-- group by
--     event.event_id;


select
    distinct(ec.event_id),
    event.event_name
from
    event_conduction ec
    join event_conduction ec1 on ec.date_of_conduction = ec1.date_of_conduction
    join event on ec.event_id = event.event_id
where
    ec1.event_id = 'E1'
    or ec.event_id = 'E1';


SELECT
    DISTINCT s.stall_id,
    s.name
FROM
    stall s
WHERE
    EXISTS (
        SELECT
            1
        FROM
            stall_items si
        WHERE
            si.stall_id = s.stall_id
            AND si.item_name LIKE '%Chicken%'
    );