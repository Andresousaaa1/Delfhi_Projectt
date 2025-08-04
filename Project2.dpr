program Project2;

uses
  Vcl.Forms,
  Umain in 'Delfhi_Projectt\Umain.pas' {Form2},
  Uestudantes in 'Delfhi_Projectt\Uestudantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
