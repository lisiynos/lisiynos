{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

program FlashPascal;

{ Pascal for Flash compiler (c)2008-2010 by Paul TOTH <tothpaul@free.fr> }
{ Pascal for Flash compiler portions (c) 2011 by Péter Gábor <ptrg@users.sf.net> }

{
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

{ See ..\doc\history.txt for the developement history. }

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

{$APPTYPE CONSOLE}

{%file '..\samples\Flash8.pas'}
{%file '..\samples\Hello.pas'}
{%file '..\samples\Calc.pas'}
{%file '..\samples\Etoile.pas'}
{%file '..\samples\Barycentre.pas'}
{%file '..\samples\DragPoly.pas'}
{%file '..\samples\ZoneFlash.pas'}
{%file '..\samples\FlashMine.pas'}
{%file '..\samples\Sudoku.pas'}

{%file 'FlashPascal.inc'}

uses
  SysUtils,
  Deflate in 'Deflate.pas',
  Global in 'Global.pas',
  SWF in 'SWF.pas',
  Compiler in 'Compiler.pas',
  Parser in 'Parser.pas',
  Source in 'Source.pas';

{$I FlashPascal.inc}

function AddType(const Name:string):TSymbol;
begin
  Result:=TBaseType.Create;
  Result.name:=Name;
  Result.NextSymbol:=Symbols;
  Symbols:=Result;
end;

procedure CompileFile(const AFileName:string);
var
  c:TCompiler;
  s,syms:TSymbol;
begin

 WriteLn(AFileName); // display file name

 Path := ExtractFilePath(AFileName);

// default path for units
 LibPath:=ExtractFilePath(ParamStr(0)); // default LibPath is this compiler's path + 'units'
 {$IFDEF WIN32}
  LibPath:=LibPath+'units\';
 {$ELSE}
  LibPath:=LibPath+'units/';
 {$ENDIF}

// WriteLn('Path = '+Path);
// WriteLn('LibPath = '+LibPath);

  {$IFDEF MEMCHECK}
  WriteLn('sCount=',sCount);
  WriteLn('eCount=',eCount);
  {$ENDIF}

  DecimalSeparator:='.';

// init symbols
  Symbols :=nil;
  Anonyms :=nil;
  Scopes  :=nil;
  _Root   :=TVariable.Create;
  _Root.realName:='_root';
  _Char    := AddType('CHAR');
  _String  := AddType('STRING');
  _Integer := AddType('INTEGER');
  _Double  := AddType('DOUBLE');
  _Boolean := AddType('BOOLEAN');
  _Object  := AddType('TOBJECT');

  syms:=Symbols;

  FrameWidth  :=800;
  FrameHeight :=600;
  FrameRate   :=32;
  Background  :=$FFFFFF;
  FlashVersion:=9;

  c:=TCompiler.Create(AFileName);

  Dictionary.Items:=nil;
  Dictionary.Length :=0;
  Dictionary.Count  :=0;
  Resources:='';
  ResourceID:=0;

  c.Compile;
  //c.Save;

  c.Free;

  Resources:='';

  s:=Symbols;
  while s<>syms do begin
    Symbols:=s.NextSymbol;
    s.Free;
    S:=Symbols;
  end;
  s:=Anonyms;
  while s<>nil do begin
    Anonyms:=s.NextSymbol;
    s.Free;
    S:=Anonyms;
  end;

  // for Free Pascal's builtin embedded heap profiler
  {$IFDEF FPC}
  _Object.Free;
  _Boolean.Free;
  _Double.Free;
  _Integer.Free;
  _String.Free;
  _Char.Free;
  _Root.Free;
  {$ENDIF}

  {$IFDEF MEMCHECK}
  WriteLn('sCount=',sCount);
  WriteLn('eCount=',eCount);
  {$ENDIF}
end;

var
  fname:string;
  msg:string;

type
  TGetParametersResult=(gprHelp,gprCopyright,gprParameterError,gprNoFile,gprOkay);

function GetParameters:TGetParametersResult;
var
  i,j:Integer;
begin
  Result:=gprNoFile;
  fname:='';
  for i:=1 to ParamCount do begin
    case ParamStr(i)[1] of
      '-':begin
        case ParamStr(i)[2] of
          '?','h','H':Result:=gprHelp;
          'c','C': Result:=gprCopyright;
          //'d','D': ; // set conditional defines
          else begin
            for j:=2 to Length(ParamStr(i))do begin // support of parameters given like "-ewsp" or "-e -w -s -p"
              case ParamStr(i)[j] of
                'e','E': DisplayErrors:=True;
                'n','N': DisplayNotes:=True;
                'p','P': PauseBeforeExit:=True;
                //'r','R': UseRegisterVariables:=True;
                's','S': DisplaySourceOnErrors:=True;
                't','T': HtmlTestPageOutput:=True;
                'u','U': UncompressedOutput:=True;
                'x','X': SyntaxCheckingOnly:=True;
                'v','V': begin
                  DisplayErrors:=True;
                  DisplayNotes:=True;
                  DisplaySourceOnErrors:=True;
                  DisplayWarnings:=True;
                end;
                'w','W': DisplayWarnings:=True;
                else begin
                  Msg:='Invalid parameter: '+ParamStr(i)[j];
                  Result:=gprParameterError;
                end;
              end;
            end;
          end;
        end;
      end else begin
        if Result=gprNoFile then begin
          fname:=ParamStr(i);
          if(Pos('?',fname)<>0)or(Pos('*',fname)<>0)then begin
            Msg:='Wildcards not supported: '+fname;
            Result:=gprParameterError;
          end else Result:=gprOkay;
        end else if Result=gprOkay then begin
          Msg:='Multiple source files not supported: '+ParamStr(i);
          Result:=gprParameterError;
        end;
      end;
    end;
  end;
end;

begin
  ExitProc:=@FinalProc; // wait for <enter> or just writeln

  WriteLn('Flash Pascal '+VersionString+' [',{$I %DATE%},']'); // Version information
  WriteLn;

(*{$IFDEF TEST}
 CompileFile('samples\Hello.pas');
 CompileFile('samples\Calc.pas');
 CompileFile('samples\Etoile.pas');
 CompileFile('samples\Barycentre.pas');
 CompileFile('samples\DragPoly.pas');
 CompileFile('samples\ZoneFlash.pas');
 CompileFile('samples\FlashMine.pas');
 CompileFile('samples\Sudoku.pas');
{$ELSE}*)

  // get parameters
  case GetParameters of
    gprCopyright:begin
      WriteLn('Pascal for Flash compiler (c)2008-2010 by Paul TOTH <tothpaul@free.fr>');
      WriteLn('Pascal for Flash compiler portions (c) 2011 by Péter Gábor <ptrg@users.sf.net>');
      WriteLn;
      WriteLn('http://flashpascal.SourceForge.net');
      WriteLn;
      WriteLn('This program is free software; you can redistribute it and/or');
      WriteLn('modify it under the terms of the GNU General Public License');
      WriteLn('as published by the Free Software Foundation; either version 2');
      WriteLn('of the License, or (at your option) any later version.');
      WriteLn;
      WriteLn('This program is distributed in the hope that it will be useful,');
      WriteLn('but WITHOUT ANY WARRANTY; without even the implied warranty of');
      WriteLn('MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the');
      WriteLn('GNU General Public License for more details.');
      WriteLn;
      WriteLn('You should have received a copy of the GNU General Public License');
      WriteLn('along with this program; if not, write to the Free Software');
      WriteLn('Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.');
      WriteLn;
    end;
    gprHelp:begin
      WriteLn('usage: ',ExtractFileName(ParamStr(0)),' [-?|h] [-c] [-[e][n][p][s][t][u][w][x]] filename');
      WriteLn('       -?        display this help message (-h)');
      WriteLn('       -c        display copyright informations');
      WriteLn('       -e        display error messages on programming errors');
      WriteLn('       -h        display this help message (-?)');
      WriteLn('       -n        display notes stored in the source');
      WriteLn('       -p        pause after execution (hit <ENTER> to exit)');
      //WriteLn('       -r        use registers for variables where it is possible');
      WriteLn('       -s        display buggy line of source code on error (with -e only)');
      WriteLn('       -t        generate html file for (web) testing');
      WriteLn('       -u        do not compress the final swf file (for special needs if any)');
      WriteLn('       -v        verbose mode, same as -ensw');
      WriteLn('       -w        display warning messages on possible mistakes');
      WriteLn('       -x        syntax checking only, no files written');
      WriteLn('       filename  the file to be compiled, multiple source files are not supported');
      WriteLn;
      WriteLn('This program is released under the terms of GPL v2');
      WriteLn;
    end;
    gprParameterError: begin
      WriteLn(Msg);
    end;
    gprNoFile: begin
      WriteLn('File name required!');
    end;
    gprOkay: begin
      CompileFile(fname);
      WriteLn('Finished');
    end;
  end;
(*{$ENDIF}*)

end.
