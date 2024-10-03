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

SELECT
    event_id,
    event_name,
    dept
FROM
    (
        SELECT
            event.event_id,
            event.event_name,
            (
                SELECT
                    participant.department
                FROM
                    participant
                    JOIN registration ON participant.SRN = registration.SRN
                WHERE
                    registration.event_id = event.event_id
                GROUP BY
                    participant.department
                ORDER BY
                    COUNT(*) DESC
                LIMIT
                    1
            ) AS dept
        FROM
            event
    ) AS subq
WHERE
    dept != 'Computer Science';

SELECT
    DISTINCT ec.event_id,
    event.event_name
FROM
    event_conduction ec
    JOIN event_conduction ec1 ON ec.date_of_conduction = ec1.date_of_conduction
    JOIN event ON ec.event_id = event.event_id
WHERE
    ec1.event_id = 'E1'
    OR ec.event_id = 'E1';

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

WITH t1 AS (
    SELECT
        event.event_id,
        event.event_name,
        COUNT(registration.registration_id) AS c
    FROM
        event
        JOIN registration ON event.event_id = registration.event_id
    GROUP BY
        event.event_id,
        registration.registration_id
)
SELECT
    event_name,
    CASE
        WHEN MAX(c) > 1 THEN 'group event'
        WHEN MAX(c) = 1 THEN 'individual event'
    END AS type_of_event,
    MAX(c) AS Max_participants,
    MIN(c) AS Min_participants
FROM
    t1
GROUP BY
    event_id
ORDER BY
    Max_participants DESC,
    Min_participants DESC;