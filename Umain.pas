unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Grids, System.Generics.Collections, System.JSON,
  Uestudantes, UProfessores,
  Udisciplinas, UTurmas;

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
    BtnIncluirProf: TButton;
    Titulo2: TLabel;
    Cpf: TEdit;
    BtnListarProf: TButton;
    BtnExcluirProf: TButton;
    BtnAtualizarProf: TButton;
    Titulo3: TLabel;
    NomeDisciplina: TEdit;
    CodDisciplinas: TEdit;
    BtnIncluirDis: TButton;
    BtnAtualizarDis: TButton;
    BtnListarDisc: TButton;
    BtnExcluirDis: TButton;
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
    BtnAtualizarTurm: TButton;
    BtnListarTurm: TButton;
    BtnIncluirTurm: TButton;
    BtnExcluirTurm: TButton;
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

    procedure BtnIncluirProfClick(Sender: TObject);
    procedure BtnListarProfClick(Sender: TObject);
    procedure BtnAtualizarProfClick(Sender: TObject);
    procedure BtnExcluirProfClick(Sender: TObject);

    procedure BtnIncluirDisClick(Sender: TObject);
    procedure BtnListarDiscClick(Sender: TObject);
    procedure BtnAtualizarDisClick(Sender: TObject);
    procedure BtnExcluirDisClick(Sender: TObject);

    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure BtnIncluirTurmClick(Sender: TObject);
    procedure BtnListarTurmClick(Sender: TObject);
    procedure BtnExcluirTurmClick(Sender: TObject);

  private
    { Private declarations }
    ListaEstudantes: TObjectList<TEstudante>;
    ListaProfessores: TObjectList<TProfessores>;
    ListaDisciplinas: TObjectList<TDisciplinas>;
    ListaTurmas: TObjectList<TTurmas>;
    procedure SalvarEstudantes;
    procedure CarregarEstudantes;
    procedure SalvarProfessores;
    procedure CarregarProfessores;
    procedure SalvarDisciplinas;
    procedure CarregarDisciplinas;
    procedure SalvarTurmas;
    procedure CarregarTurmas;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
// Função para Verificar CPF

function SomenteNumeros(const texto: String): String;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(texto) do
    if texto[i] in ['0' .. '9'] then
      Result := Result + texto[i];
end;

// LISTAR NOS TEDITS O CONTEUDO DO COMBOBOX SEPARADO

procedure TForm2.ComboBox1Change(Sender: TObject);
var
  texto, codigoStr, nomeStr: string;
  Separador: integer;
begin
  texto := ComboBox1.Text;
  Separador := Pos(' - ', texto);

  if Separador > 0 then
  begin
    codigoStr := Copy(texto, 1, Separador - 1);
    nomeStr := Copy(texto, Separador + 3, Length(texto));

    CodEstudantes.Text := codigoStr;
    Nome.Text := nomeStr;
  end;
end;

// LISTAR NOS TEDITS O CONTEUDO DO COMBOBOX SEPARADO

procedure TForm2.ComboBox2Change(Sender: TObject);
var
  texto, codigoStr, nomeStr, cpfStr: string;
  separador1, separador2: integer;
begin
  texto := ComboBox2.Text;

  separador1 := Pos('; ', texto);
  if separador1 = 0 then
    Exit;

  separador2 := Pos('; ', texto, separador1 + 2);
  if separador2 = 0 then
    Exit;

  codigoStr := Trim(Copy(texto, 1, separador1 - 1));
  nomeStr := Trim(Copy(texto, separador1 + 2, separador2 - separador1 - 2));
  cpfStr := Trim(Copy(texto, separador2 + 2, Length(texto)));

  CodProfessor.Text := codigoStr;
  NomeProfessor.Text := nomeStr;
  Cpf.Text := cpfStr;
end;

// LISTAR NOS TEDITS O CONTEUDO DO LISTBOX SEPARADO

procedure TForm2.ListBox3Click(Sender: TObject);
var
  texto, codigoStr, nomeStr: string;
  Separador: integer;
