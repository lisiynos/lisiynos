{$APPTYPE CONSOLE}

uses SysUtils;

var
  N,s : string; { Исходные данные }
  L,i,t : integer;
begin
  Assign(Input,'wordrot.in'); Reset(Input);
  Assign(Output,'wordrot.out'); Reset(Output);
  { Чтение исходных данных }
  readln(N); readln(s);
  { Вычисляем N mod L, L - длина строки s }
  L := length(s);
  t := 0; 
  for i:=1 to length(N) do 
    t := (t*10 + StrToInt(N[i])) mod L;
  { Выводим повёртнутое слово }
  for i:=L-t+1 to L do
    write (s[i]);
  for i:=1 to L-t do
    write (s[i]);
end.