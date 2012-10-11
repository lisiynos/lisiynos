unit Flash8;

interface

type
 TMethod=procedure of object;

 MovieClip=external class
  constructor Create(Parent:MovieClip; Name:string; Depth:integer) as Parent.createEmptyMovieClip;
  procedure removeMovieClip();
  procedure getURL(url,window:string);
  procedure clear;
  procedure lineStyle(width,color:integer);
  procedure beginGradientFill(fillType:string; colors,alphas,ratios:array of integer; matrix:TObject);
  procedure beginFill(color:integer);
  procedure moveTo(x,y:double);
  procedure lineTo(x,y:double);
  procedure curveTo(x1,y1,x2,y2:double);
  procedure endFill();
  procedure swapDepths(target:double);
  function getDepth:integer;
  property _x:integer;
  property _y:integer;
  property _width:integer;
  property _height:integer;
  property _xscale:double;
  property _yscale:double;
  procedure startDrag(lockCentre:boolean; Left,Right,Top,Bottom:integer);
  procedure stopDrag();
  property _parent:MovieClip;
  property onPress:TMethod;
  property onRelease:TMethod;
  property onReleaseOutside:TMethod;
  property onEnterFrame:TMethod;
 end;

 TextFormat=external class
  constructor Create(const FontName:string; Size:integer);
  property align:string;
  property color:integer;
  property size:integer;
  property bold:boolean;
 end;

 TextField=external class
  constructor Create(Parent:MovieClip; Name:string; depth,left,top,width,height:integer) as Parent.createTextField;
  procedure setTextFormat(Format:TextFormat);
  procedure removeTextField;
  property text:string;
  property background:boolean;
  property backgroundColor:integer;
 end;

 TMath=external class(Math)
//  function cos(a:double):double;
//  function sin(a:double):double;
  property PI:double;
 end;

 TKey = external class(Key)
   procedure addListener(listener: object);
   function removeListener(listener: object): Boolean;
   function getAscii: Integer;
   function getCode: Integer;
   function isAccessible: Boolean;
   function isDown(Code: Integer): Boolean;
   function isToggled(Code: Integer): Boolean;
   property capsLock: Boolean;
   property numLock: Boolean;
   property onKeyDown: TMethod;
   property onKeyUp: TMethod;
 end;

function cos(a:double):double external Math.cos;
function sin(a:double):double external Math.sin;
function random:double external Math.random;
function floor(a:double):integer external Math.floor;
function KeyDown(key:integer):boolean external Key.isDown;

const
 SHIFT=16;

var
 _root: MovieClip; // static...
 Math : TMath;
 Key  : TKey;

implementation

end.
