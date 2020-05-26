unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    b41: TButton;
    B42: TButton;
    Button1: TButton;
    BWczytaj: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LPlik: TLabel;
    LminLuka: TLabel;
    LmaxLuka: TLabel;
    procedure b41Click(Sender: TObject);
    procedure B42Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BWczytajClick(Sender: TObject);
    function dajLuke(i:integer):Integer;
    procedure dajRegularny(pocz: Integer; var len, koncowy, luka: Integer);
  private

  public

  end;

var
  Form1: TForm1;



implementation
 const N=1000;

var
  plik : TextFile;
  ciag : array[0..N-1] of Integer;
  ileLiczb : Integer;

{$R *.lfm}

{ TForm1 }

procedure TForm1.BWczytajClick(Sender: TObject);
var i: integer;
begin
  AssignFile(plik,'dane4.txt');
  reset(plik);
  i:=0;
  While not Eof(plik) do begin
    readln(plik,ciag[i]);
    i:=i+1;
  end;
  ileLiczb:=i;
  LPlik.Caption:='';
  for i:=0 to ileLiczb-1 do
    LPlik.Caption:=Lplik.Caption+IntToStr(ciag[i])+'   ';
end;

function TForm1.dajLuke(i: integer): Integer;
Begin
 Result := Abs(ciag[i+1]-ciag[i]);
End;

procedure TForm1.dajRegularny(pocz: Integer; var len, koncowy, luka: Integer);
var i,cLuka:Integer;
Begin
 cLuka := dajLuke(pocz);
 for i:=pocz to ileLiczb-1 do begin
   if dajLuke(i) <> cLuka then break;
 end;
 len := 1 + i-pocz;
 koncowy := ciag[i];
 luka := cLuka;
End;

procedure TForm1.b41Click(Sender: TObject);
var minL, maxL : Integer;
    i : Integer;
    cLuka : Integer;  //c - current
Begin
  minL := MaxInt;
  maxL := -1;
  for i:=0 to ileLiczb-1 do begin
    cLuka := dajLuke(i);
    if cLuka < minL then minL := cLuka;
    if cLuka > maxL then maxL := cLuka;
  end;
  LminLuka.Caption:=IntToStr(minL);
  LmaxLuka.Caption:=IntToStr(maxL);
End;

var ii:integer = -1;
procedure TForm1.B42Click(Sender: TObject);
var i,j:Integer;

    len,koncowy,luka:integer;
Begin
  ii := ii+1;
  if ii>ileLiczb-1 then Exit;
  dajRegularny(ii,len,koncowy,luka);
  Label1.Caption:=Label1.Caption+#13#10+'elem: '+IntToStr(ii)+',  len='+IntToStr(len)+',  koncowy='+IntToStr(koncowy)+',  luka='+IntToStr(luka);
End;

procedure TForm1.Button1Click(Sender: TObject);
var
 i:integer;
 cLen, cEnd, cLuka : Integer;
 maxLen : Integer;
 poczatkowy,koncowy, lukaNajlepszego:Integer;
Begin
  maxLen := 0;
  for i:=0 to ileLiczb-2 do begin
    dajRegularny(i,cLen,cEnd,cLuka);
    if cLen >= maxLen then begin
      maxLen := cLen;
      poczatkowy:=i;
      koncowy:=cEnd;
      lukaNajlepszego:=cLuka;
    end;
  end;
  //parametry 'najlepszego' podciagu:
  Label2.Caption:='startowy: '+IntToStr(poczatkowy)+'  Length: '+IntToStr(maxLen)+'  Koncowy: '+IntToStr(koncowy)+'  Luka: '+IntToStr(lukaNajlepszego);
End;

end.

