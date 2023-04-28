@echo off


REM -- LOAD DATA TO MYSQL DATABASE --
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier_brg.exp


REM -- LOAD FILES TO FTP PLACE --
REM ftp -s:\\tvd-karatapp01\vzor\_firm\USER_VR\ftp_script.txt

REM -- CLEANING DATA FOLDERS --
REM DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\*.*
REM DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\FILE\*.*


