program Calc;

uses
  Vcl.Forms,
  Calculadora in 'Calculadora.pas' {CalcForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCalcForm, CalcForm);
  Application.Run;
end.
