0:   LD   6, 0(0)	 Set the GP to the max data memory
1:   ST   0, 0(0)	 clear data memory address 0
2:   LDA   4, -10(6)	 Update the SP to the next free spot after the globals
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
* Start of function minloc
13:   LD   0, 3(5)	 Loading param
* Stack Push
14:   ST   0, 0(4)	 
15:   LDA   4, -1(4)	 
* Stack Pop
16:   LD   0, 1(4)	 
17:   LDA   4, 1(4)	 
18:   ST   0, -2(5)	 Storing Local Var
19:   LD   0, 3(5)	 Loading param
* Stack Push
20:   ST   0, 0(4)	 
21:   LDA   4, -1(4)	 
22:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
23:   LD   1, 1(4)	 
24:   LDA   4, 1(4)	 
25:   ADD   0, 0, 1	
26:   LD   0, 0(0)	 
* Stack Push
27:   ST   0, 0(4)	 
28:   LDA   4, -1(4)	 
* Stack Pop
29:   LD   0, 1(4)	 
30:   LDA   4, 1(4)	 
31:   ST   0, -3(5)	 Storing Local Var
32:   LD   0, 3(5)	 Loading param
* Stack Push
33:   ST   0, 0(4)	 
34:   LDA   4, -1(4)	 
35:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
36:   ST   0, 0(4)	 
37:   LDA   4, -1(4)	 
* Stack Pop
38:   LD   2, 1(4)	 
39:   LDA   4, 1(4)	 
* Stack Pop
40:   LD   1, 1(4)	 
41:   LDA   4, 1(4)	 
42:   ADD   0, 1, 2	
* Stack Push
43:   ST   0, 0(4)	 
44:   LDA   4, -1(4)	 
* Stack Pop
45:   LD   0, 1(4)	 
46:   LDA   4, 1(4)	 
47:   ST   0, -1(5)	 Storing Local Var
48:   LD   0, -1(5)	 Loading local Var
* Stack Push
49:   ST   0, 0(4)	 
50:   LDA   4, -1(4)	 
51:   LD   0, 2(5)	 Loading param
* Stack Push
52:   ST   0, 0(4)	 
53:   LDA   4, -1(4)	 
* Stack Pop
54:   LD   2, 1(4)	 
55:   LDA   4, 1(4)	 
* Stack Pop
56:   LD   1, 1(4)	 
57:   LDA   4, 1(4)	 
58:   SUB   0, 1, 2	
59:   JLT   0, 2(7)	 
60:   LDC   0, 0(0)	 
61:   LDA   7, 1(7)	 
62:   LDC   0, 1(0)	 
* Stack Push
63:   ST   0, 0(4)	 
64:   LDA   4, -1(4)	 
* Stack Pop
65:   LD   0, 1(4)	 
66:   LDA   4, 1(4)	 
* Line here will be backfilled
* Start of while body
68:   LD   0, -1(5)	 Loading local Var
* Stack Push
69:   ST   0, 0(4)	 
70:   LDA   4, -1(4)	 
71:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
72:   LD   1, 1(4)	 
73:   LDA   4, 1(4)	 
74:   ADD   0, 0, 1	
75:   LD   0, 0(0)	 
* Stack Push
76:   ST   0, 0(4)	 
77:   LDA   4, -1(4)	 
78:   LD   0, -3(5)	 Loading local Var
* Stack Push
79:   ST   0, 0(4)	 
80:   LDA   4, -1(4)	 
* Stack Pop
81:   LD   2, 1(4)	 
82:   LDA   4, 1(4)	 
* Stack Pop
83:   LD   1, 1(4)	 
84:   LDA   4, 1(4)	 
85:   SUB   0, 1, 2	
86:   JLT   0, 2(7)	 
87:   LDC   0, 0(0)	 
88:   LDA   7, 1(7)	 
89:   LDC   0, 1(0)	 
* Stack Push
90:   ST   0, 0(4)	 
91:   LDA   4, -1(4)	 
* Stack Pop
92:   LD   0, 1(4)	 
93:   LDA   4, 1(4)	 
* Line here will be backfilled
* Start of if body
95:   LD   0, -1(5)	 Loading local Var
* Stack Push
96:   ST   0, 0(4)	 
97:   LDA   4, -1(4)	 
98:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
99:   LD   1, 1(4)	 
100:   LDA   4, 1(4)	 
101:   ADD   0, 0, 1	
102:   LD   0, 0(0)	 
* Stack Push
103:   ST   0, 0(4)	 
104:   LDA   4, -1(4)	 
* Stack Pop
105:   LD   0, 1(4)	 
106:   LDA   4, 1(4)	 
107:   ST   0, -3(5)	 Storing Local Var
108:   LD   0, -1(5)	 Loading local Var
* Stack Push
109:   ST   0, 0(4)	 
110:   LDA   4, -1(4)	 
* Stack Pop
111:   LD   0, 1(4)	 
112:   LDA   4, 1(4)	 
113:   ST   0, -2(5)	 Storing Local Var
* Backfill line
94:   JEQ   0, 19(7)	 If statement jump
* End of if statement body
114:   LD   0, -1(5)	 Loading local Var
* Stack Push
115:   ST   0, 0(4)	 
116:   LDA   4, -1(4)	 
117:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
118:   ST   0, 0(4)	 
119:   LDA   4, -1(4)	 
* Stack Pop
120:   LD   2, 1(4)	 
121:   LDA   4, 1(4)	 
* Stack Pop
122:   LD   1, 1(4)	 
123:   LDA   4, 1(4)	 
124:   ADD   0, 1, 2	
* Stack Push
125:   ST   0, 0(4)	 
126:   LDA   4, -1(4)	 
* Stack Pop
127:   LD   0, 1(4)	 
128:   LDA   4, 1(4)	 
129:   ST   0, -1(5)	 Storing Local Var
130:   LDC   7, 48(0)	 Jump back to top of while
* Backfill line
67:   JEQ   0, 63(7)	 Jump out of while
* End of while body
* Start of code to return with value
131:   LD   0, -2(5)	 Loading local Var
* Stack Push
132:   ST   0, 0(4)	 
133:   LDA   4, -1(4)	 
* Store return value into reg 3
* Stack Pop
134:   LD   3, 1(4)	 
135:   LDA   4, 1(4)	 
136:   LDA   4, 4(5)	 Reset stack pointer to before the frame
137:   LD   0, 0(5)	 Load return address into reg 0
138:   LD   5, 1(5)	 Load old FP into FP
* Stack Push
139:   ST   3, 0(4)	 
140:   LDA   4, -1(4)	 
141:   LDA   7, 0(0)	 Jump back to return address
* End of code to return with value
* Start of code return no value
142:   LDA   4, 4(5)	 Reset stack pointer to before the frame
143:   LD   0, 0(5)	 Load return address into reg 0
144:   LD   5, 1(5)	 Load old FP into FP
145:   LDA   7, 0(0)	 Jump back to return address
* End of code return no value
* Start of function sort
146:   LD   0, 3(5)	 Loading param
* Stack Push
147:   ST   0, 0(4)	 
148:   LDA   4, -1(4)	 
* Stack Pop
149:   LD   0, 1(4)	 
150:   LDA   4, 1(4)	 
151:   ST   0, -1(5)	 Storing Local Var
152:   LD   0, -1(5)	 Loading local Var
* Stack Push
153:   ST   0, 0(4)	 
154:   LDA   4, -1(4)	 
155:   LD   0, 2(5)	 Loading param
* Stack Push
156:   ST   0, 0(4)	 
157:   LDA   4, -1(4)	 
158:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
159:   ST   0, 0(4)	 
160:   LDA   4, -1(4)	 
* Stack Pop
161:   LD   2, 1(4)	 
162:   LDA   4, 1(4)	 
* Stack Pop
163:   LD   1, 1(4)	 
164:   LDA   4, 1(4)	 
165:   SUB   0, 1, 2	
* Stack Push
166:   ST   0, 0(4)	 
167:   LDA   4, -1(4)	 
* Stack Pop
168:   LD   2, 1(4)	 
169:   LDA   4, 1(4)	 
* Stack Pop
170:   LD   1, 1(4)	 
171:   LDA   4, 1(4)	 
172:   SUB   0, 1, 2	
173:   JLT   0, 2(7)	 
174:   LDC   0, 0(0)	 
175:   LDA   7, 1(7)	 
176:   LDC   0, 1(0)	 
* Stack Push
177:   ST   0, 0(4)	 
178:   LDA   4, -1(4)	 
* Stack Pop
179:   LD   0, 1(4)	 
180:   LDA   4, 1(4)	 
* Line here will be backfilled
* Start of while body
182:   LD   0, 4(5)	 Loading param
* Stack Push
183:   ST   0, 0(4)	 
184:   LDA   4, -1(4)	 
185:   LD   0, -1(5)	 Loading local Var
* Stack Push
186:   ST   0, 0(4)	 
187:   LDA   4, -1(4)	 
188:   LD   0, 2(5)	 Loading param
* Stack Push
189:   ST   0, 0(4)	 
190:   LDA   4, -1(4)	 
* Function Call
* Stack Push
191:   ST   5, 0(4)	 
192:   LDA   4, -1(4)	 
193:   LDC   0, 199(0)	 Load pre-calculated return address into reg 0 to be pushed onto stack
* Stack Push
194:   ST   0, 0(4)	 
195:   LDA   4, -1(4)	 
196:   LDA   5, 1(4)	 Update Frame Pointer
197:   LDA   4, -3(4)	 Increase the Stack Pointer to after the local vars
* Stack Pop
199:   LD   0, 1(4)	 
200:   LDA   4, 1(4)	 
201:   ST   0, -2(5)	 Storing Local Var
202:   LD   0, -2(5)	 Loading local Var
* Stack Push
203:   ST   0, 0(4)	 
204:   LDA   4, -1(4)	 
205:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
206:   LD   1, 1(4)	 
207:   LDA   4, 1(4)	 
208:   ADD   0, 0, 1	
209:   LD   0, 0(0)	 
* Stack Push
210:   ST   0, 0(4)	 
211:   LDA   4, -1(4)	 
* Stack Pop
212:   LD   0, 1(4)	 
213:   LDA   4, 1(4)	 
214:   ST   0, -3(5)	 Storing Local Var
215:   LD   0, -2(5)	 Loading local Var
* Stack Push
216:   ST   0, 0(4)	 
217:   LDA   4, -1(4)	 
218:   LD   0, -1(5)	 Loading local Var
* Stack Push
219:   ST   0, 0(4)	 
220:   LDA   4, -1(4)	 
221:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
222:   LD   1, 1(4)	 
223:   LDA   4, 1(4)	 
224:   ADD   0, 0, 1	
225:   LD   0, 0(0)	 
* Stack Push
226:   ST   0, 0(4)	 
227:   LDA   4, -1(4)	 
228:   LD   0, -2(5)	 Loading local Var
* Stack Push
229:   ST   0, 0(4)	 
230:   LDA   4, -1(4)	 
231:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
232:   LD   1, 1(4)	 
233:   LDA   4, 1(4)	 
234:   ADD   0, 0, 1	
* Stack Pop
235:   LD   1, 1(4)	 
236:   LDA   4, 1(4)	 
237:   ST   1, 0(0)	 store local variable [] a
238:   LD   0, -1(5)	 Loading local Var
* Stack Push
239:   ST   0, 0(4)	 
240:   LDA   4, -1(4)	 
241:   LD   0, -3(5)	 Loading local Var
* Stack Push
242:   ST   0, 0(4)	 
243:   LDA   4, -1(4)	 
244:   LD   0, -1(5)	 Loading local Var
* Stack Push
245:   ST   0, 0(4)	 
246:   LDA   4, -1(4)	 
247:   LD   0, 4(5)	 Loading param[]'s reference
* Stack Pop
248:   LD   1, 1(4)	 
249:   LDA   4, 1(4)	 
250:   ADD   0, 0, 1	
* Stack Pop
251:   LD   1, 1(4)	 
252:   LDA   4, 1(4)	 
253:   ST   1, 0(0)	 store local variable [] a
254:   LD   0, -1(5)	 Loading local Var
* Stack Push
255:   ST   0, 0(4)	 
256:   LDA   4, -1(4)	 
257:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
258:   ST   0, 0(4)	 
259:   LDA   4, -1(4)	 
* Stack Pop
260:   LD   2, 1(4)	 
261:   LDA   4, 1(4)	 
* Stack Pop
262:   LD   1, 1(4)	 
263:   LDA   4, 1(4)	 
264:   ADD   0, 1, 2	
* Stack Push
265:   ST   0, 0(4)	 
266:   LDA   4, -1(4)	 
* Stack Pop
267:   LD   0, 1(4)	 
268:   LDA   4, 1(4)	 
269:   ST   0, -1(5)	 Storing Local Var
270:   LDC   7, 152(0)	 Jump back to top of while
* Backfill line
181:   JEQ   0, 89(7)	 Jump out of while
* End of while body
* Start of code return no value
271:   LDA   4, 4(5)	 Reset stack pointer to before the frame
272:   LD   0, 0(5)	 Load return address into reg 0
273:   LD   5, 1(5)	 Load old FP into FP
274:   LDA   7, 0(0)	 Jump back to return address
* End of code return no value
* Start of function main
275:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
276:   ST   0, 0(4)	 
277:   LDA   4, -1(4)	 
* Stack Pop
278:   LD   0, 1(4)	 
279:   LDA   4, 1(4)	 
280:   ST   0, -1(5)	 Storing Local Var
281:   LD   0, -1(5)	 Loading local Var
* Stack Push
282:   ST   0, 0(4)	 
283:   LDA   4, -1(4)	 
284:   LDC   0, 10(0)	 Load constant: 10
* Stack Push
285:   ST   0, 0(4)	 
286:   LDA   4, -1(4)	 
* Stack Pop
287:   LD   2, 1(4)	 
288:   LDA   4, 1(4)	 
* Stack Pop
289:   LD   1, 1(4)	 
290:   LDA   4, 1(4)	 
291:   SUB   0, 1, 2	
292:   JLT   0, 2(7)	 
293:   LDC   0, 0(0)	 
294:   LDA   7, 1(7)	 
295:   LDC   0, 1(0)	 
* Stack Push
296:   ST   0, 0(4)	 
297:   LDA   4, -1(4)	 
* Stack Pop
298:   LD   0, 1(4)	 
299:   LDA   4, 1(4)	 
* Line here will be backfilled
* Start of while body
301:   LD   0, -1(5)	 Loading local Var
* Stack Push
302:   ST   0, 0(4)	 
303:   LDA   4, -1(4)	 
304:   IN   0, 0, 0	 getting user input
* Stack Push
305:   ST   0, 0(4)	 
306:   LDA   4, -1(4)	 
307:   LD   0, -1(5)	 Loading local Var
* Stack Push
308:   ST   0, 0(4)	 
309:   LDA   4, -1(4)	 
* Stack Pop
310:   LD   1, 1(4)	 
311:   LDA   4, 1(4)	 
312:   LDC   2, -9(0)	 
313:   ADD   0, 1, 2	calculate relative to GP array address
314:   ADD   0, 0, 6	calculate absolute array address
* Stack Pop
315:   LD   1, 1(4)	 
316:   LDA   4, 1(4)	 
317:   ST   1, 0(0)	 store global variable [] x
318:   LD   0, -1(5)	 Loading local Var
* Stack Push
319:   ST   0, 0(4)	 
320:   LDA   4, -1(4)	 
321:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
322:   ST   0, 0(4)	 
323:   LDA   4, -1(4)	 
* Stack Pop
324:   LD   2, 1(4)	 
325:   LDA   4, 1(4)	 
* Stack Pop
326:   LD   1, 1(4)	 
327:   LDA   4, 1(4)	 
328:   ADD   0, 1, 2	
* Stack Push
329:   ST   0, 0(4)	 
330:   LDA   4, -1(4)	 
* Stack Pop
331:   LD   0, 1(4)	 
332:   LDA   4, 1(4)	 
333:   ST   0, -1(5)	 Storing Local Var
334:   LDC   7, 281(0)	 Jump back to top of while
* Backfill line
300:   JEQ   0, 34(7)	 Jump out of while
* End of while body
335:   LDA   0, -9(6)	 load global var [] as param: x
* Stack Push
336:   ST   0, 0(4)	 
337:   LDA   4, -1(4)	 
338:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
339:   ST   0, 0(4)	 
340:   LDA   4, -1(4)	 
341:   LDC   0, 10(0)	 Load constant: 10
* Stack Push
342:   ST   0, 0(4)	 
343:   LDA   4, -1(4)	 
* Function Call
* Stack Push
344:   ST   5, 0(4)	 
345:   LDA   4, -1(4)	 
346:   LDC   0, 352(0)	 Load pre-calculated return address into reg 0 to be pushed onto stack
* Stack Push
347:   ST   0, 0(4)	 
348:   LDA   4, -1(4)	 
349:   LDA   5, 1(4)	 Update Frame Pointer
350:   LDA   4, -3(4)	 Increase the Stack Pointer to after the local vars
352:   LDC   0, 0(0)	 Load constant: 0
* Stack Push
353:   ST   0, 0(4)	 
354:   LDA   4, -1(4)	 
* Stack Pop
355:   LD   0, 1(4)	 
356:   LDA   4, 1(4)	 
357:   ST   0, -1(5)	 Storing Local Var
358:   LD   0, -1(5)	 Loading local Var
* Stack Push
359:   ST   0, 0(4)	 
360:   LDA   4, -1(4)	 
361:   LDC   0, 10(0)	 Load constant: 10
* Stack Push
362:   ST   0, 0(4)	 
363:   LDA   4, -1(4)	 
* Stack Pop
364:   LD   2, 1(4)	 
365:   LDA   4, 1(4)	 
* Stack Pop
366:   LD   1, 1(4)	 
367:   LDA   4, 1(4)	 
368:   SUB   0, 1, 2	
369:   JLT   0, 2(7)	 
370:   LDC   0, 0(0)	 
371:   LDA   7, 1(7)	 
372:   LDC   0, 1(0)	 
* Stack Push
373:   ST   0, 0(4)	 
374:   LDA   4, -1(4)	 
* Stack Pop
375:   LD   0, 1(4)	 
376:   LDA   4, 1(4)	 
* Line here will be backfilled
* Start of while body
378:   LD   0, -1(5)	 Loading local Var
* Stack Push
379:   ST   0, 0(4)	 
380:   LDA   4, -1(4)	 
* Stack Pop
381:   LD   1, 1(4)	 
382:   LDA   4, 1(4)	 
383:   LDC   2, -9(0)	 
384:   ADD   0, 1, 2	calculate relative to GP array address
385:   ADD   0, 0, 6	calculate absolute array address
386:   LD   0, 0(0)	 load global var[]: x
* Stack Push
387:   ST   0, 0(4)	 
388:   LDA   4, -1(4)	 
* Stack Pop
389:   LD   0, 1(4)	 
390:   LDA   4, 1(4)	 
391:   OUT   0, 0, 0	outputting value
392:   LD   0, -1(5)	 Loading local Var
* Stack Push
393:   ST   0, 0(4)	 
394:   LDA   4, -1(4)	 
395:   LDC   0, 1(0)	 Load constant: 1
* Stack Push
396:   ST   0, 0(4)	 
397:   LDA   4, -1(4)	 
* Stack Pop
398:   LD   2, 1(4)	 
399:   LDA   4, 1(4)	 
* Stack Pop
400:   LD   1, 1(4)	 
401:   LDA   4, 1(4)	 
402:   ADD   0, 1, 2	
* Stack Push
403:   ST   0, 0(4)	 
404:   LDA   4, -1(4)	 
* Stack Pop
405:   LD   0, 1(4)	 
406:   LDA   4, 1(4)	 
407:   ST   0, -1(5)	 Storing Local Var
408:   LDC   7, 358(0)	 Jump back to top of while
* Backfill line
377:   JEQ   0, 31(7)	 Jump out of while
* End of while body
* Start of code return no value
409:   LDA   4, 1(5)	 Reset stack pointer to before the frame
410:   LD   0, 0(5)	 Load return address into reg 0
411:   LD   5, 1(5)	 Load old FP into FP
412:   LDA   7, 0(0)	 Jump back to return address
* End of code return no value
11:   LDC   7, 275(0)	 Backfill function call to main
198:   LDC   7, 13(0)	 Backfill function call to minloc
351:   LDC   7, 146(0)	 Backfill function call to sort
