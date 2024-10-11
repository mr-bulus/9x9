unit uInterf;

interface

uses Buttons,Controls,ExtCtrls,Classes;

type

 Kolory = 0..7;
 Wierzcholki = 0..80;

 TNButton = class (TSpeedButton)
  private
    KolorPola : Kolory;
    function GetKolor: byte;
    procedure SetKolor(const Value: byte);
  public
   nr : byte;
   property Kolor : Byte read GetKolor write SetKolor;
 end;

 TImageX = class (Timage)
  private
   wylosowanykolor : Kolory;
    function GetKolor: Byte;
    procedure SetKolor(const Value: Byte);
  public
   property Kolor : Byte read GetKolor write SetKolor;
 end;

 TGra = class
  private
    FWynik: Word;
    FOnUpdate: TNotifyEvent;
    procedure SetWynik(const Value: Word);
    procedure DoUpdate;
   public
     MaxNr : byte;
     PoprzPole : 0..81;
     LosoweMiejsce : set of Wierzcholki;
     property Wynik : Word read FWynik write SetWynik;
     property OnUpdate : TNotifyEvent read FOnUpdate write FOnUpdate;
     procedure RozpocznijGre; virtual; abstract;
     procedure ZakonczGre; virtual; abstract;
     constructor Create;
  end;

var
 lista : TImageList;

implementation

{ TNButton }

function TNButton.GetKolor: Byte;
begin
 result := KolorPola;
end;

procedure TNButton.SetKolor(const Value: Byte);
begin
 KolorPola := Value;
 Glyph := nil;
 if Value < high(Kolory) then lista.GetBitmap(Value,Glyph);

end;

{ TImageX }

function TImageX.GetKolor: Byte;
begin
 result := wylosowanykolor;
end;

procedure TImageX.SetKolor(const Value: Byte);
begin
 wylosowanykolor := Value;
 Picture.Bitmap:=nil;
 lista.GetBitmap(wylosowanykolor,Picture.Bitmap);
end;

{ TGra }

constructor TGra.Create;
begin
 Wynik := 0;
 MaxNr := 80;
 LosoweMiejsce := [0..80];
 PoprzPole := 81;
end;

procedure TGra.DoUpdate;
begin
  if Assigned (FOnUpdate) then
    FOnUpdate (Self);
end;

procedure TGra.SetWynik(const Value: Word);
begin
  FWynik := Value;
  DoUpdate;
end;


end.
