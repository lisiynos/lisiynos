{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Math; // mathematical functions and constants

interface

const
  _E=2.71828182845905; // approximate value of e
  _LN10=2.302585092994046; // natural logarithm of 10: log e 10
  _LN2=0.6931471805599453; // natural logarithm of 10: log e 2
  _LOG10E=0.4342944819032518; // base 10 logarithm of e: log 10 e
  _LOG2E=1.442695040888963387; // base 2 logarithm of e: log 2 e
  _PI=3.141592653589793; // pi
  _SQRT1_2=0.7071067811865476; // square root of one-half
  _SQRT2=1.4142135623730951; // square root of 2

function abs(value:double):double external Math.abs;
function acos(value:double):double external Math.acos;
function asin(value:double):double external Math.asic;
function atan(value:double):double external Math.atan;
function atan2(value1:double;value2:double):double external Math.atan2;
function ceil(value:double):Integer external Math.ceil;
function cos(value:double):double external Math.cos;
function exp(value:double):double external Math.exp;
function floor(value:double):Integer external Math.floor;
function log(value:double):double external Math.log;
function max(value1:double;value2:double):double external Math.max;
function min(value1:double;value2:double):double external Math.min;
function pow(value1:double;value2:double):double external Math.pow;
function random:double external Math.random;
function round(value:double):double external Math.round;
function sin(value:double):double external Math.sin;
function sqrt(value:double):double external Math.sqrt;
function tan(value:double):double external Math.tan;

type

  TMath=external class(Math)
    property E:double; // 2.71828182845905 - approximate value of e
    property LN10:double; // 2.302585092994046 - natural logarithm of 10: log e 10
    property LN2:double; // 0.6931471805599453 - natural logarithm of 10: log e 2
    property LOG10E:double; // 0.4342944819032518 - base 10 logarithm of e: log 10 e
    property LOG2E:double; // 1.442695040888963387 - base 2 logarithm of e: log 2 e
    property PI:double; // 3.141592653589793 - pi
    property SQRT1_2:double; // 0.7071067811865476 - square root of one-half
    property SQRT2:double; // 1.4142135623730951 - square root of 2
{    function abs(value:double):double;
    function acos(value:double):double;
    function asin(value:double):double;
    function atan(value:double):double;
    function atan2(value1:double;value2:double):double;
    function ceil(value:double):Integer;
    function cos(value:double):double;
    function exp(value:double):double;
    function floor(value:double):Integer;
    function log(value:double):double;
    function max(value1:double;value2:double):double;
    function min(value1:double;value2:double):double;
    function pow(value1:double;value2:double):double;
    function random:double;
    function round(value:double):double;
    function sin(value:double):double;
    function sqrt(value:double):double;
    function tan(value:double):double;}
  end;

var
  Math:TMath; // to get the mathematical constants too

implementation

end.
