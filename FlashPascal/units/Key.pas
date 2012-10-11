{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Key; // Key - handling key events

interface


const // some scan code values returned by Key.getCode and getKeyCode
  kbALT=18;
  kbBACKSPACE=8;
  kbCAPSLOCK=20;
  kbCONTROL=17;
  kbDELETEKEY=46;
  kbDOWN=40;
  kbEND=35;
  kbENTER=13;
  kbESCAPE=27;
  kbHOME=36;
  kbINSERT=45;
  kbLEFT=37;
  kbPGDN=34;
  kbPGUP=33;
  kbRIGHT=39;
  kbSHIFT=16;
  kbSPACE=32;
  kbTAB=9;
  kbUP=38;

function getKeyAscii:Integer external Key.getAscii;
function getKeyCode:Integer external Key.getCode;
function isKeyAccessible: Boolean external Key.isAccessible;
function isKeyDown(code:Integer):Boolean external Key.isDown;
function isKeyToggled(code:Integer):Boolean external Key.isToggled;
procedure addKeyListener(listener:object) external Key.addListener; // :S
function removeKeyListener(listener:object):Boolean external Key.removeListener; // :S

type

  TKey=external class(Key)
  // properties - constants
    property ALT:Integer; // 18
    property BACKSPACE:Integer; // 8
    property CAPSLOCK:Integer; // 20
    property CONTROL:Integer; // 17
    property DELETEKEY:Integer; // 46
    property DOWN:Integer; // 40
    property END_:Integer as END; // 35
    property ENTER:Integer; // 13
    property ESCAPE:Integer; // 27
    property HOME:Integer; // 36
    property INSERT:Integer; // 45
    property LEFT:Integer; // 37
    property PGDN:Integer; // 34
    property PGUP:Integer; // 33
    property RIGHT:Integer; // 39
    property SHIFT:Integer; // 16
    property SPACE:Integer; // 32
    property TAB:Integer; // 9
    property UP:Integer; // 38
  // properties - key lock state
    //property _capsLock: Boolean as capsLock;
    //property _numLock: Boolean as numLock;
  // methods
    function getAscii:Integer;
    function getCode:Integer;
    function isAccessible: Boolean;
    function isDown(code:Integer):Boolean;
    function isToggled(code:Integer):Boolean;
    procedure addListener(listener:object);
    function removeListener(listener:object):Boolean;
  end;

  // a key listener class must have these methods - TEMPLATE ONLY!
  KeyListener=external class(object)
    procedure onKeyDown;
    procedure onKeyUp;
  end;

var
  Key:TKey;

implementation

end.
