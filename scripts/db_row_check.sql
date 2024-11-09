DELIMITER //

CREATE EVENT ensure_log_row_count
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    DECLARE row_count INT;
    DECLARE excess_rows INT;

    -- Get the current row count
    SET row_count = (SELECT COUNT(*) FROM log);

    -- Step 1: Delete excess rows if there are more than 100 rows
    IF row_count > 100 THEN
        SET excess_rows = row_count - 100;
        DELETE FROM log
        ORDER BY id DESC
        LIMIT excess_rows;
    END IF;

    -- Step 2: Insert dummy rows if there are less than 80 rows
    WHILE row_count < 80 DO
        INSERT INTO log (date, text) VALUES (now(), 'dummy');
        SET row_count = row_count + 1;
    END WHILE;
END //

DELIMITER ;
