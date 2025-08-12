program Project2;

uses
  Vcl.Forms,
  Umain in 'Umain.pas' {Form2},
  Uestudantes in 'Uestudantes.pas',
  UProfessores in 'UProfessores.pas',
  Udisciplinas in 'Udisciplinas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
