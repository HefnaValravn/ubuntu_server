DELIMITER //

CREATE EVENT ensure_log_row_count
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    -- Step 1: Delete excess rows if there are more than 100 rows
    WHILE (SELECT COUNT(*) FROM log) > 99 DO
        DELETE FROM log
        ORDER BY date DESC
        LIMIT 1;
    END WHILE;

    -- Step 2: Insert dummy rows if there are less than 80 rows
    WHILE (SELECT COUNT(*) FROM log) < 80 DO
        INSERT INTO log (date, text) VALUES (NOW(), 'dummy');
    END WHILE;
END //

DELIMITER ;
