{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

program binarybooleandemo;

{
Flash Pascal demo containing binary and boolean operations and displaying the results...
(c) 2011 by Péter Gábor
}

{$FRAME_WIDTH  400}
{$FRAME_HEIGHT 600}
{$BACKGROUND $efefff}

uses Flash8Ext;
  
var
  t:TextField;
  i:integer;
  b,c:boolean;

begin
  t:=TextField.Create(nil,'t',0,0,0,400,600);

  t.text:='Flash Pascal demo containing binary and boolean operations and'+#13+'displaying the results...'+#13+
    '(c) 2011 by Péter Gábor'+#13+#13;

//integer AND,NOT,XOR,OR
  i:=$ffffffff; // -1
  t.text:=t.text+
    'i = '+IntToStr(i)+' // $ffffffff'+#13+
    'i AND $0000ffff = '+IntToStr(i and $0000FFFF)+#13+ //
    'NOT i = '+IntToStr(not i)+#13; // 0
 
  i:=$80000001; // -1
  t.text:=t.text+
    'i = '+IntToStr(i)+' // $80000001'+#13+
    'i XOR $0000ffff = '+IntToStr(i xor $0000ffff)+#13+ //
    'i OR $ffff0000 = '+IntToStr(i or $ffff0000)+#13+#13; // 0

//integer SHL,SHR
  i:=$00000100; // 256
  t.text:=t.text+
    'i = '+IntToStr(i)+#13+ // 256
    'i SHL 8 = '+IntToStr(i shl 8)+#13+ // 65536
    'i SHR 8 = '+IntToStr(i shl 8)+#13+ // 1
    'i SHRI 8 = '+IntToStr(i shri 8)+#13+
    'i << 8 = '+IntToStr(i shl 8)+#13+ // 65536
    'i >>> 8 = '+IntToStr(i shl 8)+#13+ // 1
    'i >> 8 = '+IntToStr(i shri 8)+#13+#13;


//boolean NOT,XOR
  b:=true;
  c:=false;
  t.text:=t.text+
    'b = '+BoolToStr(b)+#13+
    'c = '+BoolToStr(c);
  t.text:=t.text+#13+'b AND c = ';
  if (b and c) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'NOT b = ';
  if (not b) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'NOT c = ';
  if (not c) then t.text:=t.text+'True' else t.text:=t.text+'False';
  
  t.text:=t.text+#13+'b XOR b = ';
  if (b xor b) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'b XOR c = ';
  if (b xor c) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'c XOR c = ';
  if (c xor c) then t.text:=t.text+'True' else t.text:=t.text+'False';

  t.text:=t.text+#13+'b OR b = ';
  if (b or b) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'b OR c = ';
  if (b or c) then t.text:=t.text+'True' else t.text:=t.text+'False';
  t.text:=t.text+#13+'c OR c = ';
  if (c or c) then t.text:=t.text+'True' else t.text:=t.text+'False';
end.

