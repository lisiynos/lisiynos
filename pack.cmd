git pull
git clean -Xdf
del C:\lisiynos.zip
SET PATH=C:\Program Files (x86)\WinRAR;C:\Program Files\WinRAR;%PATH%
cd C:\lisiynos
mkdir C:\!
winrar a -r C:\!\lisiynos.zip "*.*" -x*\.git\*
