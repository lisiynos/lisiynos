program bubble;

{$APPTYPE CONSOLE}

uses
  SysUtils;
 var n,i,j,c:integer;
 a : array [1..5000] of int64;
 begin
 assign(Input,'bubble.in');
 assign(Output,'bubble.out');
 reset (Input);
 rewrite(Output);
 readln (n);
 for i:= 1 to n do
   read (a[i]);
   close(Input);
 for i:=1 to (n-1) do  begin
   for j:=(n-1) downto i do
     if  a[j] > a[j+1]  then begin
       c:= a[j];
       a[j]:= a[j+1];
       a[j+1]:=c;
     end;
 end;
 for j:= 1 to n do
 write (a[j], ' ') ;
 close (Output);
end.
 