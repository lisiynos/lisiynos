program draw;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {DrawForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDrawForm, DrawForm);
  Application.Run;
end.
