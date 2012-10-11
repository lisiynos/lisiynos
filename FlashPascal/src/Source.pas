{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Source;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

{$I FlashPascal.inc}

uses
 Global;

type
 TSource=class
//  _n:Boolean;
  _FileName :string;  // name of file we are compiling
  Handle   :TextFile; // source file
  Line     :integer;  // current line
  Index    :integer;  // current char in line
  Src      :string;   // current readed line
  SrcToken :string;   // current token
  LastChar :char;     // last readed char
  NextChar :char;     // current readed char (next in token)
  Token    :string;   // current token (uppercase for keywords, without quotes for litteral strings)
  constructor Create(const FileName:string);
  destructor Destroy; override;
  function StrToInt(const Str:string):integer;
  function BitsCount(const Str:string):integer;
  procedure Error(const Msg,Fnc:string);
  procedure Warning(const Msg,Fnc:string);
  function ReadChar:char;
  function SkipChar(c:char):boolean;
  function StringConst:string;
  function AsciiChar:string;
 end;

implementation

constructor TSource.Create(const FileName:string);
begin
 _FileName:=FileName;
{$I-}
 AssignFile(Handle,FileName);
 Reset(Handle);// not existing or locked files raised exception here...
 if IOResult<>0 then FatalError('Cannot open file '+_FileName,'Source');
{$I+}
 Src  :='';
 Line :=1;
 Index:=0;
 NextChar:=' ';
 ReadChar;
end;

destructor TSource.Destroy;
begin
{$I-}
 CloseFile(Handle);
{$I+}
end;

// convert Str to an integer
function TSource.StrToInt(const Str:string):integer;
var
 e:integer;
begin
 Val(Str,Result,e);
 if e>0 then Error('Invalid number','StrToInt'); // 'Invalid number '+str
end;

// how many bits to store this numeric ?
function TSource.BitsCount(const Str:string):integer;
begin
 case Length(Str) of
  0    : Error('Invalid number','BitsCount');
  1..2 : Result:=8;
  3    : if StrLess(Str,'255') then Result:=8 else Result:=16;
  4    : Result:=16;
  5    : if StrLess(Str,'65535') then Result:=16 else Result:=32;
  else   if StrLess(Str,'4294967295') then Result:=32 else Error('Cardinal overflow','BitsCount');
 end;
end;

procedure TSource.Error(const Msg,Fnc:string); // error message, function id
var
  i:integer;
  ch:Char;
begin
  if DisplayErrors then begin
    Write(_Filename,'(',Line,',',Index-Length(SrcToken),') Error: ',Msg);
    {if Fnc<>'' then WriteLn(' (',Fnc,')') else} WriteLn;
    if DisplaySourceOnErrors then begin
      //Ch:=#0;
      {$I-}
      while(not EOLn(Handle))do begin // get the full line of source code
        Read(Handle,Ch);
        if IOResult<>0 then FatalError('Cannot read file '+_FileName,'Error');
        Src:=Src+Ch;
      end;
      {$I+}
      WriteLn(Src);
      for i:=1 to Index-1-Length(SrcToken) do Write(' ');
      for i:=1 to Length(SrcToken) do Write('^');
    end;
  end;
  Halt(1);// programming error
end;

procedure TSource.Warning(const Msg,Fnc:string); // warning message, function id
begin
  if DisplayWarnings then begin
    Write(_Filename,'(',Line,',',Index-Length(SrcToken),') Warning: ',Msg);
    {if Fnc<>'' then WriteLn(' (',Fnc,')') else} WriteLn;
  end;
end;
(*
procedure TSource.Note(const Msg:string); // message
begin
  if DisplayNotes then WriteLn(_Filename,'('{,Line,',',Index-Length(SrcToken),}') Note: ',Msg);
end;
*)
// read one char
function TSource.ReadChar:char;
  procedure NewLine;
  begin
    Inc(Line);
    Index:=0;
  end;
begin
  if NextChar=#27 then begin
    Inc(Index);
    SrcToken:=' '; //to show the buggy source correctly
    Error('Unexpected end of file','ReadChar');
  end;
  SrcToken:=SrcToken+NextChar;
  LastChar:=NextChar;
  Result:=NextChar;
{$I-}
  if Eof(Handle) then NextChar:=#27 else Read(Handle,NextChar);
  if IOResult<>0 then FatalError('Cannot read file '+_FileName,'ReadChar');
{$I+}
  {$IFDEF LOG}Write(NextChar);{$ENDIF}
//******************************************************************************
//* support of all kind of new line markers of all kind of operating systems :)
//******************************************************************************
  if(NextChar=#10)and(LastChar=#13)then begin {Windows}
    NewLine;
  end else if(NextChar=#10)and(LastChar<>#13)then begin {Unix/Linux}
    NewLine;
  end else begin
    if(LastChar=#13){and(NextChar<>#10)}then NewLine; {MacOSX's new line checking - must be here}
//******************************************************************************
    Inc(Index);
    if NextChar<>#27 then begin
     if Index=1 then Src:=NextChar else Src:=Src+NextChar;
{    end else begin // not to show #27
      if Index=1 then Src:=#32 else Src:=Src+#32;}
    end;
  end;
end;

// skip one char ?
function TSource.SkipChar(c:char):boolean;
begin
 Result:=NextChar=c;
 if Result then ReadChar;
end;

// read a quoted string
function TSource.StringConst:string;
var
 done:boolean;
begin
 ReadChar; // ''''
 Result:='';
 repeat
  while NextChar<>'''' do begin
   if NextChar in [#10,#13] then Error('Open string','StringConst');
   Result:=Result+ReadChar;
  end;
  ReadChar; // ''''
  if NextChar='''' then begin
   Result:=Result+ReadChar;
   done:=False;
  end else begin
   done:=True;
  end;
 until done;
end;

// read an ascii char value (#xxx) - this code is NOT MULTIMYTE friendly yet (UCS-2/UTF-8)
function TSource.AsciiChar:string;
begin
 ReadChar; // #
 Result:='';
 while NextChar in ['0'..'9'] do Result:=Result+ReadChar;
 if BitsCount(Result)>8 then Error('Byte overflow','AsciiChar');
 Result:=chr(StrToInt(Result));
end;

end.
