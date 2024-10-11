unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type
  TfrmAbout = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblRegMod: TLabel;
    lblDeskSC: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses u9x9;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
var
 rejestr : TRegistry;

begin
 if FileExists(Tfrm9x9.Pulpit+'\9x9.lnk') then lblDeskSC.Caption := 'TAK'
 else lblDeskSC.Caption := 'NIE';

 rejestr := TRegistry.Create;
 try
  rejestr.RootKey := HKEY_CURRENT_USER;
  if rejestr.KeyExists('\Software\9x9') then lblRegMod.Caption := 'TAK'
  else lblRegMod.Caption := 'NIE';
 finally
  rejestr.Free;
 end;
end;

end.
