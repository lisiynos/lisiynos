{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

{
Flash Pascal demo containing arrays, strings, TString actions and a TextField
to display the results of some operations with them...
(c) 2011 by Péter Gábor
}

program stringopenarraydemo;

{$FRAME_WIDTH  600}
{$FRAME_HEIGHT 600}
{$BACKGROUND $efefff}

uses
  Flash8Ext,Strings;

var
 t:TextField;
 s1,s2:TString;
 s3,s4:array of string;
 s6:array[0..10]of string;
 s7:array[3..5]of string;
 s,s5:string;

begin
 s1:=TString.Create('5*,4**,3***,2**,**,1**,***,0*****'); // create a TString object
 s2:=TString.Create(s1.substring(6,s1.length_)); // create a TString object from a part of the value of a TString
 s3:=s1.split(',',19); // assign array type result of splitting a TString object to an array
// s3[6]:=s5; // assign value to an item of an array
 s4:=['first*','second*','third*']; // assign list of items to an open array
 s5:=s2.valueOf; // assign literal string value of a TString object to a literal string variable
 s6:=s4; // assign array to array

 // display what we made

 t:=TextField.Create(nil,'t',0,0,0,600,600); // create a textfield on the root
 t.wordWrap:=True;
 t.text:='Flash Pascal demo containing arrays, strings, TString actions and a TextField '+
  'to display the results of some operations with them...'+#13+
  '(c) 2011 by Péter Gábor'+#13+#13+
  's1.valueOf   = '+s1.valueOf+#13+
  's2.valueOf   = '+s2.valueOf+#13+#13+
  's3[0]        = '+s3[0]+#13+
  's3[1]        = '+s3[1]+#13+
  's3[2]        = '+s3[2]+#13+
  's3[3]        = '+s3[3]+#13+
  's3[4]        = '+s3[4]+#13+
  's3[5]        = '+s3[5]+#13+
  's3[6]        = '+s3[6]+#13+
  's3[7]        = '+s3[7]+#13+
  's3[8]        = '+s3[8]+#13+
  's3[9]        = '+s3[9]+#13+
  's3[10]        = '+s3[10]+#13+#13+
  's4[1]        = '+s4[0]+#13+
  's4[2]        = '+s4[1]+#13+
  's4[3]        = '+s4[2]+#13+
  's4[4]        = '+s4[3]+#13+#13+
  's5           = '+s5+#13+#13+
  'length(s5)   = '+inttostr(length(s5))+#13+
  'low(s3)      = '+inttostr(low(s3))+#13+
  'high(s3)     = '+inttostr(high(s3))+#13+
  'low(s7)_3    = '+inttostr(low(s7))+#13+
  'high(s7)_5   = '+inttostr(high(s7))+#13+
  #13;

end.

