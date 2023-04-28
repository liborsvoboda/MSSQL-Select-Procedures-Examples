SELECT CONCAT('INSERT INTO dba.user_vr_vyh_polozky (doklad,id_partnera,polozka,cena,doba_naskl,moznost_odprodeje,poznamka)VALUES(\'',items.karat_id,'\',\'',items.karat_idp,'\',\'',items.karat_item_id,'\',\'',items.price,'\',\'',items.term,'\',\'',(CASE WHEN items.divest = 'ANO' THEN 1 ELSE 0 END),'\',\'',IFNULL(items.note,''),'\');') as '' 
FROM `tender_users_tenders_items` AS items,`tender_tenders` AS tender
WHERE 
tender.karat_id = items.karat_id
AND tender.exported = 0
AND tender.end_date <= NOW()
AND 1 = (SELECT tender_user.finished FROM `tender_users_tenders` AS tender_user 
WHERE tender_user.karat_id = items.karat_id
AND tender_user.karat_idp = items.karat_idp
AND tender_user.finished = 1
);

UPDATE `tender_tenders` SET `exported`=1 WHERE exported = 0 AND end_date <= DATE_SUB(now(), INTERVAL 1 MINUTE);
