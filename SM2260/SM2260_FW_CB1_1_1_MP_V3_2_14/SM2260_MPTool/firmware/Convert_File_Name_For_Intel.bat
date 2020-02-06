@echo off
echo Please Enter Pleasant Star FW Version (Three number)(Ex:016=PSF016K):
set /p FwVer= 
echo PSF%FwVer%K


REM ===== check binary create by MPTOOL "Create Image" =====
IF EXIST cmp_result.bin del cmp_result.bin
copy ..\..\Batch\extract.exe extract.exe
copy ..\..\Batch\BinaryCompare.exe BinaryCompare.exe
extract 2260_ISP_Package.bin 2260_ISP_Package_1.bin 0 41B 0
extract 2260_ISP_Package_1.bin 2260_ISP_Package_cmp.bin 0 3 1
extract 2260_CID.bin 2260_CID_1.bin 0 1B 0
extract 2260_CID_1.bin 2260_CID_cmp.bin 0 3 1
BinaryCompare 2260_ISP_Package_cmp.bin 2260_CID_cmp.bin
del extract.exe
del BinaryCompare.exe
del 2260_ISP_Package_1.bin
del 2260_ISP_Package_cmp.bin
del 2260_CID_1.bin
del 2260_CID_cmp.bin
FOR %%F IN (cmp_result.bin) DO (
IF %%~zF LSS 1 DEL %%F
)
IF EXIST cmp_result.bin @echo.
IF EXIST cmp_result.bin @echo +++++++++++++++++++++++++++++++++++++++
IF EXIST cmp_result.bin @echo Please Create MPISP/ISP by Create Image
IF EXIST cmp_result.bin @echo +++++++++++++++++++++++++++++++++++++++
IF EXIST cmp_result.bin @echo.
IF EXIST cmp_result.bin goto END_CFG
IF NOT EXIST cmp_result.bin goto RENAME_CFG

:RENAME_CFG
ren ¡@2260_ISP_Package.bin PSF%FwVer%K.bin
echo Rename 2260_ISP_Package.bin to PSF%FwVer%K.bin
ren ¡@2260_MPISP_Package.bin PSM%FwVer%K.bin
echo Rename 2260_MPISP_Package.bin PSM%FwVer%K.bin
ren ¡@2260_RDT_Package.bin PSB%FwVer%K.bin
echo Rename 2260_RDT_Package.bin PSB%FwVer%K.bin


:END_CFG
pause