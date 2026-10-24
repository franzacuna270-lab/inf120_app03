unit ucadena;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uconjunto, Dialogs;
const
  MAX_ELEM=5000;
type

  { TCadena }

  TCadena=class
    private
      elem:array[1..MAX_ELEM]of char;
      dim:integer;
      may,min,dig,sep:TConjunto;
    public
      constructor crear();
      procedure setDim(dime:integer);
      function  getDim():integer;
      procedure setChar(pos:integer;ele:char);
      function  getChar(pos:integer):char;
      procedure addChar(ele:char);
      procedure insChar(pos:integer; ele:char);
      procedure remChar(pos:integer);
      procedure leerPal(var pos:integer;var pal:string);
      function  cantPal():integer;
      function  busqPal(palB:string):integer;
      procedure addPal(pal:string);
      procedure insPal(pos:integer;pal:string);
      procedure remPal(pal:string);
      procedure camPal(palE,palN:string);
      procedure addCar(ele:string);
      procedure inscar(pos:integer;ele:string);
      procedure remchar(ele:char);
      procedure intercar(pos1,pos2:integer);
      function cantchar():integer;
      procedure invertir();
      procedure rotar();
      procedure amayus();
      procedure aminus();
      procedure atitu();//ctrl+shif+c
  end;

implementation

{ TCadena }

constructor TCadena.crear();
var
  pos:integer;
begin
  dim:=0;
  for pos:=1 to MAX_ELEM do
    elem[pos]:=char(0);//null
  May:=TConjunto.crear();//inicializar may
  for pos:=0 to 25 do
    May.agregar(char(65+pos));
  Min:=TConjunto.crear();
  for pos:=0 to 25 do
    Min.agregar(char(97+pos));
  Dig:=TConjunto.crear();
  for pos:=0 to 9 do
    Dig.agregar(char(48+pos));
  Sep:=TConjunto.crear();
  Sep.agregar('-');
  Sep.agregar('_');
  Sep.agregar(',');
  Sep.agregar('.');
  Sep.agregar(':');
  Sep.agregar(';');
  Sep.agregar('#');
  Sep.agregar(' ');
end;

procedure TCadena.setDim(dime: integer);
begin
  if(dime>=0)and(dime<=MAX_ELEM)then
    dim:=dime
  else
    showMessage('TCadena::setDim: dimension fuera de rango...');
end;

function TCadena.getDim(): integer;
begin
  result:=dim;
end;

procedure TCadena.setChar(pos: integer; ele: char);
begin
  if(pos>=1)and(pos<=dim)then
    elem[pos]:=ele
  else
    showMessage('dimension fuera de rango...');
end;

function TCadena.getChar(pos: integer): char;
begin
  if(dim<MAX_ELEM)then
    result:=elem[pos]
  else
    result:=char(0);//NULL
end;

procedure TCadena.addChar(ele: char);
begin
  if(dim<MAX_ELEM)then
    begin
      dim:=dim+1;
      elem[dim]:=ele;
    end;
end;

procedure TCadena.insChar(pos: integer; ele: char);
var
  des:integer;
begin
  if(pos>=1)and(pos<=dim)then
    begin
      for des:=dim downto pos do
        elem[des+1]:=elem[des];
      elem[pos]:=ele;
      dim:=dim+1;
    end
  else
    showMessage('TCadena:insChar: posicion fuera de rango...');
end;

procedure TCadena.remChar(pos: integer);
var
  des:integer;
begin
  if(pos>=1)and(pos<=dim)then      //eleminarchar
    begin
      for des:=pos to dim-1 do
        elem[des]:=elem[des+1];
      dim:=dim-1;
    end
  else
    showMessage('Posicion fuera de rango...');
end;

procedure TCadena.leerPal(var pos: integer; var pal: string);
begin
  pal:='';
  while(pos<=dim)and(not sep.pertenece(elem[pos]))do
    begin
      pal:=pal+elem[pos];
      pos:=pos+1;
    end;
  while(pos<dim)and(sep.pertenece(elem[pos]))do
    pos:=pos+1;
end;

function TCadena.cantPal(): integer;
var
  cp,pos:integer;
  pal:string;
begin
  cp:=0;
  pos:=1;
  while(pos<=dim)do
    begin
      leerPal(pos,pal);
      if(pal<>'')then
        cp:=cp+1;
    end;
  result:=cp;
end;

function TCadena.busqPal(palB: string): integer;
var
  pos,posant:integer;
  sw:boolean;
  pal:string;
