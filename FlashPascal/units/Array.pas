{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Arrays; // manipulate arrays, don't use unless you really need an Array object

interface

type
  TArray=external class(Array)
    property CASEINSENSITIVE:Integer;
    property DESCENDING:Integer;
    property UNIQUESORT:Integer;
    property RETURNINDEXEDARRAY:Integer;
    property NUMERIC:Integer;
    property length_:Integer as length;// alias for length
    property len:Integer as length; // second alias for length
  //methods
    function push(value:TObject):Integer;
    function pop:TObject;
    function concat(value:TObject):TArray;
    function shift:TObject;
    function unshift(value:TObject):Integer;
    function slice(startIndex:Integer;endIndex:Integer):TArray;
    function join(delimiter:String):String;
    function splice(startIndex:Integer;deleteCount:Integer;value:TObject):TArray;
    function toString:String;
    function sort(compare:TObject;options:Integer):TArray;
    procedure reverse;
    function sortOn(key:TObject;options:TObject):TArray;
  end;

implementation

end.
