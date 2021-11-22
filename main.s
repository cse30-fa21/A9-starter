	////////////////////////////
	// version 1.3 11/22/2021 //
	////////////////////////////
	.arch armv6				// armv6 architecture
	.arm					// arm 32-bit instruction set
	.fpu vfp				// floating point co-processor
	.syntax unified				// modern sytax

	// function import
	.extern encrypt
	.extern decrypt
	.extern stderr
	.extern fprintf
	.extern fclose
	.extern setup
	.extern encryptdelete

	// global constants
	.include "encrypter.h"

	.section .rodata
.Lmsg1:	.string "Write failed on output\n"
.Lmsg2:	.string "Bookfile is too short for message\n"
	.text

	//////////////////////////////////////////////////////
	// int main(int argc, char **argv)                  //
	// encrypter [-d | -e] -b bookfile encryption_file  //
	//////////////////////////////////////////////////////

	.global main				// main global for linking to
	.type	main, %function			// define as a function
	.equ	FP_OFF,		32		// fp offset in main stack frame
	.equ 	BUFSZ,		1024		// max for assignment is 4096 min is 1024

	//////////////////////////////////////////////////////////////////////////////
	// automatics (local variable) frame layout
	// NOTICE! odd # of regs pushed, Not 8-byte aligned at FP_OFF; add 4 bytes pad
	// 
	// local stack frame name are used with fp as base
	// format is .equ VAR_NAME, NAME_OF_PREVIOUS_VARIABLE + <size of variable>
	// first variable should use  FP_OFF as the previous variable
	//////////////////////////////////////////////////////////////////////////////
	.equ	FPBOOK,		FP_OFF+4	// FILE * to book file
	.equ	FPIN,		FPBOOK+4	// FILE * to input file
	.equ	FPOUT,		FPIN+4		// FILE * to output file
	.equ	MODE,		FPOUT+4		// decrypt or encrypt mode
	.equ	IOBUF,		MODE+BUFSZ	// buffer for input file
	.equ	BOOKBUF,	IOBUF+BUFSZ	// buffer for book file
	// add local variables here: Then adjust PAD or comment out pad line as needed 
	.equ	PAD,		BOOKBUF+4	// Stack frame PAD if needed goes here
	.equ	OUT6,		PAD+4		// output arg6
	.equ	OUT5,		OUT6+4		// output arg5 must be at bottom
	.equ	FRAMESZ,	OUT5-FP_OFF	// total space for automatics
	//////////////////////////////////////////////////////////////////////////////
	// make sure that FRAMESZ + FP_OFF + 4 divides by 8 EVENLY!
	//////////////////////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////////////////////
	// passed arg offsets used with sp as the base
	//////////////////////////////////////////////////////////////////////////////
	.equ	OARG6,		4		// Outgoing arg 6		
	.equ	OARG5,		0		// Outgoing arg 5		

main:
	// function prologue
	push	{r4-r10, fp, lr}		// WARNING! odd count register save!
	add	fp, sp, FP_OFF			// set frame pointer to frame base
	XXX	xx, xxxxx			// if frame size is too big, use pseudo ldr
	XXX	xx, xx, xx			// allocate space for locals and passed args 
	
	// call int setup(argc, argv, &mode, &FPBOOK, &FPIN, &FPOUT)

	// set up for main loop

	// main loop
.Lloop:
	// read the input 

	// now read the book the same number of chars

	// Both buffers are full, process the input

	// based on mode: either encrypt the input

	// or decrypt the input

	// write out the i/o buffer as all chars are processed

	// end of loop
.Ldone:
	// close the files using fclose()

	// if encrypt failed to finish all input remove the incomplete encrypt file

	// function epilogue
	sub	sp, fp, FP_OFF			// restore stack frame top
	pop	{r4-r10,fp,lr}			// remove frame and restore
	bx	lr				// return to caller

	// function footer
	.size	main, (. - main)		// set size for function

	// file footer
	.section .note.GNU-stack,"",%progbits // set executable (linker)
.end
