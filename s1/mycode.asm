#fasm#

org  100h ; ����������������� ����� �� 'h'      
  ; 100h = 1*16*16 = 256 ����
  ; 256 ���� �������� PSP
  ; ���������� � ������� ���������, 
  ; ��������, � ���������� ��������� ������.

MOV AX,5 ; ���������� 5 � ������� AX 
MOV BL,16h ; L - Low - ������� ��������
MOV BH,01011b ; H - High - ������� �������� 
MOV DX,014o ; 8-������  
MOV [MyVar],AL ; �������� ���� ���� 
 ; �� AL � ������ �� ������ MyVar
MOV [MyVar+1],AH  

MOV [BX],AX    

ADD AL,BL ; ADDition - �������� ADD Op1,Op2
 ; Op1 += Op2
SUB AL,BH ; ��������� SUB Op1,Op2
 ; Op1 -= Op2
MUL BH ; MUL Op1 - ���������
 ; AX = AL * Op1
DIV BH ; DIV Op1 - �������  
 ; AL = AX div Op1  16 ������ ������� �� 8-������
 ; AH = AX mod Op1   
;
; ������� � ������� �������� �����:
; 
; 11011 |101
; 101   -----
;  011  |101 -> �������
;  000  
;   111 
;   101
;   010 -> ������� 

MOV BL,5
MOV AL,1
M1:
ADD AL,AL
DEC BL ; ��������� �� 1, BL--
JNZ M1

PUSHA ; PUSH ALL
POPA  ; POP ALL

 

INT 21h 

ret ; ret=return 
; ������� �������� �� ������������ 
; ��� ���������       

MyVar DB 1,2




