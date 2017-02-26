; assignment4.asm - CISC225 Assignment 3 (Colorful V)
; Don Freiday
; 2/26/2017

INCLUDE Irvine32.inc

ExitProcess proto,dwExitCode:dword

.data
.code
main proc
	invoke ExitProcess,0 
main endp
end main