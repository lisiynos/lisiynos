program asdfasdf;
var
buf:string;
a:array[1..5000] of string;
n,i,i2,c:longint;
f:text;
    function strtoint(s:string):longint;
    var
    c,c1:longint;
    begin
      val(s,c,c1);
      strtoint:=c;
    end;
begin
assign(f,'pairs.txt');
reset(f);
readln(f,n);
for i:=1 to n do readln(f,a[i]);
close(f);
assign(f,'pairs1.txt');
rewrite(f);
for i:=2 to n do
begin
  for i2:=n downto i do
  begin
  if strtoint(a[i2][1])<strtoint(a[i2-1][1]) then begin
  buf:=a[i2];
  a[i2]:=a[i2-1];
  a[i2-1]:=buf;
  end;
  end;
end;
for i:=1 to n do writeln(f,a[i]);
close(f);
end.


