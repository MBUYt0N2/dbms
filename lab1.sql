-- TASK 1
CREATE DATABASE university_fest;

USE university_fest;

CREATE TABLE
    fest (
        FestID INT AUTO_INCREMENT PRIMARY KEY,
        fest_name VARCHAR(100) UNIQUE,
        year INT,
        head_team_id INT,
    );

CREATE TABLE
    teams (
        team_id INT AUTO_INCREMENT PRIMARY KEY,
        team_name VARCHAR(100) NOT NULL,
        team_type ENUM ('ORG', 'MNG') DEFAULT 'ORG',
        fest_id INT,
        FOREIGN KEY (fest_id) REFERENCES fest (fest_id)
    );

ALTER TABLE fest ADD CONSTRAINT head_team FOREIGN KEY (head_team_id) REFERENCES teams (team_id);

CREATE TABLE
    members (
        mem_id INT AUTO_INCREMENT PRIMARY KEY,
        mem_name VARCHAR(100) NOT NULL,
        dob DATE,
        super_mem_id INT,
        team_id INT,
        FOREIGN KEY (team_id) REFERENCES teams (team_id),
        FOREIGN KEY (super_mem_id) REFERENCES members (mem_id)
    );

CREATE TABLE
    events (
        event_id INT AUTO_INCREMENT PRIMARY KEY,
        event_name VARCHAR(100) NOT NULL,
        building VARCHAR(100),
        floor INT,
        room_no INT,
        price DECIMAL(10, 2) CHECK (price < 1500.00),
        team_id INT,
        FOREIGN KEY (team_id) REFERENCES teams (team_id)
    );

CREATE TABLE
    event_conduction (
        event_id INT,
        date DATE,
        PRIMARY KEY (event_id, date),
        FOREIGN KEY (event_id) REFERENCES events (event_id)
    );

CREATE TABLE
    participants (
        srn INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        department VARCHAR(100) NOT NULL,
        semester INT CHECK (semester < 9),
        gender VARCHAR(100)
    );

CREATE TABLE
    visitors (
        srn INT,
        name VARCHAR(100),
        PRIMARY KEY (srn, name),
        age INT,
        gender VARCHAR(100),
        FOREIGN KEY (srn) REFERENCES participants (srn)
    );

CREATE TABLE
    registration (
        event_id INT,
        srn INT,
        PRIMARY KEY (event_id, srn),
        registration_id INT,
        FOREIGN KEY (event_id) REFERENCES events (event_id),
        FOREIGN KEY (srn) REFERENCES participants (srn)
    );

CREATE TABLE
    stalls (
        stall_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        fest_id INT,
        FOREIGN KEY (fest_id) REFERENCES fest (fest_id)
    );

CREATE TABLE
    items (
        item_name VARCHAR(100) PRIMARY KEY,
        type ENUM ('veg', 'non-veg')
    );

CREATE TABLE
    stall_items (
        stall_id INT,
        item_name VARCHAR(100),
        PRIMARY KEY (stall_id, item_name),
        price_per_unit INT NOT NULL,
        total_quantity INT,
        FOREIGN KEY (stall_id) REFERENCES stalls (stall_id),
        FOREIGN KEY (item_name) REFERENCES items (item_name)
    );

CREATE TABLE
    purchased (
        srn INT,
        stall_id INT,
        item_name VARCHAR(100),
        timestamp TIMESTAMP,
        quantity INT,
        PRIMARY KEY (srn, stall_id, item_name, timestamp),
        FOREIGN KEY (srn) REFERENCES participants (srn),
        FOREIGN KEY (stall_id) REFERENCES stalls (stall_id),
        FOREIGN KEY (item_name) REFERENCES items (item_name)
    );

-- TASK 2
ALTER TABLE participants MODIFY gender ENUM ('M', 'F', 'O') AFTER name;

ALTER TABLE stall_items MODIFY price_per_unit INT DEFAULT 50 NOT NULL;

ALTER TABLE stall_items ADD CONSTRAINT max_stocks CHECK (total_quantity < 150);

RENAME TABLE event_conduction TO event_schedule;

ALTER TABLE event_schedule MODIFY date DATE FIRST;