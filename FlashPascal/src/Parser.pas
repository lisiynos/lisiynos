{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Parser;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

uses
 Global, Source, SWF{, CodeGen};

{$I FlashPascal.inc}

type
 TToken=(
 // Pascal keywords - from fpc documentation
  {
  *
  *  Turbo Pascal:
  *
  absolute  and  array  asm  begin  case  const  constructor destructor  div
  do  downto  else  end  file  for  function  goto  if  implementation  in
  inherited  inline  interface  label  mod  nil  not  object  of  on  operator
  or  packed  procedure  program  record  reintroduce  repeat  self  set  shl
  shr  string  then  to  type  unit  until  uses  var  while  with  xor
  *
  *  Free Pascal:
  *
  dispose  exit  false  new  true
  *
  *  Object Pascal:
  *
  as  class  dispinterface  except  exports  finalization  finally
  initialization  inline  is  library  on  out  packed  property  raise
  resourcestring  threadvar  try
  *
  *  Modifiers:
  *
  absolute  abstract  alias  assembler  cdecl  cppdecl  default  export
  external  far  far16  forward  index  local  name  near  nostackframe
  oldfpccall  override  pascal  private  protected  public  published  read
  register  reintroduce  safecall  softfloat  stdcall  virtual  write
  *
  *  Others:
  *
  default  dynamic  message  nodefault  static  strict  readonly  writeonly
  *
  *
  *
  }
  tkProgram,
  tkUses, tkIn, tkUnit, tkInterface, tkImplementation,
  tkVar, tkType, tkConst,
  tkBegin, tkEnd,
  tkProcedure, tkFunction,
  tkExternal,
  tkClass, tkConstructor, tkAs,
  tkProperty,
  tkNil,
  tkDiv, tkMod,
  tkTrue,tkFalse,
  tkIf, tkThen,
  tkFor, tkTo, tkDownto, tkDo,
  tkArray, tkOf,
  tkObject,
  tkInherited,
  tkSelf,
  tkCase, tkElse,
  tkRepeat, tkUntil,
  tkWhile,
  tkOr, tkAnd,
  tkXOr, tkNot,
  tkShl, tkShrSigned, tkShrUnsigned,
  tkExit,

 // built in functions
  tkIntToStr, tkFloatToStr, tkTrunc, tkSort, tkCopy, tkLength, tkOrd, tkChr, tkInc, tkDec,
  tkTrace, tkBoolToStr, tkHigh, tkLow,

 // user defined symbol
  tk_Symbol,
  tk_Variable, tk_Parameter, tk_Property, tk_Method, tk_Prototype, tk_Class, tk_Constant,

 // Symbols, etc...
  tk_Equal, tk_Greater, tk_Lesser, tk_GE, tk_LE, tk_NotEqual,
  tk_Add, tk_Sub, tk_Mul, tk_Slash, tk_Range,
  tk_Assign, tk_Comma, tk_Colon, tk_SemiColon, tk_Dot,
  tk_LParen, tk_RParen,
  tk_LBracket, tk_RBracket,
  tk_String, tk_Number, tk_Float, tk_Ident,
  tk_Comment, tk_LComment1, tk_RComment1, tk_LComment2, tk_RComment2,
  tk_Switch1,
  tk_Shl, tk_ShrSigned, tk_ShrUnsigned
 );

 TVariable=class(TSymbol)
  Kind    :TSymbol;
  Owner   :TSymbol; // nil for Global var...
 {$IFDEF REG_VARS}
  Reg     :byte;
 {$ENDIF}
 end;

 TConstant=class(TSymbol)
  Code  : string;
  Kind  : TSymbol;
  function GetInteger(var Value: Integer): Boolean;
 end;

 TParameter=class(TSymbol)
  IsConst:Boolean;   // not used for now
  ByRef  :Boolean;
  Kind   :TSymbol;
  Default:string;
 {$IFDEF REG_PARAM}
  Reg    :Byte;
 {$ENDIF}
  NextParam:TParameter;
  function Clone:TParameter;
 end;

 TProperty=class(TSymbol)
  Kind : TSymbol;
  Alias: string;
  NoReadAccess,NoWriteAccess:Boolean;
 end;

 TFunction=class(TSymbol)
  params  :TParameter;
  count   :integer;
  regs    :integer;
  Kind    :TSymbol;   // function result
  Return  :TVariable;
  destructor Destroy; override;
 end;

 TMethod=class(TFunction)
  alias    :string;    // alias used for MovieClip.createTextField()
  Parent   :TParameter;    // MovieClip is this case
  code     :string;    // for UserClass only
  Owner    :TSymbol;
  Symbols  :TSymbol;
  Externe  :string;    // Math.floor
//  CodeBlock: TCodeBlock;
  destructor Destroy; override;
  function LastParm: TParameter;
 end;

 TClass=class(TSymbol)
  _inherite   : TClass;
  _constructor: TMethod;
  _symbols    : TSymbol;
  destructor Destroy; override;
 end;

 TParser=class(TSource)
  TokenType:TToken;   // what kind of token is it ?
  TokenIsAlpha:Boolean; // current token is AlphaToken, to use in conjuction with ExternalFlashReference:Boolean;
  procedure AlphaToken;
  procedure NumericToken;
  procedure StringToken;
  procedure SymbolToken;
  procedure HexaToken;
  procedure GetToken;
  procedure NextToken; virtual;
  function SkipToken(Token:TToken):boolean;
  procedure DropToken(Token:TToken);
  procedure DropIdent(const Ident:string);
  function GetIdent:string;
  function GetSrcIdent:string;
  function GetInteger:Integer;
  function CheckSymbol(List:TSymbol):boolean;
  function CheckScope(Symbol:TSymbol):boolean;
 end;

var
 Symbols   :TSymbol; // chained list of symbols
 Scopes    :PScope;

 Symbol    :TSymbol; // token symbol

 ExternalFlashReference: Boolean; // to allow problematic external Flash class names in TParser.GetIdent

implementation

{ TConstant }

function TConstant.GetInteger(var Value: Integer): Boolean;
begin
  Result := SWFIsPushInteger(Code, Value);
end;

{ TParameter }

function TParameter.Clone:TParameter;
begin
 Result:=TParameter.Create;
 Result.IsConst:=IsConst;
 Result.ByRef:=ByRef;
 Result.Kind:=Kind;
 Result.default := default;
{$IFDEF REG_PARAM}
 Result.Reg:=Reg;
{$ENDIF}
 Result.name:=name;
 Result.realName:=realName;
end;

{ TClass }

destructor TClass.Destroy;
var
 s:TSymbol;
begin
 s:=_symbols;
 while s<>nil do begin
  _symbols:=s.NextSymbol;
  s.Free;
  s:=_symbols;
 end;
 inherited;
end;

{ TFunction }

destructor TFunction.Destroy;
var
 p:TParameter;
begin
 p:=Params;
 while p<>nil do begin
  Params:=p.NextParam;
  p.Free;
  p:=Params;
 end;
 inherited;
end;

{ TMethod }

destructor TMethod.Destroy;
var
 s:TSymbol;
begin
 s:=Symbols;
 while s<>nil do begin
  Symbols:=s.NextSymbol;
  s.Free;
  s:=Symbols;
 end;
 Parent.Free;
 inherited;
end;

function TMethod.LastParm: TParameter;
begin
 Result:=Params;
 if Result<>nil then begin
  while Result.NextParam<>nil do Result:=Result.NextParam;
 end;
end;

{ TParser }

// read an alpha token
procedure TParser.AlphaToken;
var
 scope:PScope;
begin
 TokenType:=tk_Ident;
 while upcase(NextChar) in ['_','A'..'Z','0'..'9'] do begin
  Token:=Token+upcase(ReadChar);
 end;
// check for reserved keyword
 if Token='PROGRAM'     then TokenType:=tkProgram else
 if Token='USES'        then TokenType:=tkUses else
 if Token='IN'          then TokenType:=tkIn else
 if Token='UNIT'        then TokenType:=tkUnit else
 if Token='INTERFACE'   then TokenType:=tkInterface else
 if Token='IMPLEMENTATION' then TokenType:=tkImplementation else
 if Token='VAR'         then TokenType:=tkVar else
 if Token='TYPE'        then TokenType:=tkType else // conflict with externals: TextField.type ----> ???
 if Token='CONST'       then TokenType:=tkConst else
 if Token='BEGIN'       then TokenType:=tkBegin else
 if Token='END'         then TokenType:=tkEnd else
 if Token='PROCEDURE'   then TokenType:=tkProcedure else
 if Token='FUNCTION'    then TokenType:=tkFunction else
 if Token='NIL'         then TokenType:=tkNil else
 if Token='DIV'         then TokenType:=tkDiv else
 if Token='MOD'         then TokenType:=tkMod else
 if Token='TRUE'        then TokenType:=tkTrue else
 if Token='FALSE'       then TokenType:=tkFalse else
 if Token='IF'          then TokenType:=tkIf else
 if Token='THEN'        then TokenType:=tkThen else
 if Token='FOR'         then TokenType:=tkFor else
 if Token='TO'          then TokenType:=tkTo else
 if Token='DOWNTO'      then TokenType:=tkDownto else
 if Token='DO'          then TokenType:=tkDo else
 if Token='ARRAY'       then TokenType:=tkArray else // conflict with externals: Array (object)
 if Token='OF'          then TokenType:=tkOf else
 if Token='OBJECT'      then TokenType:=tkObject else
 if Token='INHERITED'   then TokenType:=tkInherited else
 if Token='SELF'        then TokenType:=tkSelf else
 if Token='COPY'        then TokenType:=tkCopy else // conflict with externals: ContextMenu.Copy ----> STRCOPY
 if Token='LENGTH'      then TokenType:=tkLength else // conflicts with externals: TextField.Length ----> STRLENgth
 if Token='HIGH'        then TokenType:=tkHigh else //
 if Token='LOW'         then TokenType:=tkLow else //
 if Token='ORD'         then TokenType:=tkOrd else
 if Token='CHR'         then TokenType:=tkChr else
 if Token='INC'         then TokenType:=tkInc else
 if Token='DEC'         then TokenType:=tkDec else
 if Token='CASE'        then TokenType:=tkCase else
 if Token='ELSE'        then TokenType:=tkElse else
 if Token='REPEAT'      then TokenType:=tkRepeat else
 if Token='UNTIL'       then TokenType:=tkUntil else
 if Token='WHILE'       then TokenType:=tkWhile else
 if Token='OR'          then TokenType:=tkOr else
 if Token='AND'         then TokenType:=tkAnd else
 if Token='XOR'         then TokenType:=tkXor else
 if Token='NOT'         then TokenType:=tkNot else
 if Token='SHL'         then TokenType:=tkShl else
 if Token='SHRI'        then TokenType:=tkShrSigned else
 if Token='SHR'         then TokenType:=tkShrUnsigned else
 if Token='EXIT'        then TokenType:=tkExit else
 if Token='TRACE'       then TokenType:=tkTrace else
 if Token='INTTOSTR'    then TokenType:=tkIntToStr else
 if Token='FLOATTOSTR'  then TokenType:=tkFloatToStr else
 if Token='TRUNC'       then TokenType:=tkTrunc else
 if Token='BOOLTOSTR'   then TokenType:=tkBoolToStr else
 if Token='SORT'        then TokenType:=tkSort else // conflicts with externals Array.Sort ----> ARRAYSORT
 if Token='EXTERNAL'    then TokenType:=tkExternal else
 if Token='CLASS'       then TokenType:=tkClass else
 if Token='CONSTRUCTOR' then TokenType:=tkConstructor else
 if Token='AS'          then TokenType:=tkAs else
 if Token='PROPERTY'    then TokenType:=tkProperty else
 begin
 // Check for local scope symbols
  scope:=Scopes;
  while scope<>nil do begin
   if CheckScope(scope.Symbol) then exit;
   scope:=scope.Next;
  end;
 // global scope also
  CheckSymbol(Symbols);
 end;
end;

// read a numeric token
procedure TParser.NumericToken;
begin
 TokenType:=tk_Number;
 while NextChar in ['0'..'9'] do begin
  Token:=Token+ReadChar;
 end;
(* !!! WARNING 0..1 is not a Float !
// this part of code is moved to TCompiler.Expression1 where "if TokenType=tk_Number ..."
// so unneeded and removable from here
 if NextChar='.' then begin
  TokenType:=tk_Float;
  Token:=Token+ReadChar;
  while NextChar in ['0'..'9'] do begin
   Token:=Token+ReadChar;
  end;
 end;
*)
end;

// read a string made of litterals and ascii chars
procedure TParser.StringToken;
begin
 TokenType:=tk_String;
 while NextChar in ['#',''''] do begin
  if NextChar='#' then
   Token:=Token+AsciiChar
  else
   Token:=Token+StringConst;
 end;
end;

// get a special symbol
procedure TParser.SymbolToken;
begin
 case ReadChar of
  '=' : TokenType:=tk_Equal;
  '>' :
    if SkipChar('>') then begin
      if SkipChar('>') then TokenType:=tk_ShrUnsigned // >>> SHR (SHRUnsigned)
      else TokenType:=tk_ShrSigned; // >> SHRI (SHRSigned)
    end else
      if SkipChar('=') then TokenType:=tk_GE {greater or equal >=}
      else TokenType:=tk_Greater; {greater > }
  '<' : if SkipChar('<') then TokenType:=tk_Shl // << SHL
    else
      if SkipChar('=') then TokenType:=tk_LE  {lesser or equal <=}
      else
        if SkipChar('>') then TokenType := tk_NotEqual {not equal <> }
        else TokenType:=tk_Lesser; {Lesser < }
  '+' : TokenType:=tk_Add;
  '-' : TokenType:=tk_Sub;
  '*' : TokenType:=tk_Mul;
  '.' : if SkipChar('.') then TokenType:=tk_Range else TokenType:=tk_Dot;
  ',' : TokenType:=tk_Comma;
  ':' : if SkipChar('=') then TokenType:=tk_Assign else TokenType:=tk_Colon;
  ';' : TokenType:=tk_SemiColon;
  '(' : if SkipChar('*') then TokenType:=tk_LComment2 else TokenType:=tk_LParen;
  ')' : TokenType:=tk_RParen;
  '{' : if SkipChar('$') then TokenType:=tk_Switch1 else TokenType:=tk_LComment1;
  '}' : TokenType:=tk_RComment1;
  '[' : TokenType:=tk_LBracket;
  ']' : TokenType:=tk_RBracket;
  '/' : if SkipChar('/') then Tokentype:=tk_Comment else TokenType:=tk_Slash;
  else  Error('Unknown symbol '+LastChar,'SymbolToken');
 end;
end;

// get an hexadecimal number
procedure TParser.HexaToken;
begin
 TokenType:=tk_Number;
 Token:=ReadChar;
 while upcase(NextChar) in ['0'..'9','A'..'F'] do begin
  Token:=Token+upcase(ReadChar);
 end;
 if Length(Token)>9 then Error('Ordinal overflow','HexaToken');
end;

// get the next token
procedure TParser.GetToken;
begin
 while NextChar<=#32 do ReadChar;
 SrcToken:='';
 Token:='';
 TokenIsAlpha:=False; // to use in conjuction with ExternalFlashReference
 case upcase(NextChar) of
  '_','A'..'Z' : begin
   TokenIsAlpha:=True;// to use in conjuction with ExternalFlashReference
   AlphaToken;
  end;
  '0'..'9'     : NumericToken;
  '$'          : HexaToken;
  '#',''''     : StringToken;
  else           SymbolToken;
 end;
end;

// get the next token, handle compiler switch & comments
procedure TParser.NextToken;
begin
 GetToken;
 case TokenType of
  tk_Comment : begin
   repeat until ReadChar in [#10,#13];
   NextToken;
  end;
  tk_LComment1 : begin
   repeat until ReadChar='}';
   NextToken;
  end;
  tk_LComment2 : begin
   repeat
    repeat until ReadChar='*';
   until NextChar=')';
   ReadChar;
   NextToken;
  end;
 end;
end;

// skip a token
function TParser.SkipToken(Token:TToken):boolean;
begin
 Result:=TokenType=Token;
 if Result then NextToken;
end;

// request a token
procedure TParser.DropToken(Token:TToken);
begin
 if not SkipToken(Token) then
  Error('Unexpected token','DropToken');
end;

procedure TParser.DropIdent(const Ident:string);
begin
 if Token<>Ident then Error(Ident+' expected','DropIdent'); // Error('Expected "'+Ident+'" got "'+Token+'"','DropIdent');
 NextToken;
end;

// request an ident
function TParser.GetIdent:string;
begin
 if TokenType<>tk_Ident then begin
 // quick hack for parameters with a global name
  if not (TokenType in [tk_Variable]) then begin
    // TString=external class(String) .. end;
    // function cos(a:double):double external Math.cos;
    if not (ExternalFlashReference and TokenIsAlpha) then // to allow problematic external Flash class names
      Error('Ident expected','GetIdent');
  end;
 end;
 Result:=Token;
 NextToken;
end;

// request ident case sensitive - used for unit names only!
function TParser.GetSrcIdent:string;
begin
 if TokenType<>tk_Ident then Error('Ident expected','GetSrcIdent');
 Result:=SrcToken;
 NextToken;
end;

function TParser.GetInteger:integer;
begin
 if TokenType = tk_Constant then
 begin
   if not (TConstant(Symbol).GetInteger(Result)) then
     Error('Integer expected','GetInteger1'); // Constant is not an integer
 end else begin
   if TokenType<>tk_Number then Error('Integer expected','GetInteger2'); // Number expected
   if BitsCount(Token)>32 then Error('Ordinal overflow','GetInteger');
   Result:=StrToInt(Token);
 end;
 NextToken;
end;

function TParser.CheckSymbol(List:TSymbol):boolean;
begin
 Symbol:=List;
 while Symbol<>nil do begin
  if Symbol.name=Token then begin
   if Symbol is TVariable then
    TokenType:=tk_Variable
   else
   if Symbol is TConstant then
    TokenType:=tk_Constant
   else
   if Symbol is TParameter then
    TokenType:=tk_Parameter
   else
   if Symbol is TProperty then
    TokenType:=tk_Property
   else
   if Symbol is TClass then
    TokenType:=tk_Class
   else
   if Symbol is TMethod then
    TokenType:=tk_Method
   else
    TokenType:=tk_Symbol;
   Result:=True;
   exit;
  end;
  Symbol:=Symbol.NextSymbol;
 end;
 Result:=False;
end;

function TParser.CheckScope(Symbol:TSymbol):boolean;
var
 cl:TClass;
begin
 Result:=False;
 if Symbol is TClass then begin
  cl:=TClass(Symbol);
  while cl<>nil do begin
   Result:=CheckSymbol(cl._symbols);
   if Result then exit;
   cl:=cl._inherite;
  end;
 end else
 if Symbol is TMethod then begin
  Result:=CheckSymbol(TMethod(Symbol).Symbols);
  if Result=False then
   Result:=CheckSymbol(TMethod(Symbol).params);
 end else
  Error('Not in the scope '+Symbol.ClassName,'CheckScope');
end;

end.
