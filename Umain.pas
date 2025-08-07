unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Grids, System.Generics.Collections, Uestudantes;

type
  TForm2 = class(TForm)
    BtnDisciplinas: TButton;
    Image1: TImage;
    abas: TPageControl;
    Menu: TTabSheet;
    Estudantes: TTabSheet;
    Professores: TTabSheet;
    Disciplinas: TTabSheet;
    Titulo: TLabel;
    Titulo1: TLabel;
    BtnAtualizar: TButton;
    BtnEstudantes: TButton;
    BtnProfessores: TButton;
    BtnTurmas: TButton;
    BtnMatriculas: TButton;
    CodEstudantes: TEdit;
    Nome: TEdit;
    BtnIncluir: TButton;
    BtnListar: TButton;
    BtnExcluir: TButton;
    CodProfessor: TEdit;
    NomeProfessor: TEdit;
    BtnIncluir1: TButton;
    Titulo2: TLabel;
    Cpf: TEdit;
    BtnListar1: TButton;
    BtnExcluir1: TButton;
    BtnAtualizar1: TButton;
    Titulo3: TLabel;
    NomeDisciplina: TEdit;
    CodDisciplinas: TEdit;
    BtnIncluir2: TButton;
    BtnAtualizar2: TButton;
    BtnListar2: TButton;
    BtnExcluir2: TButton;
    ListBox3: TListBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Turmas: TTabSheet;
    Titulo4: TLabel;
    CodTurmas: TEdit;
    CodTurmasDisciplinas: TEdit;
    CodTurmasProfessor: TEdit;
    Matriculas: TTabSheet;
    Titulo5: TLabel;
    CodMatriculas: TEdit;
    CodTurmaMatriculas: TEdit;
    CodEstudanteMatriculas: TEdit;
    BtnAtualizar3: TButton;
    BtnListar3: TButton;
    BtnIncluir3: TButton;
    BtnExcluir3: TButton;
    BtnListar4: TButton;
    BtnIncluir4: TButton;
    BtnAtualizar4: TButton;
    BtnExcluir4: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Voltar: TButton;
    Voltar1: TButton;
    Voltar4: TButton;
    Voltar2: TButton;
    Voltar3: TButton;
    procedure BtnEstudantesClick(Sender: TObject);
    procedure BtnProfessoresClick(Sender: TObject);
    procedure BtnDisciplinasClick(Sender: TObject);
    procedure BtnTurmasClick(Sender: TObject);
    procedure BtnMatriculasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VoltarClick(Sender: TObject);
    procedure Voltar1Click(Sender: TObject);
    procedure Voltar2Click(Sender: TObject);
    procedure Voltar3Click(Sender: TObject);
    procedure Voltar4Click(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnListarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);


  private
    { Private declarations }
  ListaEstudantes: TObjectList<TEstudante>;
  procedure AdicionarEstudanteNaLista;
  procedure AdicionarEstudanteNaTela(aEstudantes:TEstudante);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


{$R *.dfm}


procedure TForm2.AdicionarEstudanteNaLista;
begin

end;


procedure TForm2.AdicionarEstudanteNaTela(aEstudantes: TEstudante);
begin

end;

//BOTÕES DE DIRECIONAMENTO

procedure TForm2.BtnDisciplinasClick(Sender: TObject);
begin
  abas.ActivePage := Disciplinas;
end;

procedure TForm2.BtnEstudantesClick(Sender: TObject);
begin
  abas.ActivePage := Estudantes;
end;
  //Botão excluir
procedure TForm2.BtnExcluirClick(Sender: TObject);
var
  i: Integer;
  cod: Integer;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  for i := ListaEstudantes.Count - 1 downto 0 do
    if ListaEstudantes[i].Codigo = cod then
    begin
      ListaEstudantes.Delete(i);
      ShowMessage('Excluído.');
      Exit;
    end;
  ShowMessage('Não encontrado.');
end;

  //Botão incluir
procedure TForm2.BtnIncluirClick(Sender: TObject);
  var
  est: TEstudante;
  cod: Integer;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if (cod < 0) or (Nome.Text = '') then
    Exit;

  for est in ListaEstudantes do
    if est.Codigo = cod then
    begin
      ShowMessage('Código já existe!');
      Exit;
    end;

  est := TEstudante.Create;
  est.Codigo := cod;
  est.Nome := Nome.Text;
  ListaEstudantes.Add(est);

end;
  //Botão Listar
procedure TForm2.BtnListarClick(Sender: TObject);
var est: TEstudante;
begin
  ComboBox1.Clear;
  for est in ListaEstudantes do
  ComboBox1.Items.Add(Format('%d - %s', [est.Codigo, est.Nome]));
end;

procedure TForm2.BtnMatriculasClick(Sender: TObject);
begin
    abas.ActivePage := Matriculas;
end;

procedure TForm2.BtnProfessoresClick(Sender: TObject);
begin
  abas.ActivePage := Professores;
end;

procedure TForm2.BtnTurmasClick(Sender: TObject);
begin
    abas.ActivePage := Turmas;
end;

  //form Create
procedure TForm2.FormCreate(Sender: TObject);
begin

  abas.TabHeight := 1;
  abas.TabWidth := 1;

  ListaEstudantes := TObjectList<TEstudante>.Create(True);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
   ListaEstudantes.Free;
end;


//BOTÕES VOLTAR
procedure TForm2.Voltar1Click(Sender: TObject);
begin
  abas.ActivePage := Menu;
end;

procedure TForm2.Voltar2Click(Sender: TObject);
begin
  abas.ActivePage := Menu;
end;

procedure TForm2.Voltar3Click(Sender: TObject);
begin
  abas.ActivePage := Menu;
end;

procedure TForm2.Voltar4Click(Sender: TObject);
begin
  abas.ActivePage := Menu;
end;

procedure TForm2.VoltarClick(Sender: TObject);
begin
  abas.ActivePage := Menu;
end;

end.
