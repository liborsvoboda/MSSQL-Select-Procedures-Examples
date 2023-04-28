CREATE DEFINER=`web.tvd.cz`@`%` PROCEDURE `sr_check_tender_user`(IN `in_karat_idp` VARCHAR(8), IN `in_company` VARCHAR(255), IN `in_email` VARCHAR(255))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN
    IF ( SELECT NOT EXISTS (SELECT 1 FROM tender_users WHERE karat_idp =  in_karat_idp ) ) THEN 
		INSERT INTO tender_users (karat_idp,company_name,email)VALUES(in_karat_idp,in_company,in_email);
    END IF; 
END