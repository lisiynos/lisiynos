{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Date; // retrieve date and time relative to the universal (UTC/GMT) or local time

interface

const
  // day of week values returned by getDay() and getUTCDay()
  Sunday=0;
  Monday=1;
  Tuesday=2;
  Wednesday=3;
  Thursday=4;
  Friday=5;
  Saturday=6;

type

  TDate=external class(Date)
    constructor Create; // initialized with the actual system time
    //constructor Create(year:Integer;month:Integer;date:Integer{day of month};hour:Integer;min:Integer;sec:Integer;ms:Integer); // initialized with the specified time
    //constructor CreateDate(year,month,date:Integer{day of month}); // initialized with the specified time
    //constructor CreateTime(year:Integer;month:Integer;date:Integer{day of month};hour:Integer;min:Integer;sec:Integer;ms:Integer); // initialized with the specified time
    function getFullYear:Integer;
    function getYear:Integer;
    function getMonth:Integer;
    function getDate:Integer; // day of month
    function getDay:Integer; // day of week
    function getHours:Integer;
    function getMinutes:Integer;
    function getSeconds:Integer;
    function getMilliseconds:Integer;
    function getUTCFullYear:Integer;
    function getUTCYear:Integer;
    function getUTCMonth:Integer;
    function getUTCDate:Integer; // day of month
    function getUTCDay:Integer;  // day of week
    function getUTCHours:Integer;
    function getUTCMinutes:Integer;
    function getUTCSeconds:Integer;
    function getUTCMilliseconds:Integer;
    procedure setFullYear(value:Integer);
    procedure setMonth(value:Integer);
    procedure setDate(value:Integer); // day of month
    procedure setHours(value:Integer);
    procedure setMinutes(value:Integer);
    procedure setSeconds(value:Integer);
    procedure setMilliseconds(value:Integer);
    procedure setUTCFullYear(value:Integer);
    procedure setUTCMonth(value:Integer);
    procedure setUTCDate(value:Integer); // day of month
    procedure setUTCHours(value:Integer);
    procedure setUTCMinutes(value:Integer);
    procedure setUTCSeconds(value:Integer);
    procedure setUTCMilliseconds(value:Integer);
    function getTime:Integer;
    procedure setTime(value:Integer);
    function getTimezoneOffset:Integer;
    procedure setYear(value:Integer);
    // Flash Lite 2.x
    function getLocaleLongDate:String;
    function getLocaleShortDate:String;
    function getLocaleTime:String;
    function UTC(year:Integer;month:Integer;date:Integer{day of month};hour:Integer;minute:Integer;sec:Integer;ms:Integer):Integer;
  end;

function UTC(year:Integer;month:Integer;date:Integer{day of month};hour:Integer;minute:Integer;sec:Integer;ms:Integer):Integer external Date.UTC;

implementation

end.
