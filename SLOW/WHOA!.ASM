;Name			WHOA
;Title			WHOA! Version 1.0 - Brad D Crandall, 1987
;			All rights reserved.
;------------------------------------------------------------------------------
;	WHOA!.asm	-	Brad D Crandall
;				
;
;	This program will slow a computer down so programs and
;	games can be examined closely. Designed to run in a Text
;	or graphic screen mode. To bring up WHOA!'s Menu,
;	press <Alt> <F10>.
;
;	Compiler:	MASM Version 2.0 or greater.
;	Computer:	IBM PC or Compatible running on MS-DOS or
;			PC-DOS Version 2.0 or greater. Also works
;			on IBM's Personal System/2s under DOS 3.3.
;
;	Compiling procedure:
;			masm WHOA!;
;			link WHOA!;
;			exe2bin WHOA! WHOA!.com
;
;	Notes:
;	    Care should be taken when determining what value to use for
;	    SET_MAX (located in EQUATE AREA). If the value is too large,  
;	    a hard loop may result. The value 435 if optimum for a 12-MHz
;	    machine. Slower machines will need a slightly lower value.
;
;	    Special consideration has been taken to allow WHOA to be 
;	    compatible with DOS versions earlier than 3.1, which do not
;	    support the MULTIPLEX interrupt protocol.  WHOA uses the 
;	    multiplex interrupt because it provides a broader range of 
;	    software compatibility than do the eight conventional user 
;	    interrupts.
;
;	    For older versions of DOS, WHOA uses a user interrupt
;	    (SLOW_INT) as the channel of communication to the resident
;	    portion of WHAO!. To provide full compatibility, SLOW_INT
;	    should be set to an interrupt that is not used by any of the 
;	    software you wish to use WHOA with.
;
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
;			    E Q U A T E   A R E A
;------------------------------------------------------------------------------
MULTI_INT		equ	2fh	; Multiplex used if DOS >= 3.1.
SLOW_INT		equ	60h	; Interrupt used if DOS < 3.1,
					; other possible values 60h-67h.
KEYBOARD_INT		equ	16h	; Keyboard Interrupt.
TIME_INT		equ	08h	; Time of Day Interrupt.
MULTI_HANDLE		equ	89h	; Our Unique Multiplex ID.
INSTALL_CHECK		equ	0h	; Code to check if resident.
UNINSTALL		equ	1h	; Code to uninstall WHOA!
SET_LOOP		equ	2h	; Code to set the delay loop.

STACK_SIZE		equ	100h	; Size for our Stack.

HOT_KEY			equ	7100h	; ALT F10.
STROBE_PAUSE		equ	5	; Strobe delay count setting.
SET_MIN			equ	1	; Minimum delay loop value.
SET_MAX			equ	435	; Maximum delay loop value.
TIME_PAUSE		equ	100	; Inner loop initial setting.
LOOP_DEFAULT		equ	350	; Delay default setting.

STROBE_BEGIN		equ	28	; Column coordinate for strobe.
STROBE_END		equ	37	; Column coordinate for strobe.

SCREEN_SIZE		equ	16 * 1024 / 2 ; Size in words of largest
					; screen to save.

BORDER			=	16+14	; Border color.
TEXT			=	16+15	; Text color.

DOS_CMP			equ	0310h	; DOS comparison constant.

			;--- Return Codes ---
NOT_INSTALLED		equ	0	; WHOA not installed return code.
INSTALLED		equ	0ffh	; WHOA is installed return code.
ERROR			equ	0feh	; Error occurred
OK			equ	0fdh	; No errors occurred.

;------------------------------------------------------------------------------
;			     M A C R O   A R E A
;------------------------------------------------------------------------------

			;----------------------------------------------------
			;    DISPLAY_AT parm1,parm2,parm3,parm4 - Display
			;	message on screen starting at fixed 
			;	location. Does not use DOS.
			;
			;    parm1 = X coordinate of start of message.
			;    parm2 = Y coordinate of start of message.
			;    parm3 = Color of message.
			;    parm4 = String of character to display.
			;----------------------------------------------------
DISPLAY_AT		macro	parm1,parm2,parm3,parm4
			local	label1,label2
			jmp	label2
label1			db	parm4&,0
label2:			mov	si,offset cseg:label1
			mov	cx,&parm3
			mov	ax,&parm2
			mov	di,&parm1
			call	display_at_proc
			endm

			;---------------------------------------------------
			;    DISPLAY_DOS parm1 - Display a message to the
			;	console. Uses DOS function 09h.
			;
			;    parm1 = Message to display.
			;---------------------------------------------------
