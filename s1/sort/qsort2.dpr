program sSSf;
var
a:array[1..300000] of longint;
n,i:longint;
f:text;
procedure qsort(left,right:longint);
var
m,temp,i,j:longint;
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
    end;
  until i>j ;
  if left<j then qsort(left,j);
  if i<right then qsort(i, right);
end;
begin
assign(f,'qsortt.txt');
reset(f);
readln(f,n);
for i:=1 to n do
read(f,a[i]);
close(f);
assign(f,'qsort111.txt');
rewrite(f);
//qsort(1,n);
for i:=1 to n do write(f,a[i],' ');
close(f);
end.
