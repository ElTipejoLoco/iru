.psx
.open "exe\SLPS_009.65",0x8000F800


first_hir:	equ 0x82AB
first_eng:	equ 0x824F

min_ascii:	equ 0x8140
max_ascii:	equ 0x819F ; +1 from what our actual table is

; Attempt to fix the PAUSE
.org 0x80017208
    j aria_bullshit
aria_home:
    nop

; .org 0x8004f464 ; Fix issue where it can't calculate LBA from MSF correctly.
	; ;8004f464 : BEQ     00000420 (v0), 0001bcd6 (v1), 8004f488,
	; b 0x8004f488
	
.org 0x8002b774
	addiu a0, r0, 0xFE ; Increase our allowed letter count

.org 0x8004cf20 ; Don't wipe out my space used for the font!
	nop

.org 0x80056ad4 ; Load our custom font position....
	j getFontPosition
	nop
	
.org 0x8002afb4
	addiu t0, t0, 01

org 0x8002b0e0
	j loadTwoByte1
	lbu t1, 1(t0)
	
.org 0x8002b44c
	j loadTwoByte2
	lbu t1, 1(t0)

; .org 0x800174b0
	; nop
	
.org 0x8002af9c
	j isAsciiLetter
	lbu t1, 1(t0)

.org 0x80017de4
	addiu s1, s1, 0x00
	
.org 0x80017dfc
	addiu s1, s1, 0x00

;Fix options menu text alignment by moving the block and increasing the chars to 15
.org 0x8003c340
	addiu v0, v0, 0x5F90 ; Move the base pointer for the options block to a bigger region

.org 0x8003c32c
	sll a1, v0, 03 ; Update the line length to 31 by modifying the shifting algorithm

.org 0x8003c330 ; Part 2 of above
	nop

.org 0x80017DD4
	jal do_vwf

.org 0x8007D410	
do_vwf:
	la t1, storeme	; Load up address for width table

	addiu t0, r0, max_ascii
	andi t0, t0, 0x0000FFFF
	sltu t0, a0, t0	; see if were in range of eng table...
	beq zero, t0, not_eng_vwf

	addiu t0, r0, min_ascii
	andi t0, t0, 0x0000FFFF
	sltu t0, a0, t0
	bne zero, t0, not_eng_vwf

	addi t0, a0, -0x8140	; Magic #, should be first letter we use...
	andi t0, t0, 0x00FF
	addu t1, t1, t0
	lbu t0, 1(t1)
	b done_vwf
	nop
not_eng_vwf:
	addiu t0, r0, 0x08	; Poor not ascii...
done_vwf:
	j 0x80017988
	addu s1, s1, t0
	
getFontPosition:
	lui s0, 0x8007
	ori s0, s0, 0x6A20
	j 0x80056ae4
	addu v0, s0, v0
	
isAsciiLetter:
	lw t3, 0x20(sp)
	lbu	t2,0x0(t0) ; just in case...
	beq zero, t1, isControlCode ; Jump if were 0x00XX
	andi t2, t2, 0x00FF
	slti t0, t2, 0xE0
	beq zero, t0, isControlCode ; Jump if were 0xFFXX
	nop
	addiu t1, r0, 0x81
	andi t1, t1, 0xFF
	j isAsciiDone
isControlCode:
	sll	t1,t1,0x8	
	addiu t3, t3, 1
	sw t3, 0x20(sp)
isAsciiDone:
	j 0x8002afa4
	or t0,t1,t2

loadTwoByte1:
	lbu t0, 0(t0)
	sll t1, t1, 0x08
	j 0x8002b0e8
	or t0, t1, t0
	
loadTwoByte2:
	lbu t0, 0(t0)
	sll t1, t1, 0x08
	j 0x8002b454
	or t0, t1, t0

aria_bullshit:
	; Subtract 80

	addiu a0, a0, -0x80
	andi v0, a0, 0x00ff

	; Go home
	j aria_home
	sll v0, v0, 0x03

storeme:
	.db 0x00; store width here
	
letter_widths:
	.db 0x04 ;(bad space)
	.db 0x09 ;a
	.db 0x09 ;b
	.db 0x09 ;c
	.db 0x0A ;d
	.db 0x09 ;e
	.db 0x07 ;f
	.db 0x09 ;g
	.db 0x08 ;h
	.db 0x02 ;i
	.db 0x05 ;j
	.db 0x08 ;k
	.db 0x02 ;l
	.db 0x0C ;m
	.db 0x08 ;n
	.db 0x09 ;o
	.db 0x09 ;p
	.db 0x09 ;q
	.db 0x06 ;r
	.db 0x08 ;s
	.db 0x07 ;t
	.db 0x08 ;u
	.db 0x0A ;v
	.db 0x0C ;w
	.db 0x08 ;x
	.db 0x08 ;y
	.db 0x08 ;z
	.db 0x0E ;~
	.db 0x06 ;-
	.db 0x06 ;í
	.db 0x08 ;*
	.db 0x09 ;ó-old
	.db 0x02 ;'
	.db 0x04 ;"
	.db 0x08 ;other "
	.db 0x09 ;¿
	.db 0x03 ;¡
	.db 0x09 ;ó
	.db 0x08 ;ñ
	.db 0x09 ;á
	.db 0x09 ;é
	.db 0x06 ;*VACIO*
	.db 0x09 ;*VACIO*
	.db 0x08 ;ú
	.db 0x0B ;@
	.db 0x0A ;É
	.db 0x0C ;Á
	.db 0x0A ;ARROW DOWN
	.db 0x04 ;í
	.db 0x05 ;1
	.db 0x0A ;2
	.db 0x0B ;3
	.db 0x0B ;4
	.db 0x0A ;5
	.db 0x0A ;6
	.db 0x0A ;7
	.db 0x0B ;8
	.db 0x0A ;9
	.db 0x0A ;0
	.db 0x0C ;A
	.db 0x0B ;B
	.db 0x0C ;C
	.db 0x0B ;D
	.db 0x00 ;skip me
	.db 0x0A ;E
	.db 0x0A ;F
	.db 0x0C ;G
	.db 0x0A ;H
	.db 0x02 ;I
	.db 0x09 ;J
	.db 0x0A ;K
	.db 0x0A ;L
	.db 0x0C ;M
	.db 0x0A ;N
	.db 0x0C ;O
	.db 0x0A ;P
	.db 0x0C ;Q
	.db 0x0B ;R
	.db 0x0B ;S
	.db 0x0C ;T
	.db 0x0A ;U
	.db 0x0C ;V
	.db 0x0E ;W
	.db 0x0B ;X
	.db 0x0A ;Y
	.db 0x0A ;Z
	.db 0x03 ;,
	.db 0x03 ;.
	.db 0x03 ;:
	.db 0x03 ;;
	.db 0x09 ;?
	.db 0x03 ;!
	.db 0x04 ; 
	.db 0x09 ;...
	.db 0x09 ;*VACIO*
.close