DISPLAY_DOS		macro	parm1
			local	label1,label2
			jmp	label2
label1			db	parm1&,24h
label2:			mov	dx,offset cseg:label1
			mov	ah,09h
			int	21h
			endm

			;-----------------------------------------------------
			;    RESIDENT parm1 - Executes the resident portion
			;	of WHOA! Determines which interrupt to 
			;	use (multiplex or user) based on DOS version.
			;
			;    parm1 - Resident function.
			;-----------------------------------------------------
RESIDENT		macro	parm1
			local	label1,label2
			mov	al,&parm1
			cmp	cs:dos_version,DOS_CMP	; What DOS Version??
			jae	label1			; Jump if DOS >= 3.1.
			call	call_interrupt
			jmp	label2
label1:			mov	ah,MULTI_HANDLE
			int	MULTI_INT
label2:
			endm

;------------------------------------------------------------------------------
;				C O D E   A R E A
;------------------------------------------------------------------------------
cseg			segment	byte public 'code'
			assume	cs:cseg,ds:cseg
			org	100h
slowdown		proc	far
			jmp	slowdown_0010

;------------------------------------------------------------------------------
;			    T S R   D A T A   A R E A
;------------------------------------------------------------------------------
dos_version		dw	?	; Version number of DOS.
slow_interrupt		db	SLOW_INT ; Interrupt used if DOS < 3.1.
old_multi_int		dd	?	; Address of old multiplex.
old_keyboard_int	dd	?	; Address of old keyboard.
old_time_int		dd	?	; Address of old time of day.
activated		db	0	; Switch to prevent re-entry.
crt_stat		dw	?	; CRT port.

save_sp			dw	?	; Save area of old stack.
save_ss			dw	?	; Save area of old stack.
video_state		db	?	; Save video state.
cursor_location		dw	?	; Save cursor location.
current_page		db	?	; Save page.
current_background	db	?	; Current background color.
current_palette		db	?

asc_value		db	6 dup(0) ; Area for number display.
setting			dw	LOOP_DEFAULT ; Delay loop setting.
delay_switch		db	1	; Delay Switch on/off. 1 = ON.

strobe			dw	STROBE_BEGIN ; Location of strobe pattern.
move_strobe1		dw	?	; Delay countdown.
move_strobe2		dw	?	; Delay countdown.
screen_seg		dw	?	; Address of screen.
enable			db	1	; Enable/disable switch.
columns			db	80	; Number of columns on screen.

;------------------------------------------------------------------------------
;			   T S R   C O D E   A R E A
;------------------------------------------------------------------------------

			;-------------------------------------------------------
			;   multiplex - This procedure handles external
			;	communications for the memory resident
			;	portion of WHOA running on DOS 3.1 or 
			;	greater.
			;-------------------------------------------------------
multiplex		proc	far

			;--- Check for our unique handle. If not found ---
			;--- jump to next multiplex routine in chain. ----

			cmp	ah,MULTI_HANDLE 
			je	multiplex_0010  
			jmp	dword ptr cs:old_multi_int
multiplex_0010:		call	request     
			iret	; Must return as an interrupt routine.
multiplex		endp

			;-------------------------------------------------
			;   interrupt - This procedure handles external
			;	communications for the memory resident
			;	portion of WHOA running on DOS 3.0 or
			;	less.
			;-------------------------------------------------
interrupt		proc	far
			call	request
			iret
interrupt		endp

			;-----------------------------------------------
			;   request - This routine execute a slowdown
			;	function based on the contents of AL. 
			;
			;   Status returned in AL.
			;-----------------------------------------------
request			proc	near
			;--- We are being called. Find out why ---

request_0010:		cmp	al,INSTALL_CHECK ; Check for installed?
			jne	request_0020	; Jump if NO.   
			mov	al,INSTALLED	; We are already installed.
			ret

request_0020:		cmp	al,UNINSTALL	; Ordered to uninstall?
			jne	request_0030	; Jump if NO.   
			call	restore		; Uninstall.
			mov	al,OK		; Everything went OK.
			ret

request_0030:		cmp	al,SET_LOOP	; Ordered to set delay loop?
			jne	request_0040	; Jump if NO.   
			mov	cs:setting,bx	; Set delay loop counter.
			mov	al,OK		; Everything went OK.
			ret 

request_0040:		mov	al,ERROR	; Unknown function.
			ret   
request			endp

			;------------------------------------------------
			;   keyboard - This routine will compare every
			;	keystroke in search of our hot key.
			;	If <Alt> <F10> is pressed then send     
			;	WHOA!'s Menu into motion.
			;------------------------------------------------
