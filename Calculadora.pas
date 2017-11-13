unit Calculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TForm3 = class(TForm)
    num7_B: TButton;
    num8_B: TButton;
    num9_B: TButton;
    opdiv_B: TButton;
    opcent_B: TButton;
    num4_B: TButton;
    num5_B: TButton;
    num6_B: TButton;
    opmult_B: TButton;
    opinverso_B: TButton;
    num1_B: TButton;
    num2_B: TButton;
    num3_B: TButton;
    opsub_B: TButton;
    Clear_B: TButton;
    num0_B: TButton;
    virg_B: TButton;
    opsoma_B: TButton;
    opcalc_B: TButton;
    visor: TEdit;
    memo: TMemo;
    procedure Clear_BClick(Sender: TObject);
    procedure num0_BClick(Sender: TObject);
    procedure num1_BClick(Sender: TObject);
    procedure num2_BClick(Sender: TObject);
    procedure num3_BClick(Sender: TObject);
    procedure num4_BClick(Sender: TObject);
    procedure num5_BClick(Sender: TObject);
    procedure num6_BClick(Sender: TObject);
    procedure num7_BClick(Sender: TObject);
    procedure num8_BClick(Sender: TObject);
    procedure num9_BClick(Sender: TObject);
    procedure virg_BClick(Sender: TObject);
    procedure opsoma_BClick(Sender: TObject);
    procedure opsub_BClick(Sender: TObject);
    procedure opmult_BClick(Sender: TObject);
    procedure opdiv_BClick(Sender: TObject);
    procedure opcalc_BClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  //CABEÇALHO DE PROCESSAMENTO
  //essas 3 variaveis comandam o fluxo dos processos neste programa
  subtotal        :       Double; //  armazena os valores calculados
  operacao        :       Char; //  define a operação a ser executada
  log             :       string; //  armazena o resultado de cada processo.

implementation

{$R *.dfm}

procedure TForm3.Clear_BClick(Sender: TObject);
//reseta a calculadora limpando o cabeçalho de processamento
begin
  subtotal        :=          0.0;
  operacao        :=          '0';
  visor.Clear();
end;


procedure TForm3.num0_BClick(Sender: TObject);
//escreve um 0 no visor
begin
  if (visor.Text <> '0') then
    //verifico se a string atual é '0' para evitar strings como '000000...'
    visor.Text := visor.Text + '0';
end;

procedure TForm3.num1_BClick(Sender: TObject);
//escreve um 1 no visor
begin
  visor.Text := visor.Text + '1';
end;

procedure TForm3.num2_BClick(Sender: TObject);
//escreve um 2 no visor
begin
  visor.Text := visor.Text + '2';
end;

procedure TForm3.num3_BClick(Sender: TObject);
//escreve um 3 no visor
begin
  visor.Text := visor.Text + '3';
end;

procedure TForm3.num4_BClick(Sender: TObject);
//escreve um 4 no visor
begin
  visor.Text := visor.Text + '4';
end;

procedure TForm3.num5_BClick(Sender: TObject);
//escreve um 5 no visor
begin
  visor.Text := visor.Text + '5';
end;

procedure TForm3.num6_BClick(Sender: TObject);
//escreve um 6 no visor
begin
  visor.Text := visor.Text + '6';
end;

procedure TForm3.num7_BClick(Sender: TObject);
//escreve um 7 no visor
begin
  visor.Text := visor.Text + '7';
end;

procedure TForm3.num8_BClick(Sender: TObject);
//escreve um 8 no visor
begin
  visor.Text := visor.Text + '8';
end;

procedure TForm3.num9_BClick(Sender: TObject);
//escreve um 9 no visor
begin
  visor.Text := visor.Text + '9';
end;



procedure TForm3.opcalc_BClick(Sender: TObject);
var
  valor           :       double; //armazena um numero temporario lido do visor
