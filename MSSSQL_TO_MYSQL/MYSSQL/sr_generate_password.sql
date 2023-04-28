CREATE DEFINER=`web.tvd.cz`@`%` PROCEDURE `sr_generate_password`()
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN  
  declare generated_password VARCHAR(10);
  declare upd_email VARCHAR(255);
  declare upd_karat_idp VARCHAR(8);    

 WHILE 0 < (SELECT COUNT(karat_idp) FROM tender_users WHERE password is NULL) DO
 
 
	 SELECT email, karat_idp
		 INTO upd_email, upd_karat_idp
		 FROM tender_users 
		 WHERE password is NULL
	 LIMIT 1;
 
    SELECT sr_random_password_string() INTO generated_password;


	 UPDATE tender_users	
	 SET   password = CONCAT(SHA1(generated_password),SHA1(upd_email))
	 		,raw_password = base64_encode(generated_password)
	 WHERE karat_idp = upd_karat_idp;

 END WHILE;
 
END