begin
  if ListBox3.ItemIndex < 0 then
    Exit;
  texto := ListBox3.Items[ListBox3.ItemIndex];
  Separador := Pos(' - ', texto);

  if Separador > 0 then
  begin
    codigoStr := Copy(texto, 1, Separador - 1);
    nomeStr := Copy(texto, Separador + 3, Length(texto));

    CodDisciplinas.Text := codigoStr;
    NomeDisciplina.Text := nomeStr;
  end;
end;

// FORM CREATE

procedure TForm2.FormCreate(Sender: TObject);
begin
  abas.TabHeight := 1;
  abas.TabWidth := 1;

  ListaEstudantes := TObjectList<TEstudante>.Create(True);
  ListaProfessores := TObjectList<TProfessores>.Create(True);
  ListaDisciplinas := TObjectList<TDisciplinas>.Create(True);
  ListaTurmas := TObjectList<TTurmas>.Create(True);
  CarregarEstudantes;
  CarregarProfessores;
  CarregarDisciplinas;
  BtnListarClick(nil);
  BtnListarProfClick(nil);
  BtnListarDiscClick(nil);
end;

// FORM DESTROY

procedure TForm2.FormDestroy(Sender: TObject);
begin
  ListaEstudantes.Free;
  ListaProfessores.Free;
  ListaDisciplinas.Free;
end;

// SALVAR ESTUDANTES

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

// SALVAR PROFESSORES

procedure TForm2.SalvarProfessores;
var
  JsonArray: TJSONArray;
  Prof: TProfessores;
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

// SALVAR DISCIPLINAS

procedure TForm2.SalvarDisciplinas;
var
  JsonArray: TJSONArray;
  Disciplinas: TDisciplinas;
  JsonStr: TStringList;
begin
  JsonArray := TJSONArray.Create;
  try
    for Disciplinas in ListaDisciplinas do
      JsonArray.AddElement(Disciplinas.ToJSON);

    JsonStr := TStringList.Create;
    try
      JsonStr.Text := JsonArray.ToString;
      JsonStr.SaveToFile('disciplinas.json');
    finally
      JsonStr.Free;
    end;
  finally
    JsonArray.Free;
  end;
end;

procedure TForm2.SalvarTurmas;
var
  JsonArray: TJSONArray;
  Turmas: TTurmas;
  JsonStr: TStringList;
begin
  JsonArray := TJSONArray.Create;
  try
    for Turmas in ListaTurmas do
      JsonArray.AddElement(Turmas.ToJSON);

    JsonStr := TStringList.Create;
    try
      JsonStr.Text := JsonArray.ToString;
      JsonStr.SaveToFile('turmas.json');
    finally
      JsonStr.Free;
    end;
  finally
    JsonArray.Free;
  end;
end;

// CARREGAR ESTUDANTES

procedure TForm2.CarregarEstudantes;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Est: TEstudante;
  i: integer;