begin
  if (visor.Text <> '') then //se o usuario não estiver de sacanagem com os botoes
  begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a operação anterior
  case operacao of
    '+':
        begin
          subtotal      :=   subtotal + valor;
          log           :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

    '-':
        begin
          subtotal   :=   subtotal - valor;
          log        :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

    'x':
        begin
          subtotal   :=   subtotal * valor;
          log        :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

    'd':
        begin
          subtotal   :=   subtotal / valor;
          log        :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

    else
        begin
          subtotal   :=   valor;
          log        :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

  end;
  operacao := '0';
  visor.Text         :=   subtotal.ToString;
  memo.Text := log;

end;
end;

procedure TForm3.opdiv_BClick(Sender: TObject);
var
  valor           :       double; //armazena um numero temporario lido do visor
begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a operação anterior
  case operacao of
    '+':
        begin
          subtotal      :=      subtotal + valor;
          log           :=      log + valor.ToString + ' ';
        end;

    '-':
        begin
          subtotal      :=      subtotal - valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'x':
        begin
          subtotal      :=      subtotal * valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'd':
        begin
          subtotal      :=      subtotal / valor;
          log           :=      log + valor.ToString + ' ';
        end;

    else
        begin
          subtotal      :=      valor;
          log           :=      log + '' + valor.ToString + ' ';
        end;

  end;
  operacao              :=      'd';
  log                   :=      log + '/ ';
  visor.Clear();
end;

procedure TForm3.opmult_BClick(Sender: TObject);
var
  valor           :       double; //armazena um numero temporario lido do visor
begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a operação anterior
  case operacao of
    '+':
        begin
          subtotal      :=      subtotal + valor;
          log           :=      log + valor.ToString + ' ';
        end;

    '-':
        begin
          subtotal      :=      subtotal - valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'x':
        begin
          subtotal      :=      subtotal * valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'd':
        begin
          subtotal      :=      subtotal / valor;
          log           :=      log + valor.ToString + ' ';
        end;

    else
        begin
          subtotal      :=      valor;
          log           :=      log + '' + valor.ToString + ' ';
        end;

  end;
  operacao              :=      'x';
  log                   :=      log + 'x ';
  visor.Clear();
end;

procedure TForm3.opsoma_BClick(Sender: TObject);
var
  valor           :       double; //armazena um numero temporario lido do visor
begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a operação anterior
  case operacao of
    '+':
        begin
          subtotal      :=      subtotal + valor;
          log           :=      log + valor.ToString + ' ';
        end;

    '-':
        begin
          subtotal      :=      subtotal - valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'x':
        begin
          subtotal      :=      subtotal * valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'd':
        begin
          subtotal      :=      subtotal / valor;
          log           :=      log + valor.ToString + ' ';
        end;

    else
        begin
          subtotal      :=      valor;
          log           :=      log + '' + valor.ToString + ' ';
        end;

  end;
  operacao              :=      '+';
  log                   :=      log + '+ ';
  visor.Clear();
end;



procedure TForm3.opsub_BClick(Sender: TObject);
var
  valor           :       double; //armazena um numero temporario lido do visor
begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a operação anterior
  case operacao of
    '+':
        begin
          subtotal      :=      subtotal + valor;
          log           :=      log + valor.ToString + ' ';
        end;

    '-':
        begin
          subtotal      :=      subtotal - valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'x':
        begin
          subtotal      :=      subtotal * valor;
          log           :=      log + valor.ToString + ' ';
        end;

    'd':
        begin
          subtotal      :=      subtotal / valor;
          log           :=      log + valor.ToString + ' ';
        end;

    else
        begin
          subtotal      :=      valor;
          log           :=      log + '' + valor.ToString + ' ';
        end;

  end;
  operacao              :=      '-';
  log                   :=      log + '- ';
  visor.Clear();
end;

procedure TForm3.virg_BClick(Sender: TObject);
//escreve uma virgula no visor
begin
   if (Pos(',', visor.Text) = 0) then
   //verificação para garantir que não exista mais do que 1 virgula no numero
   begin
    if (visor.Text <> '') then
      //evito que saia um numero quebrado sem definir uma unidade
      visor.Text := visor.Text + ',';
    end;
  end;

end.
