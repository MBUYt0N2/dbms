SELECT
    event.event_id,
    event.event_name
FROM
    event
    JOIN registration ON event.event_id = registration.event_id
    JOIN participant ON registration.SRN = participant.SRN
GROUP BY
    event.event_id,
    event.event_name
HAVING
    SUM(
        CASE
            WHEN participant.gender = 'Male' THEN 1
            ELSE 0
        END
    ) > SUM(
        CASE
            WHEN participant.gender = 'Female' THEN 1
            ELSE 0
        END
    );

SELECT
    stall.name,
    item.type,
    SUM(stall_items.total_quantity)
FROM
    item
    JOIN stall_items ON item.name = stall_items.item_name
    JOIN stall ON stall_items.stall_id = stall.stall_id
GROUP BY
    stall.name,
    item.type
ORDER BY
    stall.name,
    item.type ASC;

SELECT
    participant.name,
    GROUP_CONCAT(visitor.name SEPARATOR ', ') AS vistor_list,
    COUNT(visitor.name) AS visitor_count
FROM
    participant
    left outer join visitor ON participant.SRN = visitor.SRN
GROUP BY
    participant.name
ORDER BY
    visitor_count DESC;