keyboard		proc	far
			;--- Check for READ KEYBOARD ---

			cmp	ah,0		; Is it a keyboard request?
			je	keyboard_0010	; Jump if YES. 
			jmp	dword ptr cs:old_keyboard_int ; Do original
						; keyboard routine.
			;--- Check for hot key ---

keyboard_0010:		pushf			; Call original keyboard.
			call	dword ptr cs:old_keyboard_int
			pushf
			cmp	ax,HOT_KEY	; Is key hot key?
			je	keyboard_0020	; Jump if YES.
			popf
			iret			; Return to interrupter.

			;--- Check to see if menu is already active. ---
			;--- If not, activate menu routine. ------------

keyboard_0020:		cli			; Stop Interrupts 
			cmp	cs:activated,0	; Already active?
			jne	keyboard_0030	; Jump if YES. 

			mov	cs:activated,1	; Set active flag.
			call	active		; Activate menu.
			mov	cs:activated,0	; Clear active flag.

			;--- Contine on with next key --

keyboard_0030:		sti
			mov	ah,0
			popf
			jmp	keyboard_0010
keyboard		endp

			;-----------------------------------------------------
			;    active - This procedure protects amd initializes
			;	the system and calls the menu.
			;-----------------------------------------------------
active			proc	near
			mov	cs:delay_switch,0 ; Turn off delay.

			push	ax
			push	bx

			;--- Setup our stack ---

			mov	cs:save_sp,sp
			mov	cs:save_ss,ss
			mov	ax,offset cseg:slowdown_0010 + STACK_SIZE
			mov	bx,cs
			cli
			mov	ss,bx
			mov	sp,ax
			sti

			push	cx		; Save registers.
			push	dx
			push	si
			push	di
			push	es
			push	ds
			push	bp

			mov	ax,cs
			mov	ds,ax

			call	calibrate	; Call menu calibrate.

			pop	bp		; Restore registers.
			pop	ds
			pop	es
			pop	di
			pop	si
			pop	dx
			pop	cx

			;--- Restore old stack ---

			cli
			mov	ss,cs:save_ss
			mov	sp,cs:save_sp
			sti
			pop	bx
			pop	ax

			mov	al,cs:enable
			mov	cs:delay_switch,al ; Turn on Delay.
			ret
active			endp

			;-----------------------------------------------
			;    time_of_day - This procedure contains
			;	the loop that slows the system down.
			;	The original time_of_day routine is
			;	called to maintain the system's clock.
			;-----------------------------------------------
time_of_day		proc	far

			;--- Call original time_of_day routine ---

			pushf
			call	dword ptr cs:old_time_int

			;--- Check to see if we are disabled ---

			pushf
			cmp	cs:delay_switch,0 ; Are we disabled?
			je	time_of_day_0030 ; Jump if YES. 

			;--- Do our loop to the current setting ---

			cli			; Stop all interrupts.
			push	cx
			mov	cx,cs:setting
time_of_day_0010:	push	cx
			mov	cx,TIME_PAUSE
time_of_day_0020:	loop	time_of_day_0020
			pop	cx
			loop	time_of_day_0010
			pop	cx
			sti			; Restore interrupts.

			;--- Return to caller ---

time_of_day_0030:	popf
			iret
time_of_day		endp

			;---------------------------------------------------
			;   calibrate - This procedure displays WHOA!'s
			;	menu to allow calibration of the slowdown
			;	loop and allow disable/enable of WHOA!
			;---------------------------------------------------
