#fasm#

org  100h ; Шестнадцатеричное числа на 'h'      
  ; 100h = 1*16*16 = 256 байт
  ; 256 байт занимает PSP
  ; Информация о запуске программы, 
  ; например, о параметрах командной строки.

MOV AX,5 ; Записываем 5 в регистр AX 
MOV BL,16h ; L - Low - младшая половина
MOV BH,01011b ; H - High - старшая половина 
MOV DX,014o ; 8-ричная  
MOV [MyVar],AL ; Записать один байт 
 ; из AL в память по адресу MyVar
MOV [MyVar+1],AH  

MOV [BX],AX    

ADD AL,BL ; ADDition - Сложение ADD Op1,Op2
 ; Op1 += Op2
SUB AL,BH ; Вычитание SUB Op1,Op2
 ; Op1 -= Op2
MUL BH ; MUL Op1 - Умножение
 ; AX = AL * Op1
DIV BH ; DIV Op1 - Деление  
 ; AL = AX div Op1  16 битное делится на 8-битное
 ; AH = AX mod Op1   
;
; Деление в столбик двоичных чисел:
; 
; 11011 |101
; 101   -----
;  011  |101 -> частное
;  000  
;   111 
;   101
;   010 -> Остаток 

MOV BL,5
MOV AL,1
M1:
ADD AL,AL
DEC BL ; Уменьшить на 1, BL--
JNZ M1

PUSHA ; PUSH ALL
POPA  ; POP ALL

 

INT 21h 

ret ; ret=return 
; Команда возврата из подпрограммы 
; или программы       

MyVar DB 1,2




