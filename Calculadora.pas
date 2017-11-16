{
 Autor: Mateus Garcia Lopes
 E-Mail: mateus.gigainfo@gmail.com

 Desenvolvido como atividade de fixa��o de conte�dos do curso de Delphi
 ministrado pela Databelli em parceria com a cat�lica de Vit�ria nos
 laborat�rios da UCV em 12/11/2017

 Disponivel sob Licen�a GPL 3.0 em https://github.com/NaturesProphet
 c�digo compat�vel com wine para rodar no Linux ;)
 testado no Debian 9 "Stretch" amd64, Windows 10 x64 e Windows 7 x32
}

unit Calculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TCalcForm = class(TForm)

    //DECLARA��O DOS BOT�ES
    num0_B: TButton;                             //botao 0
    num1_B: TButton;                             //botao 1
    num2_B: TButton;                             //botao 2
    num3_B: TButton;                             //botao 3
    num4_B: TButton;                             //botao 4
    num5_B: TButton;                             //botao 5
    num6_B: TButton;                             //botao 6
    num7_B: TButton;                             //botao 7
    num8_B: TButton;                             //botao 8
    num9_B: TButton;                             //botao 9
    virg_B: TButton;                             //botao de virgula decimal
    opdiv_B: TButton;                            //botao DIVIS�O
    opcent_B: TButton;                           //botao de Porcentagem
    opsoma_B: TButton;                           //botao SOMA
    opmult_B: TButton;                           //botao MULTIPLICA��O
    opinverso_B: TButton;                        //botao de invers�o (RUSSIA!!)
    opsub_B: TButton;                            //botao SUBTRA��O
    Clear_B: TButton;                            //botao CLEAR (limpa e reseta)
    opcalc_B: TButton;                           //botao =

    //DECLARA��O DAS ESTRUTURAS
    visor: TEdit;                                //visor da calculadora
    memo: TMemo;                                 //tela de Logs

    //DECLARA��O DAS SUB-ROTINAS
    procedure Clear_BClick(Sender: TObject);     //reseta a calculadora
    procedure num0_BClick(Sender: TObject);      //escreve 0 no visor
    procedure num1_BClick(Sender: TObject);      //escreve 1 no visor
    procedure num2_BClick(Sender: TObject);      //escreve 2 no visor
    procedure num3_BClick(Sender: TObject);      //escreve 3 no visor
    procedure num4_BClick(Sender: TObject);      //escreve 4 no visor
    procedure num5_BClick(Sender: TObject);      //escreve 5 no visor
    procedure num6_BClick(Sender: TObject);      //escreve 6 no visor
    procedure num7_BClick(Sender: TObject);      //escreve 7 no visor
    procedure num8_BClick(Sender: TObject);      //escreve 8 no visor
    procedure num9_BClick(Sender: TObject);      //escreve 9 no visor
    procedure virg_BClick(Sender: TObject);      //escreve ',' no visor
    procedure opsoma_BClick(Sender: TObject);    //efetua uma soma
    procedure opsub_BClick(Sender: TObject);     //efetua uma subtra��o
    procedure opmult_BClick(Sender: TObject);    //efetua uma multiplica��o
    procedure opdiv_BClick(Sender: TObject);     //efetua uma divis�o
    procedure opcent_BClick(Sender: TObject);    //processa porcentagems
    procedure opinverso_BClick(Sender: TObject); //processa invers�es
    procedure opcalc_BClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);    //processa e exibe o valor final

  end;

var
  CalcForm: TCalcForm;
  //CABE�ALHO DE PROCESSAMENTO
  //essas 3 variaveis comandam o fluxo dos processos neste programa
  subtotal        :       Double; //  armazena os valores calculados
  operacao        :       Char;   //  define a opera��o a ser executada
  log             :       string; //  armazena o resultado de cada processo.

implementation