calibrate		proc	near
			call	save_screen	; Save the current screen.
			mov	ax,setting	; Initialize our strobe setting.
			mov	move_strobe1,ax
			mov	move_strobe2,TIME_PAUSE / 10

			;--- Display menu using macro ---

	DISPLAY_AT 00,00,BORDER,<'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'>
	DISPLAY_AT 00,01,BORDER,186
	DISPLAY_AT 01,01,TEXT,   <'        WHOA! by Brad Crandall           '>
	DISPLAY_AT 41,01,BORDER,186
	DISPLAY_AT 00,02,BORDER,<'ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶'>
	DISPLAY_AT 00,03,BORDER,<186>
	DISPLAY_AT 01,03,TEXT,   <'       Key          Meaning             '>
	DISPLAY_AT 41,03,BORDER,<186>
	DISPLAY_AT 00,04,BORDER,<186>
	DISPLAY_AT 01,04,TEXT,   <'     -------    ----------------        '>
	DISPLAY_AT 41,04,BORDER,<186>
	DISPLAY_AT 00,05,BORDER,<186>
	DISPLAY_AT 01,05,TEXT,   <'        +       Execute Faster          '>
	DISPLAY_AT 41,05,BORDER,<186>
	DISPLAY_AT 00,06,BORDER,<186>
	DISPLAY_AT 01,06,TEXT,   <'        -       Execute Slower          '>
	DISPLAY_AT 41,06,BORDER,<186>
	DISPLAY_AT 00,07,BORDER,<186>
	DISPLAY_AT 01,07,TEXT,   <'        D       Disable WHOA!           '>
	DISPLAY_AT 41,07,BORDER,<186>
	DISPLAY_AT 00,08,BORDER,<186>
	DISPLAY_AT 01,08,TEXT,   <'        E       Enable WHOA!            '>
	DISPLAY_AT 41,08,BORDER,<186>
	DISPLAY_AT 00,09,BORDER,<186>
	DISPLAY_AT 01,09,TEXT,   <'     <Enter>    Quit                    '>
	DISPLAY_AT 41,09,BORDER,<186>
	DISPLAY_AT 00,10,BORDER,<186>
	DISPLAY_AT 01,10,TEXT,   <'                                        '>
	DISPLAY_AT 41,10,BORDER,<186>
	DISPLAY_AT 00,11,BORDER,<186>
	DISPLAY_AT 01,11,TEXT,   <' Current setting 00000   ->          <- '>
	DISPLAY_AT 41,11,BORDER,<186>
	DISPLAY_AT 00,12,BORDER,<186>
	DISPLAY_AT 01,12,TEXT,   <'         Press <ENTER> to quit.         '>
	DISPLAY_AT 41,12,BORDER,<186>
	DISPLAY_AT 00,13,BORDER,<'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'>
			;--- Display delay loop number ---

calibrate_0005:		call	display_number

			;--- Move fancy strobe ---

calibrate_0010:		dec	move_strobe2
			jne	calibrate_0035
			mov	move_strobe2,TIME_PAUSE / 10
			dec	move_strobe1
			jne	calibrate_0035
			mov	ax,setting
			mov	move_strobe1,ax
			DISPLAY_AT strobe,11,TEXT,<' '>
			cmp	strobe,STROBE_END
			je	calibrate_0020
			inc	strobe
			jmp	calibrate_0030
calibrate_0020:		mov	strobe,STROBE_BEGIN
calibrate_0030:		cmp	enable,0
			je	calibrate_0035
			DISPLAY_AT strobe,11,BORDER,<'*'>

			;--- Get data from keyboard if available ---

calibrate_0035:		mov	ah,1
			pushf
			call	dword ptr old_keyboard_int ; Original.
			je	calibrate_0010	; Jump if no data.
			mov	ah,0
			pushf
			call	dword ptr old_keyboard_int ; Original.

			;--- Calibrate based on character received ---

			cmp	al,'+'		; Do we speed up?
			jne	calibrate_0040	; Jump if NO.  
			dec	setting		; Speed up loop.
			cmp	setting,SET_MIN	; Less than minimum setting?
			jae	calibrate_0038	; Jump if NO.  .
			mov	setting,SET_MIN	; Set to minimum setting.
calibrate_0038:		jmp	calibrate_0005

calibrate_0040:		cmp	al,'-'		; Do we slow down?
			jne	calibrate_0050	; Jump if NO.   
			inc	setting		; Slow down.
			cmp	setting,SET_MAX	; Greater than maximum?
			jbe	calibrate_0045	; Jump if NO.   
			mov	setting,SET_MAX	; Set to maximum setting.
calibrate_0045:		jmp	calibrate_0005

calibrate_0050:		cmp	al,13		; Are we done?
			je	calibrate_0060	; Jump if YES. 

			cmp	al,'d'		; Disable WHOA!?
			je	calibrate_0051	; Jump if YES. 
			cmp	al,'D'		; Disable WHOA!?
			jne	calibrate_0052	; Jump if NO. 
calibrate_0051:		mov	enable,0	; Disable WHOA!
			jmp	calibrate_0010

calibrate_0052:		cmp	al,'e'		; Enable WHOA!?
			je	calibrate_0053	; Jump if YES.
			cmp	al,'E'		; Enable WHOA!?
			jne	calibrate_0055	; Jump if NO.   
calibrate_0053:		mov	enable,1	; Enable WHOA!

calibrate_0055:		jmp	calibrate_0010

calibrate_0060:		call	restore_screen	; Restore the screen.
			ret
calibrate		endp

			;--------------------------------------------------
			;    display_number - This procedure will display
			;	the current setting of the delay loop at
			;	the expected position on the screen.
			;--------------------------------------------------
