{$APPTYPE CONSOLE}

uses SysUtils;

var 
  x, b : longint;
  s : string; { Результат преобразования }
begin
  Write('Введите число: '); Readln(x);
  Write('Введите основание системы счисления: '); Readln(b);  
  s := '';
  while x > 0 do begin
    s := IntToStr(x mod b) + s; { Приписываем очередную цифру к числу }
    x := x div b; { Делим на основание системы счисления }
  end;
  if s = '' then s := '0';
  writeln('Результат: ',s);
end.