{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Sound; // control sounds

interface

type

  TMethod_Sound=procedure of object;
  TMethod_Sound_onLoad=procedure(param:Boolean) of object;

  // TID3 is for reading values of MP3 tags - TEMPLATE ONLY!
  TID3=external class(Object)
    // ID3v1
    property comment:string;  {COMM - Comment}
    property album:string;    {TALB - Album/movie/show title}
    property genre:string;    {TCON - Content type}
    property songname:string; {TIT2 - Title/song name/content description}
    property artist:string;   {TPE1 - Lead performers/soloists}
    property track:string;    {TRCK - Track number/position in set}
    property year:string;     {TYER - Year}
    // ID3v2
    property COMM:string; {Comment}
    property TALB:string; {Album/movie/show title}
    property TBPM:string; {Beats per minute}
    property TCOM:string; {Composer}
    property TCON:string; {Content type}
    property TCOP:string; {Copyright message}
    property TDAT:string; {Date}
    property TDLY:string; {Playlist delay}
    property TENC:string; {Encoded by}
    property TEXT:string; {Lyricist/text writer}
    property TFLT:string; {File type}
    property TIME:string; {Time}
    property TIT1:string; {Content group description}
    property TIT2:string; {Title/song name/content description}
    property TIT3:string; {Subtitle/description refinement}
    property TKEY:string; {Initial key}
    property TLAN:string; {Languages}
    property TLEN:string; {Length}
    property TMED:string; {Media type}
    property TOAL:string; {Original album/movie/show title}
    property TOFN:string; {Original filename}
    property TOLY:string; {Original lyricists/text writers}
    property TOPE:string; {Original artists/performers}
    property TORY:string; {Original release year}
    property TOWN:string; {File owner/licensee}
    property TPE1:string; {Lead performers/soloists}
    property TPE2:string; {Band/orchestra/accompaniment}
    property TPE3:string; {Conductor/performer refinement}
    property TPE4:string; {Interpreted, remixed, or otherwise modified by}
    property TPOS:string; {Part of a set}
    property TPUB:string; {Publisher}
    property TRCK:string; {Track number/position in set}
    property TRDA:string; {Recording dates}
    property TRSN:string; {Internet radio station name}
    property TRSO:string; {Internet radio station owner}
    property TSIZ:string; {Size}
    property TSRC:string; {ISRC (international standard recording code)}
    property TSSE:string; {Software/hardware and settings used for encoding}
    property TYER:string; {Year}
    property WXXX:string; {URL link frame}
  end;

  // sound volume transformations between speakers - TEMPLATE ONLY!
  transformObject=external class(Object)
    property ll:integer; // left channel in left speaker (0-100 percentage)
    property lr:integer; // left channel in right speaker (0-100 percentage)
    property rr:integer; // right channel in right speaker (0-100 percentage)
    property rl:integer; // right channel in left speaker (0-100 percentage)
  end;

  Sound=external class
    property duration:Integer;
    property id3:TID3;
    property position:Integer;
    constructor Create(target:MovieClip); // target:MovieClip can be _root
    procedure loadSound(url:String; isStreaming:Boolean);
    procedure start(secondOffset:Integer; loops:Integer);
    procedure stop;
    //procedure stop(id:String); // linkageID can be nil
    //procedure attachSound(id:String);
    function getPan:Integer;
    function getVolume:Integer;
    procedure setPan(value:Integer);
    procedure setVolume(value:Integer);
    function getDuration:Integer;
    procedure setDuration(value:Integer);
    function getPosition:Integer;
    procedure setPosition(value:Integer);
    function getBytesLoaded:Integer;
    function getBytesTotal:Integer;
    property onLoad:TMethod_Sound_onLoad;
    property onSoundComplete:TMethod_Sound;
    property onID3:TMethod_Sound;
  end;

implementation

end.