display_number		proc	near
			mov	ax,setting
			call	numasc		; Convert to an ASCII number.

			mov	di,18		; Set parameters.
			mov	ax,11
			mov	cx,TEXT
			mov	si,offset cseg:asc_value

			call	display_at_proc ; Display ASCII number.

			ret
display_number		endp

			;--------------------------------------------------
			;    save_screen - This procedure will save the
			;	current screen.  Care is taken so that
			;	not only the data on the screen is saved,
			;	but the current mode, color, and palette
			;	is saved also. This allows WHOA to
			;	work under graphic conditions.
			;--------------------------------------------------
save_screen		proc	near
			push	ds
			push	es

			;--- Get screen information ---

			xor	ax,ax
			mov	es,ax
			mov	ax,es:[463h]
			add	ax,6
			mov	cs:crt_stat,ax	; CRT status port address.

			mov	screen_seg,0b800h ; Screen address.
			xor	ax,ax
			mov	es,ax
			mov	ax,word ptr es:[0410h]
			and	al,30h
			cmp	al,30h
			jne	save_screen_0010
			mov	screen_seg,0b000h ; Screen address.

			;--- Save the screen to a safe area ---

save_screen_0010:	call	screen_off	; Turn off the display.
			mov	di,offset cseg:slowdown_0010 + STACK_SIZE + 1
			mov	ax,cs
			mov	es,ax
			mov	ds,screen_seg
			xor	si,si
			mov	cx,SCREEN_SIZE
			cld
			rep	movsw
			call	screen_on	; Turn on the display.

			;--- Get current Video State ---

			mov	ah,15
			int	10h
			mov	cs:video_state,al
			mov	cs:current_page,bh
			mov	ah,03
			int	10h
			mov	cs:cursor_location,dx

			;--- Get current background color and palette ---

			push	es
			xor	ax,ax
			mov	es,ax
			mov	al,es:[466h]	; CRT_Palette.
			and	al,1fh
			mov	cs:current_background,al
			mov	cs:current_palette,0
			mov	al,es:[466h]
			and	al,20h
			je	save_screen_0015
			mov	cs:current_palette,1
save_screen_0015:	pop	es

			;--- Change Video State to an 80 X 25 mode ---
			;--- if necessary. ---------------------------

			cmp	cs:video_state,3
			jbe	save_screen_0030
			cmp	cs:video_state,7
			je	save_screen_0030

			mov	ah,0
			mov	al,3
			cmp	cs:screen_seg,0b800h
			je	save_screen_0020
			mov	al,2
save_screen_0020:	int	10h		; Change mode to 80 X 25.

			;--- Move cursor off screen ---

save_screen_0030:	mov	bh,cs:current_page
			mov	dx,0ffffh
			mov	ah,2
			int	10h

			pop	es
			pop	ds
			ret
save_screen		endp

			;----------------------------------------------------
			;    restore_screen - This procedure will restore
			;	the screen to the state it was in prior to
			;	the save_screen call.
			;----------------------------------------------------
restore_screen		proc	near
			push	ds
			push	es

			;--- Restore Video State ---

			cmp	video_state,3
			jbe	restore_0010
			cmp	video_state,7
			je	restore_0010

			mov	al,video_state
			mov	ah,0
			int	10h

			;--- Restore Background color and palette ---

			mov	ah,11
			mov	bl,current_palette
			mov	bh,1
			int	10h

			mov	ah,11
			mov	bl,current_background
			mov	bh,0
			int	10h

			;--- Reset Cursor Position ---

restore_0010:		mov	bh,current_page
			mov	dx,cursor_location
			mov	ah,2
			int	10h

			;--- Restore screen ---

			call	screen_off	; Turn off the display.
			mov	si,offset cseg:slowdown_0010 + STACK_SIZE + 1
			mov	es,screen_seg
			xor	di,di
			mov	cx,SCREEN_SIZE
			cld
			rep	movsw
			call	screen_on	; Turn on the display.

			pop	es
			pop	ds
			ret
restore_screen		endp

			;----------------------------------------------------
			;    display_at_proc - This procedure is used by
			;	the macro "DISPLAY_AT".  This procedure
			;	will display a string to a given location
			;	anywhere on the screen.
			;----------------------------------------------------
display_at_proc		proc	near
			mov	es,screen_seg
			mul	columns
			add	di,ax
			shl	di,1		; Screen offset.
			mov	ah,cl		; Color in ah.
display_at_proc_0010:	mov	al,byte ptr cs:[si]
			inc	si
			cmp	al,0		; Are we done?
			je	display_at_proc_0050 ; Jump if YES. 

			;--- Wait for horizontal retrace if CGA ---

			cmp	screen_seg,0b800h
			jne	display_at_proc_0040
			push	ax
			mov	dx,crt_stat
			cli
