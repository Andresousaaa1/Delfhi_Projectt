unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Grids, System.Generics.Collections, System.JSON, Uestudantes, Uprofessores;

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
    procedure VoltarParaMenu;

    procedure FormDestroy(Sender: TObject);

    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnListarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);

  private
    { Private declarations }
  ListaEstudantes: TObjectList<TEstudante>;
  ListaProfessores: TObjectList<TProfessor>;
  procedure SalvarEstudantes;
  procedure CarregarEstudantes;
  procedure SalvarProfessores;
  procedure CarregarProfessores;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


{$R *.dfm}


//FORM CREATE

  procedure TForm2.FormCreate(Sender: TObject);
begin
  abas.TabHeight := 1;
  abas.TabWidth := 1;

  ListaEstudantes := TObjectList<TEstudante>.Create(True);
  ListaProfessores := TObjectList<TProfessor>.Create(True);
  CarregarEstudantes;
  CarregarProfessores;
  BtnListarClick(nil);
end;

//FORM DESTROY

procedure TForm2.FormDestroy(Sender: TObject);
begin
   ListaEstudantes.Free;
   ListaProfessores.Free;
end;

// SALVAR ESTUDANTES e PROFESSORES

  procedure TForm2.SalvarEstudantes;
var
  JsonArray: TJSONArray;
  Est: TEstudante;
  JsonStr: TStringList;
begin
  JsonArray := TJSONArray.Create;
  try
    for Est in ListaEstudantes do
      JsonArray.AddElement(Est.ToJSON);

    JsonStr := TStringList.Create;
    try
      JsonStr.Text := JsonArray.ToString;
      JsonStr.SaveToFile('estudantes.json');
    finally
      JsonStr.Free;
    end;
  finally
    JsonArray.Free;
  end;
end;

  procedure TForm2.SalvarProfessores;
var
  JsonArray: TJSONArray;
  Prof: TProfessor;
  JsonStr: TStringList;
begin
  JsonArray := TJSONArray.Create;
  try
    for Prof in ListaProfessores do
      JsonArray.AddElement(Prof.ToJSON);

    JsonStr := TStringList.Create;
    try
      JsonStr.Text := JsonArray.ToString;
      JsonStr.SaveToFile('professores.json');
    finally
      JsonStr.Free;
    end;
  finally
    JsonArray.Free;
  end;
end;

//CARREGAR ESTUDANTES e PROFESSORES

procedure TForm2.CarregarEstudantes;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Est: TEstudante;
  i: Integer;
begin
  if not FileExists('estudantes.json') then Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('estudantes.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      for i := 0 to JsonArray.Count - 1 do
      begin
        Est := TEstudante.Create;
        Est.FromJSON(JsonArray.Items[i] as TJSONObject);
        ListaEstudantes.Add(Est);
      end;
    finally
      JsonArray.Free;
    end;
  finally
    JsonStr.Free;
  end;
end;

procedure TForm2.CarregarProfessores;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Prof: TProfessor;
  i: Integer;
begin
  if not FileExists('professores.json') then Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('professores.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      for i := 0 to JsonArray.Count - 1 do
      begin
        Prof := TProfessor.Create;
        Prof.FromJSON(JsonArray.Items[i] as TJSONObject);
        ListaProfessores.Add(Prof);
      end;
    finally
      JsonArray.Free;
    end;
  finally
    JsonStr.Free;
  end;
end;

//BOT�O EXCLUIR

procedure TForm2.BtnExcluirClick(Sender: TObject);
var
  i: Integer;
  cod: Integer;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if cod < 0 then
  begin
    ShowMessage('C�digo inv�lido');
    Exit;
  end;

  for i := ListaEstudantes.Count - 1 downto 0 do
    if ListaEstudantes[i].Codigo = cod then
    begin
      ListaEstudantes.Delete(i);
      SalvarEstudantes;
      BtnListarClick(nil);
      ShowMessage('Estudante exclu�do.');
      Exit;
    end;

  ShowMessage('Estudante n�o encontrado.');
end;

//BOT�O INCLUIR

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
      ShowMessage('C�digo j� existe!');
      Exit;
    end;

  est := TEstudante.Create;
  est.Codigo := cod;
  est.Nome := Nome.Text;
  ListaEstudantes.Add(est);
  SalvarEstudantes;

  ComboBox1.Items.Add(Format('%d - %s', [est.Codigo, est.Nome]));
  ShowMessage('Estudante inclu�do com sucesso.');

end;

//BOT�O LISTAR

procedure TForm2.BtnListarClick(Sender: TObject);
var est: TEstudante;
begin
  ComboBox1.Clear;
  for est in ListaEstudantes do
  ComboBox1.Items.Add(Format('%d - %s', [est.Codigo, est.Nome]));
end;

//BOT�O ATUALIZAR

procedure TForm2.BtnAtualizarClick(Sender: TObject);
var
  cod: Integer;
  est: TEstudante;
  encontrado: Boolean;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if (cod < 0) or (Nome.Text = '') then
  begin
    ShowMessage('Preencha o c�digo e o nome corretamente.');
    Exit;
  end;

  encontrado := False;
  for est in ListaEstudantes do
  begin
    if est.Codigo = cod then
    begin
      est.Nome := Nome.Text;
      encontrado := True;
      Break;
    end;
  end;

  if encontrado then
  begin
    SalvarEstudantes;
    BtnListarClick(nil);
    ShowMessage('Estudante atualizado com sucesso.');
  end
  else
    ShowMessage('Estudante com este c�digo n�o foi encontrado.');
end;

//BOT�ES DE DIRECIONAMENTO

procedure TForm2.BtnDisciplinasClick(Sender: TObject);
begin
  abas.ActivePage := Disciplinas;
end;

procedure TForm2.BtnEstudantesClick(Sender: TObject);
begin
  abas.ActivePage := Estudantes;
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

//BOT�O VOLTAR

procedure TForm2.VoltarClick(Sender: TObject);
begin
  VoltarParaMenu;
end;

procedure TForm2.VoltarParaMenu;
begin
  abas.ActivePage := Menu;
end;

end.
