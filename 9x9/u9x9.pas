unit u9x9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Buttons, Menus, ShellApi, ActnList, MMSystem,
  Registry, ShlObj, ComObj, ActiveX, uInterf;

type

  Tfrm9x9 = class(TForm)
    spbnStart: TSpeedButton;
    Bevel2: TBevel;
    MainMenu1: TMainMenu;
    Ustawienia1: TMenuItem;
    Oprogramie1: TMenuItem;
    GroupBox1: TGroupBox;
    lblWynik: TLabel;
    Najlepszewyniki1: TMenuItem;
    mitemTray: TMenuItem;
    PopupMenu1: TPopupMenu;
    Oprogramie2: TMenuItem;
    ActionList1: TActionList;
    actAbout: TAction;
    spbnZamknij: TSpeedButton;
    actClose: TAction;
    Zamknij1: TMenuItem;
    mitemSkrot: TMenuItem;
    N1: TMenuItem;
    GroupBox2: TGroupBox;
    lblScBlue: TLabel;
    lblScBrown: TLabel;
    lblScGreen: TLabel;
    lblScRed: TLabel;
    lblScViolet: TLabel;
    lblScYellow: TLabel;

    procedure AppMinimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbnStartClick(Sender: TObject);
    procedure Najlepszewyniki1Click(Sender: TObject);
    procedure mitemTrayClick(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mitemSkrotClick(Sender: TObject);
    procedure WUpdate (Sender: TObject);
  private
    procedure Przeladuj;
    procedure PoleClick(Sender : Tobject);
    procedure UstawWierzcholek (wierzcholek : Wierzcholki; dodaj : boolean);
    procedure Przejscie(skad : byte);
    function Zliczanie (pole : byte) : boolean;
    procedure LosujTrzyPola;
    procedure OnMessage(var Msg: TMessage);
    procedure LosujKolory;
  public
    TrayIconData : TNotifyIconData;
    class function Pulpit: string;
    { Public declarations }
  end;

  T9x9 = class (TGra)
  public
    procedure RozpocznijGre; override;
    procedure ZakonczGre; override;
  end;

var
  frm9x9: Tfrm9x9;

implementation

{$R *.dfm}
{$R zasoby.res}


uses
  uPlansza, uNWyniki, uAbout;

const
 WM_CALLBACK_MESSAGE = WM_USER + 1;

var
  trzy_kolory : array [0..2] of TImageX;
  tablica : array [0..8,0..8] of TNButton;
  B9x9 : T9x9;

class function Tfrm9x9.Pulpit : string;
var
 rejestr: TRegistry;

begin
  rejestr := TRegistry.Create;
  try
   rejestr.RootKey := HKEY_CURRENT_USER;
   rejestr.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
   result := rejestr.ReadString('Desktop');
  finally
   rejestr.Free;
  end;
end;

procedure Tfrm9x9.FormCreate(Sender: TObject);
var
 i,j : byte;
 rys : TBitmap;
 rejestr : TRegistry;
begin
 Application.OnMinimize := AppMinimize;
 with TrayIconData do begin
  hIcon:=Application.Icon.Handle;
  uCallbackMessage:=WM_CALLBACK_MESSAGE;
  cbSize:=SizeOf(TrayIconData);
  Wnd:=Handle;
  Wnd  := AllocateHwnd(OnMessage);
  uFlags:=NIF_MESSAGE+NIF_ICON+NIF_TIP;
 end;
 StrPCopy(TrayIconData.szTip, Application.Title);

 rejestr := TRegistry.Create;
 try
  rejestr.RootKey := HKEY_CURRENT_USER;
  if rejestr.KeyExists('\Software\9x9') then
  begin
   rejestr.OpenKey('\Software\9x9',false);
   mitemTray.Checked := rejestr.ReadBool('tray');
  end;
 finally
  rejestr.Free;
 end;

 if FileExists(pulpit+'\9x9.lnk') then mitemSkrot.Enabled := FALSE;

 lblScBlue.Caption := 'Niebieski:'+#9+'1';
 lblScBrown.Caption := 'Br¹zowy:'+#9+'2';
 lblScGreen.Caption := 'Zielony: '+#9+'3';
 lblScRed.Caption := 'Czerwony:'+#9+'4';
 lblScViolet.Caption := 'Fioletowy:'+#9+'5';
 lblScYellow.Caption := '¯ó³ty:    '+#9+'6';

 lista := TImageList.Create(frm9x9);
 lista.Height:=30;
 lista.Width:=30;

 rys := TBitmap.Create;
 try
  for i := 1 to 7 do
   begin
    rys.LoadFromResourceName(HInstance,'BITMAP'+inttostr(i));
    lista.Add(rys,nil);
   end;
 finally
  rys.free;
 end;

 for j:=0 to 8 do
  for i:=0 to 8 do
   begin
    tablica[j,i] := TNButton.Create(self);
    with tablica[j,i] do
     begin
      Caption := '';
      GroupIndex := 1;
      Parent := frm9x9;
      Top := 65+j*47+j*6;
      Left := 25+i*47+i*6;
      Width := 50;
      Height := 50;
      nr := j*9+i;
      kolor:=high(kolory);
      margin := -1;
      OnClick := PoleClick;
      Enabled := False;
      Show;
    end;
   end;

 for i:=0 to 2 do
 begin
  trzy_kolory[i] := TImageX.Create(self);
  with (trzy_kolory[i]) do
   begin
    Parent := frm9x9;
    Top := 10;
    Left := 200+i*37+i*5;
    Width := 40;
    Height := 40;
    Transparent := true;
   end;
 end;
end;

procedure Tfrm9x9.OnMessage(var Msg: TMessage);
var
 pkt : TPoint;
begin
 case Msg.Msg of
  WM_Callback_Message:
   case Msg.lParam of
    WM_RBUTTONDOWN:
    begin
     SetForegroundWindow(Application.Handle);
     GetCursorPos(pkt);
     Popupmenu1.Popup(pkt.x,pkt.y);
    end;
    WM_LBUTTONDBLCLK:
    begin
     ShowWindow(Application.Handle, SW_RESTORE);
     Shell_NotifyIcon(Nim_Delete, @TrayIconData);
     SetForegroundWindow(Application.Handle);
    end;
   end;
 end;
end;

procedure Tfrm9x9.AppMinimize;
begin
 if mitemTray.Checked then
 begin
  Shell_NotifyIcon(NIM_ADD,@TrayIconData);
  ShowWindow(Application.Handle, SW_HIDE);
 end;
end;

procedure Tfrm9x9.Przejscie(skad : byte);
var
 i : byte;
begin
  UstawWierzcholek(skad,false);
  for i:= 0 to high(tab_droga) do
   begin
    tablica[tab_droga[i] div 9,tab_droga[i] mod 9].kolor:=tablica[skad div 9,skad mod 9].kolor;
    tablica[skad div 9,skad mod 9].kolor:=7;
    skad:=tab_droga[i];
    Sleep(100);
    Application.ProcessMessages;
   end;
   UstawWierzcholek(tab_droga[high(tab_droga)],true);
   if (not Zliczanie(tab_droga[high(tab_droga)])) then LosujTrzyPola;
   setlength(tab_droga,0);
end;

procedure Tfrm9x9.PoleClick(Sender: TObject);
begin
 PlaySound('POP', hInstance, SND_RESOURCE or SND_SYNC);
 if (B9x9.LosoweMiejsce <> []) then
  begin
   if (B9x9.PoprzPole<81) then
    if (TNButton(sender).kolor = 7) and (tablica[B9x9.PoprzPole div 9,B9x9.PoprzPole mod 9].kolor <> 7) then
     if wylicz_trase(B9x9.PoprzPole,TNButton(sender).nr) then
       Przejscie(B9x9.PoprzPole);
   B9x9.PoprzPole:=TNButton(sender).nr;
   if (B9x9.MaxNr=255) then
    begin
     ShowMessage('Koniec gry');
     Przeladuj;
    end;
  end
end;

procedure Tfrm9x9.UstawWierzcholek (wierzcholek : Wierzcholki; dodaj : boolean);
begin
 if dodaj then
  begin
   B9x9.LosoweMiejsce:=B9x9.LosoweMiejsce-[wierzcholek];
   Wstaw(wierzcholek);
   if (wierzcholek=B9x9.MaxNr) then
    repeat dec(B9x9.MaxNr);
    until (B9x9.MaxNr in B9x9.LosoweMiejsce) or (B9x9.MaxNr=255);
  end
 else
  begin
   B9x9.LosoweMiejsce:=B9x9.LosoweMiejsce+[wierzcholek];
   Usun(wierzcholek);
   if wierzcholek > B9x9.MaxNr then B9x9.MaxNr:= wierzcholek;
  end
end;


function Tfrm9x9.Zliczanie (pole : byte) : boolean;
type
 kierunek = (poziom, pion, prawyskos,lewyskos);

var
 x,y,klr,kolejka_l : byte;
 kolejka : array of byte;

 procedure Czysc;
 begin
  kolejka_l:=0;
  setlength(kolejka,1);
 end;

 function ZliczKierunek(x1,y1 : Wierzcholki; klr : byte; ilex,iley : shortint): byte;
 begin
   result:=0;
   while (tablica[x1,y1].kolor=klr) do
    begin
     inc(result);
     setlength(kolejka,length(kolejka)+1);
     kolejka[high(kolejka)]:= tablica[x1,y1].nr;
     if ilex <> 0 then
      if (x1>=1) and (x1<=7) then inc(x1,ilex)
      else
       break;
     if iley<>0 then
      if (y1>=1) and (y1<=7) then inc(y1,iley)
      else
       break;
    end;
 end;

 procedure UsunRzad;
 var
  tmp_kolejka_l, bonus : byte;
 begin
  result:=true; bonus:=0;
  if kolejka_l=8 then bonus:=5;
  B9x9.Wynik := (klr+1)*(1+kolejka_l)+bonus+B9x9.Wynik;
  tmp_kolejka_l:=kolejka_l;
  while tmp_kolejka_l<>255 do
   begin
    tablica[kolejka[tmp_kolejka_l] div 9,kolejka[tmp_kolejka_l] mod 9].kolor := 6;
    dec(tmp_kolejka_l);
   end;
  PlaySound('DING', hInstance, SND_RESOURCE or SND_SYNC);
  Application.ProcessMessages;
  Sleep(200);
  while kolejka_l<>255 do
   begin
    UstawWierzcholek(kolejka[kolejka_l],false);
    tablica[kolejka[kolejka_l] div 9,kolejka[kolejka_l] mod 9].Kolor:=7;
    dec(kolejka_l);
   end;
  Czysc;
 end;

 procedure WybierzKierunek (rzad : kierunek);
 begin
   case rzad of
    pion:      begin
                if x >= 1 then kolejka_l:=kolejka_l+ZliczKierunek(x-1,y,klr,-1,0);
                if x <= 7 then kolejka_l:=kolejka_l+ZliczKierunek(x+1,y,klr,1,0);
                if kolejka_l >=4 then UsunRzad else Czysc;
               end;

    poziom:    begin
                if y >= 1 then kolejka_l:=kolejka_l+ZliczKierunek(x,y-1,klr,0,-1);
                if y <= 7 then kolejka_l:=kolejka_l+ZliczKierunek(x,y+1,klr,0,1);
                if kolejka_l >=4 then UsunRzad else Czysc;
               end;

    prawyskos: begin
                if (x >= 1) AND (y <= 7) then kolejka_l:=kolejka_l+ZliczKierunek(x-1,y+1,klr,-1,1);
                if (x <= 7) AND (y >= 1) then kolejka_l:=kolejka_l+ZliczKierunek(x+1,y-1,klr,1,-1);
                if kolejka_l >=4 then UsunRzad else Czysc;
               end;

    lewyskos: begin
                if (x >= 1) AND (y >= 1) then kolejka_l:=kolejka_l+ZliczKierunek(x-1,y-1,klr,-1,-1);
                if (x <= 7) AND (y <= 7) then kolejka_l:=kolejka_l+ZliczKierunek(x+1,y+1,klr,1,1);
                if kolejka_l >=4 then UsunRzad else Czysc;
               end;
   end;

 end;

begin
 result := false;

 x := Pole div 9; y:= Pole mod 9;
 klr:=tablica[x,y].kolor;
 kolejka_l:=0; setlength(kolejka,1); kolejka[0]:= Pole;

 WybierzKierunek(pion);
 WybierzKierunek(poziom);
 WybierzKierunek(prawyskos);
 WybierzKierunek(lewyskos);
end;

procedure Tfrm9x9.LosujKolory;
var
 x,i : byte;
begin
 for i := 0 to 2 do
  begin
   x := random(6);
   trzy_kolory[i].kolor := x;
  end;
end;

procedure Tfrm9x9.LosujTrzyPola;
var
 x,i : byte;
begin
 i:=0;
 repeat
  x := random(B9x9.MaxNr+1);
  if x in B9x9.LosoweMiejsce then
   begin
    inc(i);
    UstawWierzcholek(x,true);
    tablica[x div 9,x mod 9].kolor := trzy_kolory[i-1].kolor;
    Zliczanie(x);
    Sleep(95);
    Application.ProcessMessages;
   end;
 until (i=3) or (B9x9.MaxNr=255);
 LosujKolory;
end;


procedure Tfrm9x9.spbnStartClick(Sender: TObject);
 var i,j : byte;
begin
 if not Tablica[0,0].Enabled then
  for i:=0 to 8 do
   for j:=0 to 8 do
    Tablica[i,j].Enabled := TRUE;

 if not (Assigned (B9x9)) then
  begin
   B9x9 := T9x9.Create;
   B9x9.OnUpdate := WUpdate;
   lblWynik.Caption := inttostr(B9x9.Wynik);
   B9x9.RozpocznijGre;
  end
 else if (MessageBox(Handle,'Chcesz rozpocz¹æ now¹ grê?','9x9 - Koniec gry?',MB_OKCANCEL)) = IDOK
          then frm9x9.Przeladuj;
end;


procedure Tfrm9x9.Najlepszewyniki1Click(Sender: TObject);
begin
 BWynik:=0;
 frmNWyniki.Odswiez;
 frmNWyniki.ShowModal;
end;

procedure Tfrm9x9.mitemTrayClick(Sender: TObject);
var
 rejestr : TRegistry;
begin
 mitemTray.Checked := NOT(mitemTray.Checked);
 rejestr := TRegistry.Create;
 try
  rejestr.RootKey := HKEY_CURRENT_USER;
  rejestr.OpenKey('\Software\9x9',true);
  rejestr.WriteBool('tray',mitemTray.Checked);
  rejestr.CloseKey;
 finally
  rejestr.Free;
 end;
end;

procedure Tfrm9x9.actAboutExecute(Sender: TObject);
begin
 with TfrmAbout.Create(self) do
  ShowModal;
end;

procedure Tfrm9x9.actCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure Tfrm9x9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(B9x9) then B9x9.ZakonczGre;
 Shell_NotifyIcon(Nim_Delete, @TrayIconData);
end;

procedure Tfrm9x9.mitemSkrotClick(Sender: TObject);
var
 sciezka : string;
 wsciezka  : widestring;
 iobiekt : IUnknown;
 skrot : IShellLink;
 skrot_plik : IPersistFile;

begin
  iobiekt := CreateComObject(CLSID_ShellLink);
  skrot := iobiekt as IShellLink;
  skrot_plik := iobiekt as IPersistFile;
  sciezka := Application.ExeName;
  with skrot do begin
    SetPath(PChar(sciezka));
    SetArguments('');
    SetWorkingDirectory(PChar(ExtractFilePath(sciezka)));
  end;
  wsciezka := pulpit+'\9x9.lnk';
  skrot_plik.Save(PWChar(wsciezka),False);

  mitemSkrot.Enabled := false;
end;

{ T9x9 }

procedure T9x9.RozpocznijGre;
var
 i,j : byte;
begin
 for j:=0 to 8 do
  for i:=0 to 8 do
   if tablica[j,i].Kolor <> high(kolory) then tablica[j,i].Kolor := high(kolory);

 Inicjuj;
 Randomize;
 frm9x9.LosujKolory; frm9x9.LosujTrzyPola;
end;

procedure Tfrm9x9.WUpdate(Sender: TObject);
begin
 lblWynik.Caption := inttostr(B9x9.wynik);
end;

procedure T9x9.ZakonczGre;
begin
 BWynik := B9x9.Wynik;
 if frmNWyniki.Odswiez then frmNWyniki.ShowModal;
 FreeAndNil(B9x9);
end;

procedure Tfrm9x9.Przeladuj;
begin
 spbnStart.Down := true;
 B9x9.ZakonczGre;
 spbnStartClick(nil);
end;




end.
