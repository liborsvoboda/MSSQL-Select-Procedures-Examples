SELECT CONCAT('INSERT INTO dba.user_vr_vyh_podminky (doklad,id_partnera,id_podminky,hodnota,poznamka)VALUES(\'',conditions.karat_id,'\',\'',conditions.karat_idp,'\',\'',conditions.karat_item_id,'\',\'',conditions.value,'\',\'',conditions.note,'\')') as ''
FROM `tender_users_tenders_conditions` AS conditions,`tender_tenders` AS tender
WHERE 
tender.karat_id = conditions.karat_id
AND tender.exported = 0
AND tender.end_date <= NOW()
AND 1 = (SELECT tender_user.finished FROM `tender_users_tenders` AS tender_user 
WHERE tender_user.karat_id = conditions.karat_id
AND tender_user.karat_idp = conditions.karat_idp
AND tender_user.finished = 1
); 