display_at_proc_0020:	in	al,dx
			test	al,1
			jne	display_at_proc_0020
display_at_proc_0030:	in	al,dx
			test	al,1
			je	display_at_proc_0030
			pop	ax

			;--- Display one byte of string ---

display_at_proc_0040:	stosw
			sti
			jmp	display_at_proc_0010

display_at_proc_0050:	ret
display_at_proc		endp

;------------------------------------------------------------------------------
;	NUMASC.INC	By Brad D Crandall	Created 04/23/85	      |
;------------------------------------------------------------------------------
;									      |
;	numasc:								      |
;									      |
;	This procedure contains the code necessary to convert a		      |
;	binary value into an ASCII coded number.  This routine will not	      |
;	work correctly on numbers larger than 65536. The numbers	      |
;	must be integers greater than or equal to 0.			      |
;									      |
;	How to use:							      |
;									      |
;	    1) The following variables must be defined in your DS segment.    |
;									      |
;		asc_value	DB	5 DUP(?)			      |
;									      |
;	    2) Load the AX register with the binary value.		      |
;									      |
;	    3) Upon return, ASC_VALUE will contain the ASCII Coded number.    |
;									      |
;	    4) All registers are preserved except AX.			      |
;									      |
;------------------------------------------------------------------------------
base_ten		dw	10000,1000,100,10,1
numasc			proc	near
			push	si
			push	cx
			push	dx
			push	di
			xor	si,si
			xor	di,di
			mov	cx,5
numasc_0005:		mov	dl,0
numasc_0010:		sub	ax,cs:base_ten[si]
			jb	numasc_0020
			inc	dl
			jmp	numasc_0010
numasc_0020:		add	ax,cs:base_ten[si]
			add	dl,'0'
			mov	asc_value[di],dl
			add	si,2
			inc	di
			loop	numasc_0005
			pop	di
			pop	dx
			pop	cx
			pop	si
			ret
numasc			endp

			;-------------------------------------------------
			;    restore - This procedure will restore the
			;	interrupt vectors to the state that they
			;	were in prior to the execution of WHOA! 
			;	This terminates WHOA completely.
			;-------------------------------------------------
restore			proc	near
			push	ax
			push	bx

			;--- Setup our stack ---

			mov	cs:save_sp,sp
			mov	cs:save_ss,ss
			mov	ax,offset cseg:slowdown_0010 + STACK_SIZE
			mov	bx,cs
			cli
			mov	ss,bx
			mov	sp,ax
			sti

			push	cx
			push	dx
			push	si
			push	di
			push	es
			push	ds
			push	bp

			;--- Restore time_of_day interrupt to the original ---

			mov	dx,cs:word ptr cs:old_time_int
			mov	ds,cs:word ptr cs:old_time_int+2
			mov	ah,25h
			mov	al,TIME_INT
			int	21h

			;--- Restore multiplex/slow interrupt to original state ---

			mov	dx,cs:word ptr cs:old_multi_int
			mov	ds,cs:word ptr cs:old_multi_int+2
			mov	ah,25h
			mov	al,MULTI_INT
			cmp	cs:dos_version,DOS_CMP
			jae	restore2_0010
			mov	al,cs:slow_interrupt
restore2_0010:		int	21h

			;--- Restore keyboard interrupt to the original ---

			mov	dx,cs:word ptr cs:old_keyboard_int
			mov	ds,cs:word ptr cs:old_keyboard_int+2
			mov	ah,25h
			mov	al,KEYBOARD_INT
			int	21h

			pop	bp
			pop	ds
			pop	es
			pop	di
			pop	si
			pop	dx
			pop	cx

			;--- Restore old stack ---

			cli
			mov	ss,cs:save_ss
			mov	sp,cs:save_sp
			sti
			pop	bx
			pop	ax
			ret
restore			endp

			;---------------------------------------
			;    screen-off - This procedure will
			;	turn off the display. We do
			;	this so we don't have to see
			;	CGA snow during massive direct
			;	screen I/O.
			;---------------------------------------
screen_off		proc	near
			push	ds
			xor	ax,ax
			mov	ds,ax
			mov	al,byte ptr ds:[0465h]
			and	al,0f7h
			mov	dx,03d8h
			out	dx,al
			pop	ds
			ret
screen_off		endp

			;--------------------------------------
			;    screen_on - This procedure will 
			;	turn on the display.
			;--------------------------------------
screen_on		proc	near
			push	ds
			xor	ax,ax
			mov	ds,ax
			mov	al,byte ptr ds:[0465h]
			or	al,08h
			out	dx,al
			pop	ds
			ret
