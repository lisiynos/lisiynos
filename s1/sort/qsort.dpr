var
  a : array[1..300000] of longint;
  n,i : longint;

procedure qsort(left,right:longint);
var m,temp,i,j:longint;
begin
  i:=left;
  j:=right;
  m:=a[(left + right) div 2];
  repeat
    while a[i]<m do inc(i);
    while m<a[j] do dec(j);
    if i<=j then begin
      temp:=a[i];
      a[i]:=a[j];
      a[j]:=temp;
      inc(i);
      dec(j);
    end;
  until i>j;
  if left<j then qsort(left,j);
  if i<right then qsort(i, right);
end;

begin
  assign(input,'qsort.in'); reset(input);
  assign(output,'qsort.out'); rewrite(output);
  { Чтение исходных данных }
  readln(n);
  for i:=1 to n do
    read(a[i]);
  { Сортировка }
  qsort(1,n);
  { Вывод }
  for i:=1 to n do write(a[i],' ');
end.
