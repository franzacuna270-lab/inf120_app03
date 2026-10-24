unit fventana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, ucadena, uconjunto;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button2: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    POS: TEdit;
    ELE: TEdit;
    Label1: TLabel;
    SG: TStringGrid;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    c:TCadena;
    procedure updateSG();
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  c:=TCadena.crear();   //crear
  updateSG();
  showMessage('cadena de caracteres Inicializada...');
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  C.setDim(StrToInt(POS.Text));
  updateSG();
  POS.Text:='';
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  POS.Text:=IntToStr(C.getDim());
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  C.setChar(StrToInt(POS.Text),ELE.Text[1]);
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
  ELE.Text:=C.getChar(StrToInt(POS.Text));
  POS.Text:='';
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  C.inscar(StrToInt(POS.Text),ELE.Text[1]);
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  C.remchar(ELE.Text[1]);
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  C.intercar(StrToInt(POS.Text),StrToInt(ELE.Text));
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  POS.Text:=IntToStr(C.cantchar());
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  C.invertir();
  updateSG();
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  C.rotar();
  updateSG();
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  C.amayus();
  updateSG();
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  C.aminus();
  updateSG();
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  C.atitu();
  updateSG();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  POS.Text:=IntToStr(C.cantPal()); //CANTPAL
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  POS.Text:=IntToStr(C.busqPal(ELE.Text));  //busqpal
  ELE.Text:='';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  C.addPal(ELE.Text); //addpal
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  C.insPal(StrToInt(POS.Text),ELE.Text);  //inspal
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  C.remPAL(ELE.Text);  //elimpal
  updateSG();
  ELE.Text:='';
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  C.camPal(POS.Text,ELE.Text);
  updateSG();
  POS.Text:='';
  ELE.Text:='';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  close();
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  C.addCar(ELE.Text[1]);
  updateSG();
  ELE.Text:='';
end;

procedure TForm1.updateSG();
var
  des:integer;
begin
  SG.ColCount:=C.getDim();
  for des:=1 to C.getDim()do
    SG.Cells[des-1,0]:=C.getChar(des);
end;

end.