screen_on		endp

;------------------------------------------------------------------------------
;		   N O N - R E S I D E N T   D A T A   A R E A
;------------------------------------------------------------------------------
valid_parm		db	0	; Switch to determine valid.

;------------------------------------------------------------------------------
;		   N O N - R E S I D E N T   C O D E   A R E A
;------------------------------------------------------------------------------

			;--- First major code to be executed within WHOA ---

slowdown_0010:		push	ds
			xor	ax,ax
			push	ax
			mov	ax,cs
			mov	ds,ax

			;--- Get the DOS version number ---
			mov	ah,30h		; Get DOS Version number.
			int	21h
			xchg	al,ah
			mov	dos_version,ax	; High is MAJOR, Low is MINOR.

			call	set_loop_default ; Set the loop default counter.

DISPLAY_DOS <'Copyright 1988 COMPUTE! Publications, Inc.  All rights reserved.',13,10>

			;--- Determine whether to install or unload ---

			cmp	dos_version,DOS_CMP ; What DOS Version??
			jae	slow_down_00105	; Jump if DOS >= 3.1.
			call	check_installed
			jmp	slow_down_00106
slow_down_00105:	mov	ah,MULTI_HANDLE
			mov	al,INSTALL_CHECK    
			int	MULTI_INT
slow_down_00106:	cmp	al,NOT_INSTALLED ; Are we installed?
			jne	slow_down_0011	 ; Jump if NO.
			jmp	slow_down_0019

			;--- If a parameter was passed, then send ----------
			;--- it to the memory resident part of WHOA! ---
			;--- otherwise disable WHOA completely. --------

slow_down_0011:		cmp	valid_parm,0	; Any parm?
			jne	slow_down_00113	; Jump if YES. 
			jmp	slow_down_0013

slow_down_00113:	cmp	valid_parm,1	; Was it a valid parm?
			je	slow_down_00115	; Jump if YES. 

			DISPLAY_DOS <'Parameter out of range.',10,13>
			DISPLAY_DOS <'Valid values are between 1 and 435.',10,13>
			ret			; Return to DOS.

			;--- Pass new delay loop value to TSR WHOA ---

slow_down_00115:	mov	bx,setting
			RESIDENT SET_LOOP
			cmp	al,OK
			jne	slow_down_0012
			DISPLAY_DOS <'Setting completed.',10,13>
			ret			; Return to DOS.
slow_down_0012:		DISPLAY_DOS <'TSR is unable to set.',10,13>
			ret			; Return to DOS.

			;--- Uninstall WHOA ---

slow_down_0013:		RESIDENT UNINSTALL
			cmp	al,OK		; All go well?
			jne	slow_down_0015	; Jump if NO.   
			DISPLAY_DOS <'Uninstalled.',10,13>
			ret			; Return to DOS.
slow_down_0015:		DISPLAY_DOS <'Unable to uninstall.',10,13>
			ret			; Return to DOS.

			;--- Install proper entry interrupt ---
			;--- based on DOS Version. ---

slow_down_0019:		cmp	dos_version,DOS_CMP
			jae	slow_down_0020

			mov	al,slow_interrupt ; Install SLOW_INT.
			mov	ah,35h
			int	21h		; Save original.
			mov	word ptr old_multi_int,bx
			mov	word ptr old_multi_int+2,es
			mov	al,slow_interrupt   
			mov	dx,offset cseg:interrupt
			mov	ah,25h
			int	21h
			jmp	slow_down_0030

slow_down_0020:		mov	al,MULTI_INT	; Install MULTI_INT
			mov	ah,35h
			int	21h		; Save original.
			mov	word ptr old_multi_int,bx
			mov	word ptr old_multi_int+2,es
			mov	dx,offset cseg:multiplex
			mov	al,MULTI_INT
			mov	ah,25h
			int	21h

			;--- Install Keyboard ---

slow_down_0030:		mov	al,KEYBOARD_INT
			mov	ah,35h
			int	21h		; Save original.
			mov	word ptr old_keyboard_int,bx
			mov	word ptr old_keyboard_int+2,es

			mov	dx,offset cseg:keyboard
			mov	al,KEYBOARD_INT
			mov	ah,25h
			int	21h

			;--- Install time_of_day ---

			mov	al,TIME_INT
			mov	ah,35h
			int	21h		; Save original.
			mov	word ptr old_time_int,bx
			mov	word ptr old_time_int+2,es

			mov	dx,offset cseg:time_of_day
			mov	al,TIME_INT
			mov	ah,25h
			int	21h

			;--- Terminate and stay resident ---

			DISPLAY_DOS <'Now resident.  Use <Alt> F10 for calibrating.',13,10>
			mov	ax,cs
			mov	es,ax
			add	sp,4		; Clean up stack.
			mov	dx,offset cseg:slowdown_0010 + STACK_SIZE + SCREEN_SIZE + SCREEN_SIZE + 2
			int	27h