begin
  sw:=false;
  pos:=1;
  while(pos<=dim)and(not sw)do
    begin
      posant:=pos;
      leerPal(pos,pal);
      if(pal=palB)then    //'Hola'='Hola'=>true
        sw:=true;         //'HOLA'='Hola'=>false
    end;
  if(sw)then
    result:=posant
  else
    result:=-1;
end;

procedure TCadena.addPal(pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(dim+n+1<MAX_ELEM)then  //hay espacio en la palabra
    begin
      addChar(' ');
      for des:=1 to n do
        addChar(pal[des]);
    end
  else
    showMessage('Almacenamiento lleno...')
end;

procedure TCadena.insPal(pos: integer; pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(pos>=1)and(pos<=dim+1)and(dim+n+2<=MAX_ELEM)then
    begin
      insChar(pos,' ');
      for des:=1 to n do
        insChar(pos+des,pal[des]);
      insChar(pos+n+1,' ');
    end
  else
    showMessage('No hay espacio de almacenamiento');
end;

procedure TCadena.remPal(pal: string);
var
  pos,n,des:integer;
begin
  pos:=busqPal(pal);
  if(pos<>-1)then
    begin
      n:=length(pal);
      for des:=1 to n do
        remChar(pos);
      if(pos<=dim)and(sep.pertenece(elem[pos]))then
        remChar(pos);
      if(pos>1)and(sep.pertenece(elem[pos-1]))then
        remChar(pos-1);
    end
  else
    showMessage('La palabra no existe..');
end;

procedure TCadena.camPal(palE, palN: string);
var
  pos:integer;
begin
  pos:=busqPal(palE);
  if(pos<>-1)then
    begin
      remPal(PalE);
      insPal(pos-1,PalN);
    end
  else
    showMessage('La palabra no existe...');
end;

procedure TCadena.addCar(ele: string);
begin
  if(length(ele)>0)then
    addchar(ele[1])
  else
    showMessage('TCadena::addCar: caracter vacion...');
end;

procedure TCadena.inscar(pos: integer; ele: string);
begin
  if(length(ele)>0)then
    inschar(pos,ele[1])
  else
    showMessage('TCadena::inscar: caracter vacion...');
end;

procedure TCadena.remchar(ele:char);
var
  pos:integer;
begin
  pos:=1;
  while(pos<=dim)do
    begin
      if(elem[pos]=ele)then
        remchar(pos)
      else
        pos:=pos+1;
    end;
end;

procedure TCadena.intercar(pos1,pos2: integer);
var
  aux:char;
begin
  if(pos1>=1)and(pos1<=dim)and(pos2>=1)and(pos2<=dim)then
    begin
      aux:=elem[pos1];
      elem[pos1]:=elem[pos2];
      elem[pos2]:=aux;
    end
  else
    showMessage('TCadena::intercar: posicion fuera de rango...');
end;

function TCadena.cantchar(): integer;
var
  pos,cc:integer;
begin
  cc:=0;
  for pos:=1 to dim do
    begin
      if(not sep.pertenece(elem[pos]))then
        cc:=cc+1;
    end;
  result:=cc;
end;

procedure TCadena.invertir();
var
  i,j:integer;aux:char;
begin
  i:=1;j:=dim;
  while(i<j)do
    begin
      aux:=elem[i];
      elem[i]:=elem[j];
      elem[j]:=aux;
      i:=i+1;
      j:=j-1;
    end;
end;

procedure TCadena.rotar();
var
  ult:char;pos:integer;
begin
  ult:=elem[dim];
  for pos:=dim downto 2 do
    elem[pos]:=elem[pos-1];
  elem[1]:=ult;
end;

procedure TCadena.amayus();
var
  pos:integer;
begin
  for pos:=1 to dim do
    begin
      if(min.pertenece(elem[pos]))then
        elem[pos]:=UpCase(elem[pos]);
    end;
end;

procedure TCadena.aminus();
var
  pos:integer;
begin
  for pos:=1 to dim do
    begin
      if(may.pertenece(elem[pos]))then
        elem[pos]:=chr(ord(elem[pos])+32);
    end;
end;

procedure TCadena.atitu();
var
  pos:integer;
begin
  aminus();
  if(dim>=1)then
    elem[1]:=UpCase(elem[1]);
  for pos:=2 to dim do
    begin
      if(sep.pertenece(elem[pos-1]))then
        elem[pos]:=UpCase(elem[pos]);
    end;
end;

end.

