{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Mouse; // Mouse - handling mouse events

function hideMouse:Integer external Mouse.hide; // hide the pointer
function showMouse:Integer external Mouse.show; // show the pointer
function removeMouseListener(listener:object):Boolean external Mouse.removeListener; // :S
procedure addMouseListener(listener:object) external Mouse.addListener; // :S

type

  TMouse=external class(Mouse)
    function hide:Integer; // show the pointer
    function removeListener(listener:object):Boolean;
    function show:Integer; // hide the pointer
    procedure addListener(listener:object);
  end;

  // a Mouse listener class must have these methods - TEMPLATE ONLY!
  MouseListener=external class(object)
    procedure onMouseDown;
    procedure onMouseMove;
    procedure onMouseUp;
    procedure onMouseWheel(delta:Integer{;scrollTarget:string});
  end;

var
  Mouse:TMouse;

implementation

end.