slowdown		endp

			;-----------------------------------------------------
			;    set_loop_default - This procedure will examine
			;	the command parameters in the Program 
			;	Segment Prefix for any Loop Default Value.
			;
			;    Returns:
			;	valid_parm is set as follows:
			;	    0 = No parameter given.
			;	    1 = Valid numeric parameter found.
			;	    2 = Valid parameter found.
			;-----------------------------------------------------
set_loop_default	proc	near
			cmp	byte ptr es:[80h],0
			je	set_loop_default_0900

			;--- Set numeric as loop default ---

			mov	di,81h		; Offset of parms.
			mov	word ptr value,0
			xor	ch,ch
			mov	cl,byte ptr es:[80h]

set_loop_default_0010:	mov	al,byte ptr es:[di]
			inc	di
			cmp	al,'0'
			jb	set_loop_default_0020
			cmp	al,'9'
			ja	set_loop_default_0020
			call	ascnum
set_loop_default_0020:	loop	set_loop_default_0010

			mov	valid_parm,2	; Set for invalid parm.

			;--- Check numeric value to see if it is in range ---

			cmp	value,SET_MIN
			jb	set_loop_default_0910
			cmp	value,SET_MAX
			ja	set_loop_default_0910

			;--- Valid value found ---

			mov	ax,value
			mov	setting,ax
			mov	valid_parm,1
			ret

			;--- No Value Found ---

set_loop_default_0900:	mov	valid_parm,0
set_loop_default_0910:	ret
set_loop_default	endp

			;------------------------------------------------
			;    check_installed - This procedure will check
			;	to see if WHOA is already resident.
			;	This procedure is used on DOS versions
			;	less than 3.1.
			;
			;    Returns in AL:
			;	NOT_INSTALLED
			;	INSTALLED
			;------------------------------------------------
check_installed		proc	near
			push	es

			mov	ah,35h
			mov	al,slow_interrupt
			int	21h

			mov	al,INSTALLED

			;--- Check to see routines match ---
			mov	si,offset cseg:interrupt
			mov	di,bx
			mov	cx,10		; Number of bytes to compare.
			rep	cmpsb
			je	check_installed_0010
			mov	al,NOT_INSTALLED

check_installed_0010:	pop	es
			ret
check_installed		endp

			;-----------------------------------------------
			;    call_interrupt - This procedure calls the
			;	resident portion of WHOA for DOS
			;-----------------------------------------------
call_interrupt		proc	near
			int	SLOW_INT
			ret
call_interrupt		endp

;------------------------------------------------------------------------------
;	ASCNUM.INC	By Brad D Crandall	Created 04/23/85	      |
;------------------------------------------------------------------------------
;									      |
;	ascnum:								      |
;									      |
;	This procedure contains the code necessary to convert a		      |
;	ASCII coded number into a binary value.  This routine will not	      |
;	work correctly on numbers larger than 65536. The number		      |
;	must be integers greater than or equal to 0.			      |
;									      |
;	How to use:							      |
;									      |
;	    1) Move a zero to VALUE.					      |
;									      |
;		MOV	VALUE,0						      |
;									      |
;	    2) Load the AL register with the left most digit and then call    |
;	       this routine. Do this for every digit in the number.	      |
;									      |
;		MOV	AL,'3'		; Translate 34 into binary.	      |
;		CALL	NUMASC						      |
;									      |
;		MOV	AL,'4'						      |
;		CALL	NUMASC						      |
;									      |
;	    3) The binary value will be found in the variable VALUE	      |
;									      |
;		MOV	AX,VALUE	; AX now contains binary 34.	      |
;									      |
;	    4) All registers are preserved except AX.			      |
;------------------------------------------------------------------------------
ten			dw	10
value			dw	?

ascnum			proc	near
			push	dx
			cmp	al,'0'
			jb	ascnum_0010 	; Not a number.
			cmp	al,'9'
			ja	ascnum_0010	; Not a number.
			sub	al,'0'
			xor	ah,ah
			mov	dx,ax
			push	dx
			mov	ax,cs:value
			mul	cs:ten
			pop	dx
			add	ax,dx
			mov	cs:value,ax
ascnum_0010:		pop	dx
			ret
ascnum			endp

cseg			ends
			end	slowdown
