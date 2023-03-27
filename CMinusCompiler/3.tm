0:   LD   6, 0(0)	 Set the GP to the max data memory
1:   ST   0, 0(0)	 clear data memory address 0
2:   LDA   4, 0(6)	 Update the SP to the next free spot after the globals
3:   LDA   5, 0(4)	 Set the FP to the SP
* Stack Push
4:   ST   5, 0(4)	 
5:   LDA   4, -1(4)	 
6:   LDC   0, 12(0)	 Load pre-calculated return address into reg 0 to be pushed onto stack
* Stack Push
7:   ST   0, 0(4)	 
8:   LDA   4, -1(4)	 
9:   LDA   5, 1(4)	 Update Frame Pointer
10:   LDA   4, -1(4)	 Increase the Stack Pointer to after the local vars
12:   HALT   0, 0, 0	END OF PROGRAM (after main)
* Start of function main
13:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
14:   ST   0, 0(4)	 
15:   LDA   4, -1(4)	 
* Stack Pop
16:   LD   0, 1(4)	 
17:   LDA   4, 1(4)	 
18:   ST   0, -1(5)	 Storing Local Var
19:   LD   0, -1(5)	 Loading local Var
* Stack Push
20:   ST   0, 0(4)	 
21:   LDA   4, -1(4)	 
* Stack Pop
22:   LD   0, 1(4)	 
23:   LDA   4, 1(4)	 
24:   OUT   0, 0, 0	outputting value
* Start of code return no value
25:   LDA   4, 1(5)	 Reset stack pointer to before the frame
26:   LD   0, 0(5)	 Load return address into reg 0
27:   LD   5, 1(5)	 Load old FP into FP
28:   LDA   7, 0(0)	 Jump back to return address
* End of code return no value
11:   LDC   7, 13(0)	 Backfill function call to main
