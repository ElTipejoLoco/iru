del cd\build.log
del cd\iru.bin
del exe\FAT.TBL
del exe\SLPS_009.65
del exe_error.txt

del cd\iru\AREA1\*.BIN
del cd\iru\AREA2\*.BIN
del cd\iru\AREA3\*.BIN
del cd\iru\AREA4\*.BIN
del cd\iru\AREA5\*.BIN
del cd\iru\AREA6\*.BIN
del cd\iru\AREA7\*.BIN
del cd\iru\AREA8\*.BIN
del cd\iru\AREA9\*.BIN

xcopy /s /q ins\* cd\iru\*

tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0000_00000038.tim graphics\TIM\ANTIM_PAK\0000_00000038.bin 05
tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0001_00000784.tim graphics\TIM\ANTIM_PAK\0001_00000784.bin 0B
tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0002_00000CF0.tim graphics\TIM\ANTIM_PAK\0002_00000CF0.bin 06
tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0003_00001540.tim graphics\TIM\ANTIM_PAK\0003_00001540.bin 02
tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0004_00001AE4.tim graphics\TIM\ANTIM_PAK\0004_00001AE4.bin 08
tools\iru_scene_compress.exe graphics\TIM\ANTIM_PAK\0005_000023C0.tim graphics\TIM\ANTIM_PAK\0005_000023C0.bin 12
tools\iru_pak_build.exe graphics\TIM\ANTIM_PAK

tools\iru_scene_compress.exe graphics\SPRITE\STAFF_ATM\STAFF.ATM.UNC graphics\SPRITE\STAFF.ATM 0A
tools\iru_scene_compress.exe graphics\TIM\TEX1_ATM\TEX1.ATM.UNC graphics\TIM\TEX1.ATM 0A

del /q cd\iru\ITEM\*
del /q cd\iru\SPRITE\*
del /q cd\iru\TIM\*
copy graphics\ITEM\* cd\iru\ITEM
copy graphics\SPRITE\* cd\iru\SPRITE
copy graphics\TIM\* cd\iru\TIM

copy exe\orig\SLPS_009.65 exe\SLPS_009.65
tools\armips.exe code\iru_vwf.asm
tools\iru_font_insert.exe graphics\font.bmp exe\SLPS_009.65 67220
echo trans\00065C08.txt >> exe_error.txt
tools\atlas exe\SLPS_009.65 trans\00065C08.txt >> exe_error.txt
echo trans\0000205C.txt >> exe_error.txt
tools\atlas exe\SLPS_009.65 trans\0000205C.txt >> exe_error.txt
echo trans\00000B90.txt >> exe_error.txt
tools\atlas exe\SLPS_009.65 trans\00000B90.txt >> exe_error.txt

tools\psximager\psxbuild.exe -v cd\iru >> cd\build.log
tools\iru_fat_tbl_update exe\orig\FAT.TBL exe\FAT.TBL cd\build.log
tools\psx-mode2.exe cd\iru.bin /FAT.TBL  exe\FAT.TBL
tools\psx-mode2.exe cd\iru.bin /SLPS_009.65 exe\SLPS_009.65