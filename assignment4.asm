; assignment4.asm - CISC225 Assignment 3 (Colorful V)
; Don Freiday
; 2/26/2017

INCLUDE Irvine32.inc

ExitProcess proto,dwExitCode:dword

character = '*' ; Character to print
colorRange = 0FFh ; Range of available colors
numAsterisks = 5 ; Number of asterisks to print
numRows = 20 ; Number of rows to print

.data
.code
main proc
	call Randomize ; Re-seeds the random number generator with the current time in hundredths of seconds
	
	mov ecx,numRows ; Loop numRows times
	mov dl,4 ; Initial cursor position is column 4
	mov dh,2 ; Initial cursor position is row 2
	mov al,1 ; Direction to move cursor
	call PrintRows ; Print left half of V
	mov dl,56 ; Initial cursor position is column 56
	mov dh,2 ; Initial cursor position is row 2
	mov al,-1 ; Direction to move cursor
	call PrintRows ; Print right half of V

	; Display “Press any key to continue” in white text on a black background
	mov al,white
	mov ah,black
	call SetTextColor
	call CrLf
	call WaitMsg

	invoke ExitProcess,0 
main endp

PrintRows proc
	push ecx
	push eax
	push edx
	L1:
		call Gotoxy ; Locates the cursor at a row and column; specified by dh and dl respectively
		call PrintAsterisks
		call CrLf
		add dl,al ; Move cursor to the right or left by the number of  columns specified in al
		inc dh ; Move cursor down one row
		loop L1
	pop edx
	pop eax
	pop ecx
	ret
PrintRows endp

PrintAsterisks proc
	push ecx ; preserve ecx
	push eax ; preserve eax
	mov ecx,numAsterisks
	L1:
		mov eax,colorRange ; Set eax to desired range of colors
		call RandomRange 
		call SetTextColor
		mov al,character ; Set character to be printed by WriteChar
		call WriteChar
		loop L1
	pop eax ; restore eax
	pop ecx ; restore ecx
	ret
PrintAsterisks endp

end main