begin
  if not FileExists('estudantes.json') then
    Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('estudantes.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      ListaEstudantes.Clear;
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

// CARREGAR PROFESSORES

procedure TForm2.CarregarProfessores;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Prof: TProfessores;
  i: integer;
begin
  if not FileExists('professores.json') then
    Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('professores.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      ListaProfessores.Clear;
      for i := 0 to JsonArray.Count - 1 do
      begin
        Prof := TProfessores.Create;
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

// CARREGAR DISCIPLINAS

procedure TForm2.CarregarDisciplinas;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Disciplinas: TDisciplinas;
  i: integer;
begin
  if not FileExists('disciplinas.json') then
    Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('disciplinas.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      ListaDisciplinas.Clear;
      for i := 0 to JsonArray.Count - 1 do
      begin
        Disciplinas := TDisciplinas.Create;
        Disciplinas.FromJSON(JsonArray.Items[i] as TJSONObject);
        ListaDisciplinas.Add(Disciplinas);
      end;
    finally
      JsonArray.Free;
    end;
  finally
    JsonStr.Free;
  end;
end;

// CARREGAR TURMAS
procedure TForm2.CarregarTurmas;
var
  JsonStr: TStringList;
  JsonArray: TJSONArray;
  Turmas: TTurmas;
  i: integer;
begin
  if not FileExists('turmas.json') then
    Exit;

  JsonStr := TStringList.Create;
  try
    JsonStr.LoadFromFile('turmas.json');
    JsonArray := TJSONObject.ParseJSONValue(JsonStr.Text) as TJSONArray;
    try
      ListaTurmas.Clear;
      for i := 0 to JsonArray.Count - 1 do
      begin
        Turmas := TTurmas.Create;
        Turmas.FromJSON(JsonArray.Items[i] as TJSONObject);
        ListaTurmas.Add(Turmas);
      end;
    finally
      JsonArray.Free;
    end;
  finally
    JsonStr.Free;
  end;
end;

// BOTÃO EXCLUIR estudantes
procedure TForm2.BtnExcluirClick(Sender: TObject);
var
  i: integer;
  cod: integer;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if cod < 0 then
  begin
    ShowMessage('Codigo invalido');
    Exit;
  end;

  for i := ListaEstudantes.Count - 1 downto 0 do
    if ListaEstudantes[i].Codigo = cod then
    begin
      ListaEstudantes.Delete(i);
      SalvarEstudantes;
      BtnListarClick(nil);
      ShowMessage('Estudante excluido.');
      Exit;
    end;

  ShowMessage('Estudante não encontrado.');
end;

// BOTÃO EXCLUIR professores
procedure TForm2.BtnExcluirProfClick(Sender: TObject);
var
  i: integer;
  cod: integer;
  Cpf: String;
begin
  cod := StrToIntDef(CodProfessor.Text, -1);
  if cod < 0 then
  begin
    ShowMessage('Codigo invalido');
    Exit;
  end;

  for i := ListaProfessores.Count - 1 downto 0 do
    if ListaProfessores[i].Codigo = cod then
    begin
      ListaProfessores.Delete(i);
      SalvarProfessores;
      BtnListarProfClick(nil);
      ShowMessage('Professor excluido.');
      Exit;
    end;

  ShowMessage('Professor não encontrado.');
end;

//BOTÃO EXCLUIR turmas
procedure TForm2.BtnExcluirTurmClick(Sender: TObject);
var
  i: integer;
  cod: integer;
  CodTurmProf: String;
  CodTurmDisc: String;
begin
  cod := StrToIntDef(CodTurmas.Text, -1);
  if cod < 0 then
  begin
    ShowMessage('Codigo invalido');
    Exit;
  end;

  for i := ListaTurmas.Count - 1 downto 0 do
    if ListaTurmas[i].Codigo = cod then
    begin
      ListaTurmas.Delete(i);
      SalvarTurmas;
      BtnListarTurmClick(nil);
      ShowMessage('Turma excluida.');
      Exit;
    end;

  ShowMessage('Turma não encontrada.');
end;

// BOTÃO EXCLUIR disciplinas
procedure TForm2.BtnExcluirDisClick(Sender: TObject);
var
  i: integer;
  cod: integer;
begin
  cod := StrToIntDef(CodDisciplinas.Text, -1);
  if cod < 0 then
  begin
    ShowMessage('Codigo invalido');
    Exit;
  end;

  for i := ListaDisciplinas.Count - 1 downto 0 do
    if ListaDisciplinas[i].Codigo = cod then
    begin
      ListaDisciplinas.Delete(i);
      SalvarDisciplinas;
      BtnListarDiscClick(nil);
      ShowMessage('Disciplina excluida.');
      Exit;
    end;

  ShowMessage('Disciplina não encontrada.');
end;

// BOTÃO INCLUIR estudantes

procedure TForm2.BtnIncluirClick(Sender: TObject);
var
  Est: TEstudante;
  cod: integer;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if (cod < 0) or (Nome.Text = '') then
    Exit;

  for Est in ListaEstudantes do
    if Est.Codigo = cod then
    begin
      ShowMessage('Codigo ja existe!');
      Exit;
    end;

  Est := TEstudante.Create;
  Est.Codigo := cod;
  Est.Nome := Nome.Text;
  ListaEstudantes.Add(Est);
  SalvarEstudantes;

  ComboBox1.Items.Add(Format('%d - %s', [Est.Codigo, Est.Nome]));
  ShowMessage('Estudante incluido com sucesso.');

end;

// BOTÃO INCLUIR Professores

procedure TForm2.BtnIncluirProfClick(Sender: TObject);
var
  Prof: TProfessores;
  cod: integer;
  CpfProf: String;
begin
  cod := StrToIntDef(CodProfessor.Text, -1);
  if (cod < 0) or (NomeProfessor.Text = '') or (Cpf.Text = '') then
    Exit;

  CpfProf := SomenteNumeros(Cpf.Text);

  if (Length(CpfProf) <> 11) then
  begin
    ShowMessage('O Cpf precisa ter 11 Digitos');
    Exit;
  end;

  for Prof in ListaProfessores do
    if Prof.Codigo = cod then
    begin
      ShowMessage('Codigo ja existe!');
      Exit;
    end;

  Prof := TProfessores.Create;
  Prof.Codigo := cod;
  Prof.Nome := NomeProfessor.Text;
  Prof.Cpf := Cpf.Text;
  ListaProfessores.Add(Prof);
  SalvarProfessores;

  ComboBox2.Items.Add(Format('%d;%s;%s', [Prof.Codigo, Prof.Nome, Prof.Cpf]));
  ShowMessage('Professor incluido com sucesso.');
end;

// BOTÃO INCLUIR disciplinas

procedure TForm2.BtnIncluirDisClick(Sender: TObject);
var
  Disciplinas: TDisciplinas;
  cod: integer;
begin
  cod := StrToIntDef(CodDisciplinas.Text, -1);
  if (cod < 0) or (NomeDisciplina.Text = '') then
    Exit;

  for Disciplinas in ListaDisciplinas do
    if Disciplinas.Codigo = cod then
    begin
      ShowMessage('Codigo ja existe!');
      Exit;
    end;

  Disciplinas := TDisciplinas.Create;
  Disciplinas.Codigo := cod;
  Disciplinas.Nome := NomeDisciplina.Text;
  ListaDisciplinas.Add(Disciplinas);
  SalvarDisciplinas;

  ListBox3.Items.Add(Format('%d - %s', [Disciplinas.Codigo, Disciplinas.Nome]));
  ShowMessage('Disciplina incluida com sucesso.');
end;

// BOTÃO INCLUIR turmas
procedure TForm2.BtnIncluirTurmClick(Sender: TObject);
var
  Turmas: TTurmas;
  cod: integer;
begin
  cod := StrToIntDef(CodTurmas.Text, -1);
  if (cod < 0) or (CodTurmasProfessor.Text = '') or (CodTurmasDisciplinas.Text = '') then
    Exit;

  for Turmas in ListaTurmas do
    if Turmas.Codigo = cod then
    begin
      ShowMessage('Codigo ja existe!');
      Exit;
    end;

  Turmas := TTurmas.Create;
  Turmas.Codigo := cod;
  Turmas.CodProf := StrToIntDef(CodTurmasProfessor.Text, -1);
  Turmas.CodDis := StrToIntDef(CodDisciplinas.Text, -1);
  ListaTurmas.Add(Turmas);
  SalvarTurmas;

  ListBox2.Items.Add(Format('%d - %d - %d', [Turmas.Codigo, Turmas.CodProf, Turmas.CodDis]));
  ShowMessage('Disciplina incluida com sucesso.');
end;


// BOTÃO LISTAR estudantes

procedure TForm2.BtnListarClick(Sender: TObject);
var
  Est: TEstudante;
begin
  CarregarEstudantes;
  ComboBox1.Clear;
  for Est in ListaEstudantes do
    ComboBox1.Items.Add(Format('%d - %s', [Est.Codigo, Est.Nome]));
end;

// BOTÃO LISTAR professores
procedure TForm2.BtnListarProfClick(Sender: TObject);
var
  Prof: TProfessores;
begin
  CarregarProfessores;
  ComboBox2.Clear;
  for Prof in ListaProfessores do
    ComboBox2.Items.Add(Format('%d; %s; %s', [Prof.Codigo, Prof.Nome,
      Prof.Cpf]));
end;

// BOTÃO LISTAR disciplinas

procedure TForm2.BtnListarDiscClick(Sender: TObject);
var
  Disciplinas: TDisciplinas;
begin
  CarregarDisciplinas;
  ListBox3.Clear;
  for Disciplinas in ListaDisciplinas do
    ListBox3.Items.Add(Format('%d - %s', [Disciplinas.Codigo,
      Disciplinas.Nome]));
end;

// BOTÃO LISTAR turmas
procedure TForm2.BtnListarTurmClick(Sender: TObject);
var
  Turmas: TTurmas;
begin
  CarregarTurmas;
  ListBox2.Clear;
  for Turmas in ListaTurmas do
    ListBox2.Items.Add(Format('%d - %s - %s', [Turmas.Codigo, Turmas.CodProf, Turmas.CodDis]));
end;

// BOTÃO ATUALIZAR estudantes

procedure TForm2.BtnAtualizarClick(Sender: TObject);
var
  cod: integer;
  Est: TEstudante;
  encontrado: Boolean;
begin
  cod := StrToIntDef(CodEstudantes.Text, -1);
  if (cod < 0) or (Nome.Text = '') then
  begin
    ShowMessage('Preencha o codigo e o nome corretamente.');
    Exit;
  end;

  encontrado := False;
  for Est in ListaEstudantes do
  begin
    if Est.Codigo = cod then
    begin
      Est.Nome := Nome.Text;
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
    ShowMessage('Estudante com este codigo não foi encontrado.');
end;

// BOTÃO ATUALIZAR Professores

procedure TForm2.BtnAtualizarProfClick(Sender: TObject);
var
  cod: integer;
  Prof: TProfessores;
  CpfProf: String;
  encontrado: Boolean;
begin
  cod := StrToIntDef(CodProfessor.Text, -1);
  if (cod < 0) or (NomeProfessor.Text = '') or (Cpf.Text = '') then
  begin
    ShowMessage('Preencha o codigo o nome e o Cpf corretamente.');
    Exit;
  end;

  encontrado := False;
  for Prof in ListaProfessores do
  begin
    if Prof.Codigo = cod then
    begin
      Prof.Nome := NomeProfessor.Text;
      Prof.Cpf := Cpf.Text;
      encontrado := True;
      Break;
    end;
  end;

  if encontrado then
  begin
    SalvarProfessores;
    BtnListarProfClick(nil);
    ShowMessage('Professor atualizado com sucesso.');
  end
  else
    ShowMessage('Professor com este codigo não foi encontrado.');
end;

// BOTÃO ATUALIZAR disciplinas

procedure TForm2.BtnAtualizarDisClick(Sender: TObject);
var
  cod: integer;
  Disciplinas: TDisciplinas;
  encontrado: Boolean;
begin
  cod := StrToIntDef(CodDisciplinas.Text, -1);
  if (cod < 0) or (NomeDisciplina.Text = '') then
  begin
    ShowMessage('Preencha o codigo e o nome corretamente.');
    Exit;
  end;

  encontrado := False;
  for Disciplinas in ListaDisciplinas do
  begin
    if Disciplinas.Codigo = cod then
    begin
      Disciplinas.Nome := NomeDisciplina.Text;
      encontrado := True;
      Break;
    end;
  end;

  if encontrado then
  begin
    SalvarDisciplinas;
    BtnListarDiscClick(nil);
    ShowMessage('Disciplina atualiza com sucesso.');
  end
  else
    ShowMessage('Disciplina com este codigo não foi encontrado.');
end;

// BOTÕES DE DIRECIONAMENTO

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

// BOTÃO VOLTAR

procedure TForm2.VoltarClick(Sender: TObject);
begin
  VoltarParaMenu;
end;

procedure TForm2.VoltarParaMenu;
begin
  abas.ActivePage := Menu;
end;

end.
