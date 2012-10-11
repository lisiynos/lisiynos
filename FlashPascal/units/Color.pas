{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Colors; // Colors - RGB color value and transform, eg.: for a MovieClip

type
  colorTransform=external class(object)
    ra:Integer; // percentage of red (-100..100).
    rb:Integer; // red (-255..255).
    ga:Integer; // percentage of green (-100..100).
    gb:Integer; // green (-255..255).
    ba:Integer; // percentage of blue (-100..100).
    bb:Integer; // blue (-255..255).
    aa:Integer; // percentage of alpha (-100..100).
    ab:Integer; // alpha (-255..255).
  end;

  TColor=external class(Color)
    constructor Create(target:MovieClip);
    function setRGB(offset:Integer);
    function setTransform(transformObject:colorTransform);
    function getRGB:Integer;
    function getTransform:colorTransform;
  end;

implementation

end.
