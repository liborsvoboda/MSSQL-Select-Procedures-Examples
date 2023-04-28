@echo off

\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz --default-character-set=cp1250 < \\tvd-karatapp01\vzor\_firm\USER_VR\SCRIPTS\mysql_conditions.sql >\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Condition.imp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz --default-character-set=cp1250 < \\tvd-karatapp01\vzor\_firm\USER_VR\SCRIPTS\mysql_items.sql >\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Item.imp

IF EXIST \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Item.imp (

REM -- IMPORT DATA TO MSSQL DATABASE --
sqlcmd -S 192.168.6.1 -d KARAT_TVD -i \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Condition.imp
sqlcmd -S 192.168.6.1 -d KARAT_TVD -i \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Item.imp


REM -- CLEANING DATA FOLDERS --
DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\*.*
EXIT

) ELSE (
DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\*.*
EXIT
)

