DELIMITER //

CREATE TRIGGER before_registration 
BEFORE INSERT ON registration 
FOR EACH ROW 
BEGIN
    DECLARE c INT DEFAULT 0;
    DECLARE d DATE;
    
    SELECT COUNT(*) INTO c 
    FROM registration 
    WHERE event_id = NEW.event_id;
    
    IF c >= 10 THEN
        SELECT date_of_conduction INTO d 
        FROM event_conduction 
        WHERE event_id = NEW.event_id;
        
        INSERT INTO event_conduction (event_id, date_of_conduction) 
        VALUES (NEW.event_id, ADDDATE(d, INTERVAL 1 DAY));
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_purchase 
BEFORE INSERT ON purchased 
FOR EACH ROW 
BEGIN
    DECLARE available_quantity INT DEFAULT 0;
    SELECT stall_items.total_quantity - SUM(purchased.quantity) INTO available_quantity
    FROM stall_items 
    LEFT JOIN purchased ON purchased.stall_id = stall_items.stall_id 
                       AND purchased.item_name = stall_items.item_name
    WHERE stall_items.stall_id = NEW.stall_id 
      AND stall_items.item_name = NEW.item_name
    GROUP BY stall_items.stall_id, stall_items.item_name;
    
    IF NEW.quantity > available_quantity THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Not enough number of requested items present in stall';
    END IF;
END //

DELIMITER ;


CREATE ROLE participant;
CREATE ROLE team_coordinator;
CREATE ROLE stall_coordinator;
CREATE ROLE fest_coordinator;

GRANT SELECT ON fest TO participant;
GRANT SELECT ON team TO participant;
GRANT SELECT ON event TO participant;
GRANT SELECT ON stall TO participant;

GRANT SELECT, INSERT, UPDATE, DELETE ON team TO team_coordinator;
GRANT SELECT, INSERT, UPDATE, DELETE ON event TO team_coordinator;

GRANT SELECT, INSERT, UPDATE, DELETE ON stall TO stall_coordinator;
GRANT SELECT, INSERT, UPDATE, DELETE ON stall_items TO stall_coordinator;
GRANT SELECT, INSERT, UPDATE, DELETE ON purchased TO stall_coordinator;

GRANT ALL PRIVILEGES ON *.* TO fest_coordinator;

SELECT user AS role_name FROM mysql.user WHERE user IN ('participant', 'team_coordinator', 'stall_coordinator', 'fest_coordinator');

SHOW GRANTS FOR 'participant';
SHOW GRANTS FOR 'team_coordinator';
SHOW GRANTS FOR 'stall_coordinator';
SHOW GRANTS FOR 'fest_coordinator';

DELIMITER ;

CREATE USER 'Alex'@'%' IDENTIFIED BY 'password_Alex';
CREATE USER 'Emily'@'%' IDENTIFIED BY 'password_Emily';
CREATE USER 'Diana'@'%' IDENTIFIED BY 'password_Diana';
CREATE USER 'Andres'@'%' IDENTIFIED BY 'password_Andres';
CREATE USER 'Bella'@'%' IDENTIFIED BY 'password_Bella';
CREATE USER 'Derik'@'%' IDENTIFIED BY 'password_Derik';

GRANT participant TO 'Alex'@'%';
GRANT participant TO 'Emily'@'%';
GRANT fest_coordinator TO 'Diana'@'%';
GRANT team_coordinator TO 'Andres'@'%';
GRANT stall_coordinator TO 'Bella'@'%';

SHOW GRANTS FOR 'Alex'@'%';
SHOW GRANTS FOR 'Emily'@'%';
SHOW GRANTS FOR 'Diana'@'%';
SHOW GRANTS FOR 'Andres'@'%';
SHOW GRANTS FOR 'Bella'@'%';
SHOW GRANTS FOR 'Derik'@'%';