{$R *.dfm}
{
  esta sub-rotina processa os valores inseridos de maneira iterativa,
  verificando a opera��o imediatamente anterior � atual e efetuando
  o calculo relativo a esta opera��o (quando houver).
  a procedure recebe 2 par�metros para trabalhar:
  1 char contendo o m�todo (divisao, adi��o multiplica��o etc..)
  1 double contendo o valor atual no visor da calculadora (ultimo numero inserido)
}
procedure calcula( metodo : Char; numero: double );
begin
  // verifica a opera��o anterior
  case operacao of
    '+':
        begin
          subtotal      :=      subtotal + numero;
          log           :=      log + numero.ToString + ' ';
        end;

    '-':
        begin
          subtotal      :=      subtotal - numero;
          log           :=      log + numero.ToString + ' ';
        end;

    'x':
        begin
          subtotal      :=      subtotal * numero;
          log           :=      log + numero.ToString + ' ';
        end;

    '/':
        begin
          if (numero <> 0) then   //tratar divis�es por 0
          begin
            subtotal      :=      subtotal / numero;
            log           :=      log + numero.ToString + ' ';
          end else begin
            log           :=      'ERRO: Divis�o por 0'+ #13#10;
            ShowMessage('N�o consigo dividir por 0.' + #13#10 +
            'O �nico que ja fez isto foi Chuck Norris');
            subtotal        :=          0.0;
          end; //fim do IF
        end;   //fim do case'/'


        {
          observe que processamentos de porcentagem e invers�es s�o processados 
          "in-loco" no local em que forem invocados e n�o est�o nesta subrotina
        }

    else //caso seja a primeira inser��o, o char de metodos estar� com um 0
        begin
          subtotal      :=      numero;
          log           :=      log + '' + numero.ToString + ' ';
        end;

  end; //fim do switch/case

  //if para prevenir erro de metodo incorreto (corre��o da falha)
  if ( log <> ('ERRO: Divis�o por 0'+ #13#10) ) then begin
  //se uma divis�o po zero n�o ocorreu, este � o procedimento normal
  operacao              :=      metodo;
  log                   :=      log + metodo + ' '; // trecho de log da operacao
  end else begin
  //mas se uma divis�o por zero aconteceu, preciso ajustar a operacao para n�o
  //efetuar uma instru��o indevida e o log para nao exibir esta opera��o
    operacao            :=      '0';
    log                 :=      log + ' '; // trecho de log da operacao
  end;

end;




//reseta a calculadora limpando o cabe�alho de processamento
procedure TCalcForm.Clear_BClick(Sender: TObject);
begin
  subtotal        :=          0.0;
  operacao        :=          '0';
  visor.Clear();
end;




//insere uma virgula com seguran�a
procedure TCalcForm.virg_BClick(Sender: TObject);
begin
   if (Pos(',', visor.Text) = 0) then
   //verifica��o para garantir que n�o exista mais do que 1 virgula no numero
   begin
    if (visor.Text <> '') then
      //evito que saia um numero quebrado sem definir uma unidade
      visor.Text := visor.Text + ',';
    end;  //fim do if
  end;




//escreve o 0 no visor com seguran�a, evitando que haja mais de um 0 no come�o
procedure TCalcForm.num0_BClick(Sender: TObject);
begin
  if (visor.Text <> '0') then
    //verifico se a string atual � '0' para evitar strings como '000000...'
    visor.Text := visor.Text + '0';
end;




//escreve um 1 no visor
procedure TCalcForm.num1_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '1';
end;




//escreve um 2 no visor
procedure TCalcForm.num2_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '2';
end;





//escreve um 3 no visor
procedure TCalcForm.num3_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '3';
end;





//escreve um 4 no visor
procedure TCalcForm.num4_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '4';
end;




//escreve um 5 no visor
procedure TCalcForm.num5_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '5';
end;




//escreve um 6 no visor
procedure TCalcForm.num6_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '6';
end;




//escreve um 7 no visor
procedure TCalcForm.num7_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '7';
end;




//escreve um 8 no visor
procedure TCalcForm.num8_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '8';
end;




//escreve um 9 no visor
procedure TCalcForm.num9_BClick(Sender: TObject);
begin
  visor.Text := visor.Text + '9';
end;




//PROCESSA O VALOR FINAL E EXIBE O LOG !  invocado pelo bot�o '='
//parece com a procedure calcula(), por�m finaliza as itera��es e exibe o log
procedure TCalcForm.opcalc_BClick(Sender: TObject);

var
  valor           :       double; //armazena um numero temporario lido do visor

  
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
  valor           :=      StrToFloat(visor.Text); //le o valor atual do visor

  // verifica a opera��o anterior
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

    '/':
         begin
          if (valor <> 0) then   //tratar divis�es por 0
          begin
            subtotal      :=      subtotal / valor;
            log           :=      log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
          end else begin  //se o numero divisor for 0
            log           :=      'ERRO: Divis�o por 0'+ #13#10;
            ShowMessage('N�o consigo dividir por 0.' + #13#10 +
            'O �nico que ja fez isto foi Chuck Norris');
            operacao      :=      '0';
          end;
        end;

    else
        begin  //entao x = x e nao tem nada pra fazer;
          subtotal   :=   valor;
          log        :=   log + valor.ToString + ' = ' + subtotal.ToString + #13#10;
        end;

  end;
  operacao := '0';
  visor.Text         :=   subtotal.ToString;
  memo.Text := log;

end; //fim do IF
end;




//efetua a divis�o
procedure TCalcForm.opdiv_BClick(Sender: TObject);

begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    calcula('/', StrToFloat(visor.Text));
    visor.Clear();
  end;
end;





//efetua multiplica��o
procedure TCalcForm.opmult_BClick(Sender: TObject);
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    calcula('x', StrToFloat(visor.Text));
    visor.Clear();
  end;
end;




//efetua soma
procedure TCalcForm.opsoma_BClick(Sender: TObject);
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    calcula('+', StrToFloat(visor.Text));
    visor.Clear();
  end;
end;




//efetua subtra��o
procedure TCalcForm.opsub_BClick(Sender: TObject);
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    calcula('-', StrToFloat(visor.Text));
    visor.Clear();
  end;
end;




//efetua diretamente o processamento de porcentagem
procedure TCalcForm.opcent_BClick(Sender: TObject);
var
  num   :     Double;
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    num         :=    StrToFloat(visor.Text);
    log         :=    log + '<' + num.ToString + '% de '+subtotal.ToString+ '>' + ' ';
    visor.Text  :=    (subtotal * (num/100)).ToString;
  end;
end;





//efetua diretamente o processamento do inverso de x
procedure TCalcForm.opinverso_BClick(Sender: TObject);
var
  num   :     Double;
begin
  if (visor.Text <> '') then //se o usuario n�o estiver de sacanagem com os botoes
  begin
    num         :=    StrToFloat(visor.Text);
    if ( num <> 0) then  //impedir divis�es por 0
    begin
      log         :=    log + '<inversao de ' + num.ToString+ '>' + ' ';
      visor.Text  :=    (1/num).ToString;
    end else
      ShowMessage('N�o sou Chuck Norris.' +
      'N�o tenho poderes para inverter um zero');
  end;
end;




//PROCESSA OS EVENTOS DO TECLADO
//  (ou pelo menos, DEVERIA..... nao ta dando certo n sei pq)
procedure TCalcForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  teste: string;
begin
  if (key = VK_NUMPAD0) then
    num0_B.Click;

  if (key = VK_NUMPAD1) then
    num1_B.Click;

  if (key = VK_NUMPAD2) then
    num2_B.Click;

  if (key = VK_NUMPAD3) then
    num3_B.Click;

  if (key = VK_NUMPAD4) then
    num4_B.Click;

  if (key = VK_NUMPAD5) then
    num5_B.Click;

  if (key = VK_NUMPAD6) then
    num6_B.Click;

  if (key = VK_NUMPAD7) then
    num7_B.Click;

  if (key = VK_NUMPAD8) then
    num8_B.Click;

  if (key = VK_NUMPAD9) then
    num9_B.Click;

end;




end.      //fim do c�digo !!
