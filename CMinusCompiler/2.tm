0:   LD   6, 0(0)	 Set the GP to the max data memory
1:   ST   0, 0(0)	 clear data memory address 0
2:   LDA   4, -4(6)	 Update the SP to the next free spot after the globals
3:   LDA   5, 0(4)	 Set the FP to the SP
* Stack Push
4:   ST   5, 0(4)	 
5:   LDA   4, -1(4)	 
6:   LDC   0, 12(0)	 Load pre-calculated return address into reg 0 to be pushed onto stack
* Stack Push
7:   ST   0, 0(4)	 
8:   LDA   4, -1(4)	 
9:   LDA   5, 1(4)	 Update Frame Pointer
10:   LDA   4, 0(4)	 Increase the Stack Pointer to after the local vars
12:   HALT   0, 0, 0	END OF PROGRAM (after main)
* Start of function main
13:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
14:   ST   0, 0(4)	 
15:   LDA   4, -1(4)	 
16:   IN   0, 0, 0	 getting user input
* Stack Push
17:   ST   0, 0(4)	 
18:   LDA   4, -1(4)	 
19:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
20:   ST   0, 0(4)	 
21:   LDA   4, -1(4)	 
* Stack Pop
22:   LD   1, 1(4)	 
23:   LDA   4, 1(4)	 
24:   LDC   2, -3(0)	 
25:   ADD   0, 1, 2	calculate relative to GP array address
26:   ADD   0, 0, 6	calculate absolute array address
* Stack Pop
27:   LD   1, 1(4)	 
28:   LDA   4, 1(4)	 
29:   ST   1, 0(0)	 store global variable [] i
30:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
31:   ST   0, 0(4)	 
32:   LDA   4, -1(4)	 
33:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
34:   ST   0, 0(4)	 
35:   LDA   4, -1(4)	 
* Stack Pop
36:   LD   1, 1(4)	 
37:   LDA   4, 1(4)	 
38:   LDC   2, -3(0)	 
39:   ADD   0, 1, 2	calculate relative to GP array address
40:   ADD   0, 0, 6	calculate absolute array address
41:   LD   0, 0(0)	 load global var[]: i
* Stack Push
42:   ST   0, 0(4)	 
43:   LDA   4, -1(4)	 
44:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
45:   ST   0, 0(4)	 
46:   LDA   4, -1(4)	 
* Stack Pop
47:   LD   2, 1(4)	 
48:   LDA   4, 1(4)	 
* Stack Pop
49:   LD   1, 1(4)	 
50:   LDA   4, 1(4)	 
51:   ADD   0, 1, 2	
* Stack Push
52:   ST   0, 0(4)	 
53:   LDA   4, -1(4)	 
54:   LDC   0, 9(0)	 Load constant: 9
* Stack Push
55:   ST   0, 0(4)	 
56:   LDA   4, -1(4)	 
* Stack Pop
57:   LD   2, 1(4)	 
58:   LDA   4, 1(4)	 
* Stack Pop
59:   LD   1, 1(4)	 
60:   LDA   4, 1(4)	 
61:   ADD   0, 1, 2	
* Stack Push
62:   ST   0, 0(4)	 
63:   LDA   4, -1(4)	 
64:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
65:   ST   0, 0(4)	 
66:   LDA   4, -1(4)	 
* Stack Pop
67:   LD   1, 1(4)	 
68:   LDA   4, 1(4)	 
69:   LDC   2, -3(0)	 
70:   ADD   0, 1, 2	calculate relative to GP array address
71:   ADD   0, 0, 6	calculate absolute array address
* Stack Pop
72:   LD   1, 1(4)	 
73:   LDA   4, 1(4)	 
74:   ST   1, 0(0)	 store global variable [] i
75:   LDC   0, 3(0)	 Load constant: 3
* Stack Push
76:   ST   0, 0(4)	 
77:   LDA   4, -1(4)	 
78:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
79:   ST   0, 0(4)	 
80:   LDA   4, -1(4)	 
* Stack Pop
81:   LD   1, 1(4)	 
82:   LDA   4, 1(4)	 
83:   LDC   2, -3(0)	 
84:   ADD   0, 1, 2	calculate relative to GP array address
85:   ADD   0, 0, 6	calculate absolute array address
86:   LD   0, 0(0)	 load global var[]: i
* Stack Push
87:   ST   0, 0(4)	 
88:   LDA   4, -1(4)	 
89:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
90:   ST   0, 0(4)	 
91:   LDA   4, -1(4)	 
* Stack Pop
92:   LD   1, 1(4)	 
93:   LDA   4, 1(4)	 
94:   LDC   2, -3(0)	 
95:   ADD   0, 1, 2	calculate relative to GP array address
96:   ADD   0, 0, 6	calculate absolute array address
97:   LD   0, 0(0)	 load global var[]: i
* Stack Push
98:   ST   0, 0(4)	 
99:   LDA   4, -1(4)	 
* Stack Pop
100:   LD   2, 1(4)	 
101:   LDA   4, 1(4)	 
* Stack Pop
102:   LD   1, 1(4)	 
103:   LDA   4, 1(4)	 
104:   ADD   0, 1, 2	
* Stack Push
105:   ST   0, 0(4)	 
106:   LDA   4, -1(4)	 
107:   LDC   0, 3(0)	 Load constant: 3
* Stack Push
108:   ST   0, 0(4)	 
109:   LDA   4, -1(4)	 
* Stack Pop
110:   LD   1, 1(4)	 
111:   LDA   4, 1(4)	 
112:   LDC   2, -3(0)	 
113:   ADD   0, 1, 2	calculate relative to GP array address
114:   ADD   0, 0, 6	calculate absolute array address
* Stack Pop
115:   LD   1, 1(4)	 
116:   LDA   4, 1(4)	 
117:   ST   1, 0(0)	 store global variable [] i
118:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
119:   ST   0, 0(4)	 
120:   LDA   4, -1(4)	 
* Stack Pop
121:   LD   1, 1(4)	 
122:   LDA   4, 1(4)	 
123:   LDC   2, -3(0)	 
124:   ADD   0, 1, 2	calculate relative to GP array address
125:   ADD   0, 0, 6	calculate absolute array address
126:   LD   0, 0(0)	 load global var[]: i
* Stack Push
127:   ST   0, 0(4)	 
128:   LDA   4, -1(4)	 
* Stack Pop
129:   LD   0, 1(4)	 
130:   LDA   4, 1(4)	 
131:   OUT   0, 0, 0	outputting value
132:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
133:   ST   0, 0(4)	 
134:   LDA   4, -1(4)	 
* Stack Pop
135:   LD   1, 1(4)	 
136:   LDA   4, 1(4)	 
137:   LDC   2, -3(0)	 
138:   ADD   0, 1, 2	calculate relative to GP array address
139:   ADD   0, 0, 6	calculate absolute array address
140:   LD   0, 0(0)	 load global var[]: i
* Stack Push
141:   ST   0, 0(4)	 
142:   LDA   4, -1(4)	 
* Stack Pop
143:   LD   0, 1(4)	 
144:   LDA   4, 1(4)	 
145:   OUT   0, 0, 0	outputting value
146:   LDC   0, 3(0)	 Load constant: 3
* Stack Push
147:   ST   0, 0(4)	 
148:   LDA   4, -1(4)	 
* Stack Pop
149:   LD   1, 1(4)	 
150:   LDA   4, 1(4)	 
151:   LDC   2, -3(0)	 
152:   ADD   0, 1, 2	calculate relative to GP array address
153:   ADD   0, 0, 6	calculate absolute array address
154:   LD   0, 0(0)	 load global var[]: i
* Stack Push
155:   ST   0, 0(4)	 
156:   LDA   4, -1(4)	 
* Stack Pop
157:   LD   0, 1(4)	 
158:   LDA   4, 1(4)	 
159:   OUT   0, 0, 0	outputting value
* Start of code return no value
160:   LDA   4, 1(5)	 Reset stack pointer to before the frame
161:   LD   0, 0(5)	 Load return address into reg 0
162:   LD   5, 1(5)	 Load old FP into FP
163:   LDA   7, 0(0)	 Jump back to return address
* End of code return no value
11:   LDC   7, 13(0)	 Backfill function call to main
