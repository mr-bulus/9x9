unit uPlansza;

interface

 procedure Inicjuj;
 procedure Wstaw (wierzcholek : byte);
 function Wylicz_trase (i,j : byte) : boolean;
 procedure Usun (wierzcholek : byte);

var
 TPP,TP1 : array [0..80,0..80] of byte;
 tab_droga  : array of byte;


implementation

procedure Droga;
var
 i,j,k: byte;

begin
  TP1:=TPP;

  for i:=0 to 80 do
   for j:=0 to 80 do
    if TP1[j,i]<>255 then
     for k:=0 to 80 do
      if ((TP1[j,k]=255) and (TP1[i,k]<>255)) then TP1[j,k]:=TP1[j,i];
end;


function wylicz_trase (i,j : byte) : boolean;
var
 k : byte;
begin
 Droga;
 if Tp1[i,j] <> 255 then
  begin
   k:=i;
   while (k<>j) do
    begin
     k:=Tp1[k,j];
     setlength(tab_droga,length(tab_droga)+1);
     tab_droga[high(tab_droga)]:=k;
    end;
   result := true;
  end
 else
  result := false;
end;



procedure Inicjuj;
var
 i,j : byte;
begin
 for j := 0 to 80 do
  for i:=0 to 80 do
   if ((abs(j-i)=1)  OR  (abs(j-i)=9)) then TPP[j,i]:=i else TPP[j,i]:=255;

 for i:=1 to 8 do
  begin
   TPP[i*9-1,i*9] := 255;
   TPP[i*9,i*9-1] := 255;
  end;
end;

procedure Wstaw (wierzcholek : byte);
begin
  if ((wierzcholek div 9) >= 1) then TPP[wierzcholek-9,wierzcholek]:=255;
  if ((wierzcholek div 9) <= 7) then TPP[wierzcholek+9,wierzcholek]:=255;
  if ((wierzcholek mod 9) >= 1) then TPP[wierzcholek-1,wierzcholek]:=255;
  if ((wierzcholek mod 9) <= 7) then TPP[wierzcholek+1,wierzcholek]:=255;
end;

procedure Usun (wierzcholek : byte);
begin
  if ((wierzcholek div 9) >= 1) then TPP[wierzcholek-9,wierzcholek]:=wierzcholek;
  if ((wierzcholek div 9) <= 7) then TPP[wierzcholek+9,wierzcholek]:=wierzcholek;
  if ((wierzcholek mod 9) >= 1) then TPP[wierzcholek-1,wierzcholek]:=wierzcholek;
  if ((wierzcholek mod 9) <= 7) then TPP[wierzcholek+1,wierzcholek]:=wierzcholek;
end;

end.
