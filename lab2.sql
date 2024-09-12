INSERT INTO
    event
VALUES
    (
        "EV001",
        "Truth/Dare",
        "F-Block",
        "1",
        101,
        1000.00,
        NULL
    );

INSERT INTO
    fest
VALUES
    ("F001", "Aatma Trisha - 2023", 2023, NULL)
INSERT INTO
    team
VALUES
    ("T0001", "AT Head Team", "MNG", "F001")
UPDATE fest
SET
    head_teamID = "T0001"
WHERE
    fest_id = "F001"
INSERT INTO
    member
VALUES
    (
        "M0001",
        "Aditya Vikas",
        '2002-07-31',
        NULL,
        "T0001"
    )
INSERT INTO
    member
VALUES
    (
        "M0002",
        "N Kumar",
        '2004-01-16',
        "M0001",
        "T0001"
    )
SELECT
    *
FROM
    event
WHERE
    building LIKE "%@%\%%"
    OR building LIKE "%\%%@%";

SELECT
    fest_name,
    year,
    (year - 1997) > 25 as after_silver_jubilee
from
    fest;

SELECT
    item_name
FROM
    stall_items
WHERE
    stall_id = "S1"
EXCEPT
SELECT
    item_name
FROM
    stall_items
WHERE
    stall_id = "S9";

SELECT
    stall_id,
    item_name,
    price_per_unit * total_quantity * 0.06 AS profit
FROM
    stall_items
LIMIT
    15;

-- (x - x/2.5) * 0.1

SELECT
    *
FROM
    purchased
WHERE
    timestamp >= "2023-04-16 12:00:00"
    AND timestamp <= "2023-04-16 15:00:00";

SELECT
    *
FROM
    event
WHERE
    team_id = "T13"
    OR team_id = "T14"
    OR team_id = "T15"
ORDER BY
    price DESC
LIMIT
    5;