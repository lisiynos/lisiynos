{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

{
Flash Pascal demo containing a MovieClipLoader that loads Flash Pascal logo and
the GNU head ("img" passed on the url) to do some animation with them.
(c) 2011 by Péter Gábor
}

program loadmoviedemo;

{$FRAME_WIDTH  200}
{$FRAME_HEIGHT 320}
{$FRAME_RATE 32}
{$BACKGROUND $efefff} //$efefff

uses Flash8Ext,Math,Key;
var
  loader:MovieClipLoader;
  bg,imgClip,img2:MovieClip;
  i3:MovieClip;
  img:string; {$NOTE "img" can be passed as url parameter}
  t:textfield;
  counter:integer;

procedure doEnterFrame; // makes the animation frame by frame
begin
  if counter=100 then counter:=1 else counter:=counter+1;
  // animate imgClip
  imgClip._alpha:=100-counter;
  imgClip._x:=counter*2;
  imgClip._y:=counter*2;
  imgClip._width:=200-counter*2;
  imgClip._height:=200-counter*2;
  // animate img2
  img2._alpha:=counter;
  img2._width:=counter*2;
  img2._height:=counter*2;
  //animate i3
  i3._x:=i3._x+(random*10-5);
  i3._y:=i3._y+(random*10-5);
  if i3._x<0 then i3._x:=0;
  if i3._x>121 then i3._x:=120;
  if i3._y<0 then i3._y:=0;
  if i3._y>121 then i3._y:=120;
end;

procedure onLoadInit(target:MovieClip);  // set up defaults for loaded targets before any action taken
begin
  if target=img2 then begin
    img2._x:=1;
    img2._y:=1;
    img2._width:=1;
    img2._height:=1;
  end else
  if target=imgClip then begin
    imgClip._x:=1;
    imgClip._y:=1;
    imgClip._width:=200;
    imgClip._height:=200;
  end else
  if target=i3 then begin
    i3._x:=60;
    i3._y:=60;
    i3._width:=80;
    i3._height:=80;
  end else
  if target=bg then begin
    bg._width:=200;
    bg._height:=200;
  end;
  counter:=1;
  _root.onEnterFrame:=doEnterFrame; // and start animation
end;

procedure onKeyDown;
begin
  t.background:=true;
  case getKeyCode of
    kbUp:t.backgroundColor:=t.backgroundColor+$200000;
    kbDown:t.backgroundColor:=t.backgroundColor-$200000;
    kbLeft:t.backgroundColor:=t.backgroundColor+$002000;
    kbRight:t.backgroundColor:=t.backgroundColor-$002000;
    kbPgUp: t.backgroundColor:=t.backgroundColor+$000020;
    kbPgDn: t.backgroundColor:=t.backgroundColor-$000020;
    kbHome: t.backgroundColor:=$ffffff;
    kbEnd: t.backgroundColor:=$000000;
  end;
end;

begin
  // setup the image loader
  loader:=MovieClipLoader.Create;
  loader.addListener(_root);

  // load a background
  bg:=MovieClip.Create(nil,'bg',1);
  loader.loadClip('FlashPascal.png',bg);

  //load another image
  imgClip:=MovieClip.Create(nil,'imgClip',2);
  loader.loadClip('FlashPascal.png',imgClip);
  // load one more
  img2:=MovieClip.Create(nil,'img2',3);
  loader.loadClip('FlashPascal.png',img2);

  //create a textfield where we will show the image name
  t:=TextField.Create(nil,'t',4,0,200,200,150);
  // check that the 'img' url parameter is given
  if img=nil then begin // is it defined?
    t.text:='img = <not given as url parameter>'; // no
    img:='FlashPascal.png';
  end else begin // yes!
    t.text:='img = '+img;
  end;
  // load it
  i3:=MovieClip.Create(nil,'i3',5);
  loader.loadClip(img,i3);

  t.wordwrap:=true;
  t.text:=t.text+#13'Flash Pascal demo containing a MovieClipLoader that loads '+
    'Flash Pascal logo and the GNU head ("img" passed on the url) '+
    'to do some animation with them.'#13+
    '(c) 2011 by Péter Gábor';

  // the keyboard is usable for something
  Key.addListener(_root);
end.
