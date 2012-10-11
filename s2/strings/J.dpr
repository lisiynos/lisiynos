program projJ;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  mas: array[char] of char;
  s1, s2, ans1, ans2, now1, now2: string;
  max, l, i, j: integer;

begin
reset(input,'substring.in');
rewrite(output,'substring.out');
    readln(s1);
    readln(s2);
    max := 0;
    ans1 := '';
    ans2 := '';
    l := length(s1);
    for i := 1 to l do begin
        fillchar(mas, sizeof(mas), 0);
        j := 0;
        now1 := '';
        now2 := '';
        while ((i + j < l + 1)and((mas[s1[i + j]] = s2[j + 1])or(mas[s1[i + j]] = ''))) do begin
            now1 := now1 + s1[i + j];
            now2 := now2 + s2[j + 1];
            mas[s1[i + j]] := s2[j + 1];
            inc(j);
        end;
        if(j > max)then begin
            max := j;
            ans1 := now1;
            ans2 := now2;
        end;
    end;
    writeln(ans1);
    writeln(ans2);
end.
