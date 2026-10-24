unit uconjunto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;
const
  MAX_ELE=256; //cantidad de elementos del codigo ASCII
type

  { TConjunto }

  TConjunto = Class
    private
      elem:array[1..MAX_ELE]of char;
      dim:integer;
    public
      constructor crear();
      procedure setDim(dime:integer);
      function getDim():integer;
      procedure setElem(pos:integer;ele:char);
      function getElem(pos:integer):char;
      function pertenece(ele:char):boolean;
      procedure agregar(ele:char);
      procedure remover(ele:char);    //CTRL+SHIFT+C
      procedure mostrar();
      procedure union(A,B:TConjunto);
  end;

implementation

{ TConjunto }

constructor TConjunto.crear();
var
  pos:integer;
begin
   dim := 0;
   for pos:=1 to MAX_ELE do
     elem[pos] := char(0);  //NULL
end;

procedure TConjunto.setDim(dime: integer);
begin
  if(dime>=0)AND(dime<=MAX_ELE)then
     dim := dime
  else
    writeln('TConjunto::setDim: Fuera de Rango...');
end;

function TConjunto.getDim(): integer;
begin
   result := dim;
end;

procedure TConjunto.setElem(pos: integer; ele: char);
begin
  if(pos>=1)AND(pos<=dim)then
     elem[pos] := ele
  else
    writeln('TConjunto::setElem: Fuera de Rango...');
end;

function TConjunto.getElem(pos: integer): char;
begin
  if(pos>=1)AND(pos<=dim)then
     result := elem[pos]
  else
    result := char(0); //NULL
end;

function TConjunto.pertenece(ele: char): boolean;
var
  pos:integer;
  sw:boolean;
begin
  sw  := false;
  pos := 1;
  while(pos<=dim)AND(not sw)do
  begin
     if(elem[pos]=ele)then
        sw := true
     else
        pos := pos + 1;
  end;
  result := sw;
end;

procedure TConjunto.agregar(ele: char);
begin
  if(NOT Pertenece(ele))then //Elemento no este en el Conjunto
  begin
    if(dim < MAX_ELE) then
      begin
        dim := dim + 1;
        elem[dim] := ele;
      end
    else
      writeln('TConjunto::agregar: Conjunto lleno...');
  end;
end;

procedure TConjunto.remover(ele: char);
var
  pos,des:integer;
  sw:boolean;
begin
  if(Pertenece(ele))then         //Si esta en el Conjunto
  begin
    sw  := false;
    pos := 1;
    while(pos<=dim)AND(NOT sw)do //busqueda
    begin
       if(elem[pos]=ele)then
          sw := true
       else
          pos := pos + 1;
    end;
    for des:=pos to dim-1 do    //desplazar hacia la izquierda
        elem[des]:=elem[des+1];
    dim := dim - 1;             // descontamos la dimensión
  end;
end;

procedure TConjunto.mostrar();
var
  pos:integer;
begin
  write('{');
  for pos:=1 to dim do
      write(elem[pos] , ',');
  writeln('}');
end;

procedure TConjunto.union(A, B: TConjunto);
var
  pos:integer;
begin
  dim := 0;
  for pos:=1 to A.getDim() do    //Todos los elementos de A
       agregar(A.getElem(pos));

  for pos:=1 to B.getDim() do    //Todos lo elementos de B que NO pertenecen a A
  begin
      if(NOT A.pertenece(B.getElem(pos)))then
  	agregar(B.getElem(pos));
  end;
end;

end.

