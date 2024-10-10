PROMPT PES1UG22AM155 > 

DELIMITER //
CREATE PROCEDURE getEventHeadDetails(IN eventID VARCHAR(5)) 
BEGIN
    SELECT
        event.event_name,
        event.team_id,
        org_team.team_name,
        org_member.mem_id,
        org_member.mem_name,
        fest.fest_name,
        fest.head_teamID,
        head_member.mem_name
    FROM
        event
        JOIN team AS org_team ON event.team_id = org_team.team_id
        JOIN member AS org_member ON org_team.team_id = org_member.team_id
        JOIN fest ON org_team.fest_id = fest.fest_id
        JOIN team AS head_team ON fest.head_teamID = head_team.team_id
        JOIN member AS head_member ON head_team.team_id = head_member.team_id
    WHERE
        org_member.super_memID IS NULL
        AND head_member.super_memID IS NULL
        AND event.event_id = eventID;

END //
DELIMITER ;
CALL getEventHeadDetails('E5');

DELIMITER //
CREATE PROCEDURE getVegOrNonVegItems(
    IN stall_id VARCHAR(5),
    IN type VARCHAR(10)
)
BEGIN 
    IF type = 'Veg' THEN
    SELECT
        item.name AS `Veg Items`
    FROM
        stall_items
        JOIN item ON stall_items.item_name = item.name
    WHERE
        stall_items.stall_id = stall_id
        AND item.type = 'Veg';

    ELSEIF type = 'Non-Veg' THEN
    SELECT
        item.name AS `Non Veg Items`
    FROM
        stall_items
        JOIN item ON stall_items.item_name = item.name
    WHERE
        stall_items.stall_id = stall_id
        AND item.type = 'Non-Veg';

    END IF;

END //
DELIMITER ;

CALL getVegOrNonVegItems('S1', 'Non-Veg');
CALL getVegOrNonVegItems('S1', 'Veg');

DELIMITER //
CREATE PROCEDURE getEventRevenue(IN fest_id VARCHAR(5)) 
BEGIN
    SELECT
        SUM(price) AS FestRevenue
    FROM
        registration
        JOIN event ON registration.event_id = event.event_id
        JOIN team ON event.team_id = team.team_id
    WHERE
        team.fest_id = fest_id;

END //
DELIMITER ;

CALL getEventRevenue('F101');

DELIMITER //
CREATE PROCEDURE getStallRevenue(IN fest_id VARCHAR(5)) 
BEGIN
    SELECT
        SUM(purchased.quantity * stall_items.price_per_unit) AS stallRevenue
    FROM
        purchased
        JOIN stall ON purchased.stall_id = stall.stall_id
        JOIN stall_items ON stall.stall_id = stall_items.stall_id
    WHERE
        stall.fest_id = fest_id;

    END //
DELIMITER ;

CALL getStallRevenue('F101');

DELIMITER //
CREATE FUNCTION getStallRevenue(fest_id VARCHAR(5)) 
RETURNS DECIMAL(10, 2) 
DETERMINISTIC 
BEGIN 
    DECLARE revenue DECIMAL(10, 2);

    SELECT
        SUM(purchased.quantity * stall_items.price_per_unit) INTO revenue
    FROM
        purchased
        JOIN stall ON purchased.stall_id = stall.stall_id
        JOIN stall_items ON stall.stall_id = stall_items.stall_id
    WHERE
        stall.fest_id = fest_id;

    RETURN IFNULL(revenue, 0);

END // 
DELIMITER ;

DELIMITER //
CREATE FUNCTION getEventRevenue(fest_id VARCHAR(5)) 
RETURNS DECIMAL(10, 2) 
DETERMINISTIC 
BEGIN 
DECLARE revenue DECIMAL(10, 2);

SELECT
    SUM(price) INTO revenue
FROM
    registration
    JOIN event ON registration.event_id = event.event_id
    JOIN team ON event.team_id = team.team_id
WHERE
    team.fest_id = fest_id;

RETURN IFNULL(revenue, 0);

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE festOverview(IN fest_id VARCHAR(5)) 
BEGIN
    SELECT
        fest.fest_id,
        fest.fest_name,
        fest.year,
        COUNT(DISTINCT team.team_id) AS num_teams,
        COUNT(DISTINCT event.event_id) AS num_events,
        COUNT(DISTINCT stall.stall_id) AS num_stalls,
        COUNT(DISTINCT registration.SRN) AS num_participants,
        getStallRevenue(fest.fest_id) AS stall_sales,
        getEventRevenue(fest.fest_id) AS event_revenue
    FROM
        fest
        JOIN team ON fest.fest_id = team.fest_id
        JOIN event ON team.team_id = event.team_id
        JOIN stall ON stall.fest_id = fest.fest_id
        JOIN registration ON registration.event_id = event.event_id
    WHERE
        fest.fest_id = fest_id
    GROUP BY
        fest.fest_id;

END // 
DELIMITER ;