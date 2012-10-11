{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

{
Flash Pascal demo for testing keys
(c) 2011 by Péter Gábor'
}

program keydemo;

{$FRAME_WIDTH  200}
{$FRAME_HEIGHT 200}
{$BACKGROUND $efefff}

uses Flash8Ext,Key;

type
  TKeyListener=class
    constructor Create;
    procedure onKeyDown;
    procedure onKeyUp;
  end;

var
  t,tt:TextField;
  A,C,CL,NL:string;

constructor TKeyListener.Create;
begin
end;

procedure TKeyListener.onKeyDown;
var
  i:Integer;
  s:string;
begin

  i:=Key.getAscii;
  A:=Chr(i)+' ('+IntToStr(i)+')';
  tt.text:='getAscii   = '+A+#13;

  i:=Key.getCode;
  case i of
    kbALT       : s:='ALT';
    kbBACKSPACE : s:='BACKSPACE';
    kbCAPSLOCK  : s:='CAPSLOCK';
    kbCONTROL   : s:='CONTROL';
    kbDELETEKEY : s:='DELETEKEY';
    kbDOWN      : s:='DOWN';
    Key.END_    : s:='END'; // kbEND;
    kbENTER     : s:='ENTER';
    kbESCAPE    : s:='ESCAPE';
    kbHOME      : s:='HOME';
    kbINSERT    : s:='INSERT';
    kbLEFT      : s:='LEFT';
    kbPGDN      : s:='PGDN';
    kbPGUP      : s:='PGUP';
    kbRIGHT     : s:='RIGHT';
    kbSHIFT     : s:='SHIFT';
    kbSPACE     : s:='SPACE';
    kbTAB       : s:='TAB';
    kbUP        : s:='UP';
  else s:='';
  end;

  C:=IntToStr(i);
  tt.text:=tt.text+'getCode   = '+s+' ('+C+')'#13;

end;

procedure TKeyListener.onKeyUp;
begin
  A:=IntToStr(Key.getAscii);
  C:=IntToStr(Key.getCode);
  tt.text:='getAscii   = '#13'getCode   = '#13;
end;

var
  KL:TKeyListener;

begin
  t:=TextField.Create(nil,'t',1,0,0,200,100);
  t.wordWrap:=True;
  t.text:='Flash Pascal demo for testing keys'+#13+'(c) 2011 by Péter Gábor';

  tt:=TextField.Create(nil,'t',2,0,100,200,100);
  tt.wordWrap:=True;
  tt.text:='getAscii   = '+#13+
    'getCode   = '+#13;

  KL:=TKeyListener.Create;

  Key.addListener(KL);
  //addKeyListener(KL);

end.