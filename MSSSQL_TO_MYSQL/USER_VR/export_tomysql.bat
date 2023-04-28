@echo off
set filename=\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier_brg.exp

IF EXIST \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier_brg.exp (

for %%A in (%filename%) do (if %%~zA==0 ( echo.
) else ( 

REM -- LOAD DATA TO MYSQL DATABASE --
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Header.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Condition.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Item.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Attachment.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier.exp
\\tvd-karatapp01\vzor\_firm\USER_VR\mysql.exe -h sql.tophosting.cz -u web.tvd.cz -psewl6974 web_tvd_cz < \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier_brg.exp
)
)

REM -- LOAD FILES TO FTP PLACE --

REM -- CLEANING DATA FOLDERS --

DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\*.*
EXIT

) ELSE (

DEL /Q \\tvd-karatapp01\vzor\_firm\USER_VR\DATA\*.*
EXIT
)
