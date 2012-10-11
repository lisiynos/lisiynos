{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Strings; // manipulate strings, don't use unless you really need a String object

interface

type

  TString=external class(String)
    property length_:Integer as length;// alias for length
    property len:Integer as length; // second alias for length
    constructor Create(s:String); // create from native string
    function charAt(index:Integer):String;
    function charCodeAt(index:Integer):Integer;
    function concat(s:object{s2:object;s3:object}):String; // multiple parameters ?
    function concat2(s:object;s2:object):String as concat;
    function fromCharCode(code:Integer):String;
    function indexOf(value:String;startIndex:Integer):Integer;
    function lastIndexOf(value:String;startIndex:Integer):Integer;
    function slice(index1:Integer;index2:Integer):String;
    function split(delimiter:String;Limit:Integer):array of string;
    function substr(index1:Integer;index2:Integer):String;
    function substring(index1:Integer;index2:Integer):String;
    function toLowerCase:String;
    function toUpperCase:String;
    function valueOf:String; // return the value as native string
  end;

implementation

end.
