unit uNWyniki;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmNWyniki = class(TForm)
    pnlNWyniki: TPanel;
    btnZamknij: TButton;
    procedure FormCreate(Sender: TObject);
    function Odswiez: boolean;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnZamknijClick(Sender: TObject);
  private
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNWyniki: TfrmNWyniki;
  BWynik : word;  //bie¿¹cy wynik

implementation

{$R *.dfm}

type
 tab_wyniki = array [1..10] of TLabel;

var
  plik : TFileStream;
  edycja : TEdit;
  WynikNiewstawiony : boolean;
  nazwa, wartosc : tab_wyniki;
  k : byte;

  rec : record
   nazwa : string [10];
   wynik : word;
  end;

procedure TfrmNWyniki.FormCreate(Sender: TObject);
var
 i : byte;
begin
 for i:=1 to 10 do
  begin
    nazwa[i] := TLabel.Create(self);
    wartosc[i] := TLabel.Create(self);
    with (nazwa[i]) do
     begin
     left := 15;
     top := 20+(i-1)*17+(i-1)*10;
     height := 17;
     width := 70;
     font.Size := 11;
     caption := '';
     parent := pnlNWyniki;
     end;
    with (wartosc[i]) do
     begin
     left := 220;
     top := 20+(i-1)*17+(i-1)*10;
     height := 17;
     width := 70;
     font.Size := 11;
     caption := '0';
     parent := pnlNWyniki;
     end;
  end;
end;

procedure TfrmNWyniki.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 nazwa[k].Caption:= (sender as TEdit).Text;
 if key = vk_return then
  begin
   (sender as Tedit).Visible:=false;
   nazwa[k].Visible:=true;
   btnZamknij.SetFocus;
  end;
end;

function TfrmNWyniki.Odswiez : boolean;
var
 i,j : byte;

 procedure Wstaw;
 begin
  nazwa[j].Caption:=rec.nazwa;
  wartosc[j].Caption:=inttostr(rec.wynik);
  dec(i); inc(j);
 end;

 procedure Edytuj;
 begin
  result := true;
  wartosc[j].caption:=inttostr(BWynik);
  nazwa[j].Visible:=false;
  edycja := TEdit.Create(self);
  with edycja do
  begin
   Left := nazwa[j].Left;
   Top :=  nazwa[j].top;
   font.Size := 11;
   width := 165;
   BorderStyle := bsNone;
   Color := clBtnFace;
   Parent := pnlNWyniki;
   MaxLength := 10;
   k:=j;
   OnKeyDown := Edit2KeyDown;
  end;
 end;

begin
 result := false;
 WynikNiewstawiony:=true;
 if not (FileExists ('score.txt')) then
  plik := TFileStream.Create('score.txt',fmCreate)
 else
  plik := TFileStream.Create('score.txt',fmOpenRead);

 k:=0;
 i:= plik.Size div 14; j:=1;
  if i>0 then
   while (i >=1) do
   begin
    plik.ReadBuffer(Rec, SizeOf(Rec));
    if WynikNiewstawiony AND (BWynik > rec.wynik) then
    begin
     Edytuj;
     WynikNiewstawiony:=false; inc(j); dec(i);
     Wstaw;
    end else Wstaw;
   end
  else if (BWynik > 0) then Edytuj;
  plik.Free;
end;


procedure TfrmNWyniki.FormShow(Sender: TObject);
begin
 if Assigned (edycja) then edycja.SetFocus;
end;

procedure TfrmNWyniki.FormClose(Sender: TObject; var Action: TCloseAction);
var
 i : byte;
begin
 if Assigned (edycja) then FreeAndNil(edycja);
 if k > 0 then
  begin
   plik := TFileStream.Create('score.txt',fmOpenWrite);
   try
    plik.Seek(SizeOf(Rec)*(k-1),soFromBeginning);
    for i:=k to 10 do
     begin
      rec.nazwa := nazwa[i].Caption;
      rec.wynik := strtoint(wartosc[i].caption);
      plik.WriteBuffer(Rec, SizeOf(Rec));
     end;
   finally
    plik.Free;
   end;
  end;
end;

procedure TfrmNWyniki.btnZamknijClick(Sender: TObject);
begin
 Close;
end;

end.
