DELIMITER $$

CREATE FUNCTION has_sequential_chars(p_str TEXT)
RETURNS VARCHAR(5)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;

    SET len = CHAR_LENGTH(p_str);

    WHILE i < len DO
        IF ASCII(UPPER(SUBSTRING(p_str, i + 1, 1))) 
           = ASCII(UPPER(SUBSTRING(p_str, i, 1))) + 1
        THEN
            RETURN 'true';
        END IF;

        SET i = i + 1;
    END WHILE;

    RETURN 'false';
END$$

DELIMITER ;

SELECT has_sequential_chars('ABCAD');     -- true
SELECT has_sequential_chars('AOBDY');    -- false
SELECT has_sequential_chars('12345');   -- true
