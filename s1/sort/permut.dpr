program Project11sdfasdf11;
var
i,n: longint;
f:text;
begin
assign(f,'permut.txt');
reset(f);
readln(f,n);
close(f);
assign(f,'permut1.txt');
for i:=1 to n do
write(f,i,' ');
close(f);
end.
