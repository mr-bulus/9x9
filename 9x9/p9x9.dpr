program p9x9;

uses
  Forms,
  u9x9 in 'u9x9.pas' {frm9x9},
  uNWyniki in 'uNWyniki.pas' {frmNWyniki},
  uAbout in 'uAbout.pas' {frmAbout},
  uPlansza in 'uPlansza.pas',
  uInterf in 'uInterf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '9x9';
  Application.CreateForm(Tfrm9x9, frm9x9);
  Application.CreateForm(TfrmNWyniki, frmNWyniki);
  Application.Run;
end.
