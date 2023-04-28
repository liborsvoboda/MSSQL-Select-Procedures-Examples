CREATE DEFINER=`web.tvd.cz`@`%` FUNCTION `sr_random_password_string`()
	RETURNS varchar(10)
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN

DECLARE randVal VARCHAR(10);
DECLARE randVal1 VARCHAR(1);
DECLARE randCtr INT;

SET randVal = '';
SET randCtr = 10;	
	
WHILE randCtr > 0 DO
	
	IF randCtr = 10 OR randCtr = 3 OR randCtr = 1 THEN
		SET randVal1 = (SELECT LOWER(   CONV(     FLOOR(       RAND() * 36     ),   10, 36) ));
	ELSE
		SET randVal1 = (SELECT UPPER(   CONV(     FLOOR(       RAND() * 36     ),   10, 36) ));
	END IF;
	
	SET randVal = CONCAT(randVal, randVal1);		
	SET randCtr = randCtr - 1;
END WHILE;


return randVal;

END