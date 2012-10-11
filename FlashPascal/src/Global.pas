{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Global;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

{$I FlashPascal.inc}

type
 TSymbol=class
  name      :string;  // upper case name
  realName  :string;  // the real name as in type or var definition
  NextSymbol:TSymbol; // linked list of symbols
 {$IFDEF MEMCHECK}
  constructor Create;
  destructor Destroy; override;
 {$ENDIF}
 end;

 PScope=^TScope;
 TScope=record
  Symbol:TSymbol;
  Next  :PScope;
 end;


function StrLess(const Str,Value:string):boolean;
procedure FinalProc;
procedure FatalError(const Msg,Fnc:string); // error message, function id

{$IFDEF MEMCHECK}
var
  sCount : Integer;
  eCount : Integer;
{$ENDIF}

const
  VersionString='version 0.8 (prealpha)';

var
  Path    : string; // path to the program source file
  LibPath : string; // default path to the units
  DisplayErrors         :Boolean; // -e display error messages on programming errors
  PauseBeforeExit       :Boolean; // -p pause before exit (unused variable)
  DisplaySourceOnErrors :Boolean; // -s show source line on errors
  DisplayWarnings       :Boolean; // -w display warning messages on possible mistakes
  UncompressedOutput    :Boolean; // -u do not compress the swf file (for special needs if any)
  HtmlTestPageOutput    :Boolean; // -t generate html file for testing
  DisplayNotes          :Boolean; // -n display notes stored in the source
  //UseRegisterVariables  :Boolean; // -r use registers for variables where it is possible
  SyntaxCheckingOnly    :Boolean; // -x syntax checking only, no files written

implementation

// compare two litteral integers
function StrLess(const Str,Value:string):boolean;
var
 i,l:integer;
begin
 l:=Length(Str);
 if l=Length(Value) then begin
  for i:=1 to l do begin
   if Str[i]>Value[i] then begin
    Result:=False;
    exit;
   end;
  end;
  Result:=True;
 end else begin
  Result:=l<Length(Value);
 end;
end;

// pause before exit or not
procedure FinalProc;
begin
  if PauseBeforeExit then ReadLn else WriteLn;
end;

// non pascal related errors such as file IO and others
procedure FatalError(const Msg,Fnc:string); // error message, function id
begin
  Write('Fatal: ',Msg);
  {if Fnc<>'' then WriteLn(' (',Fnc,')') else} WriteLn;
  Halt(255);// fatal error
end;

function urlEncode(s:string):string;
{URL Encoding of special characters
;   %3B
?   %3F
/   %2F
:   %3A
#   %23
&   %26
=   %3D
+   %2B
$   %24
,   %2C
<space>   %20 or +
%   %25
<   %3C
>   %3E
~   %7E}
var i:integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      ';': result:=result+'%3B';
      '?': result:=result+'%3F';
      '/': result:=result+'%2F';
      ':': result:=result+'%3A';
      '#': result:=result+'%23';
      '&': result:=result+'%26';
      '=': result:=result+'%3D';
      '+': result:=result+'%2B';
      '$': result:=result+'%24';
      ',': result:=result+'%2C';
      ' ': result:=result+'%20'; // or + {deprecated}
      '%': result:=result+'%25';
      '<': result:=result+'%3C';
      '>': result:=result+'%3E';
      '~': result:=result+'%7E';
      else result:=result+s[i];
    end;
end;

{$IFDEF MEMCHECK}
constructor TSymbol.Create;
begin
 inc(sCount);
end;

destructor TSymbol.Destroy;
begin
// WriteLn(realName,'->',ClassName);
 dec(sCount);
end;
{$ENDIF}

end.
