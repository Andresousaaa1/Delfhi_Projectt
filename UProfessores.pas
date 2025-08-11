unit UProfessores;

interface

  uses System.Classes, System.SysUtils, System.JSON;

  type TProfessores = class (Tobject)

  Private
  FCodigo: integer;
  FNome: String;
  FCpf: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Cpf: string read FCpf write FCpf;

    function ToLine: string;
    procedure FromLine(ALine: string);

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);
  end;

implementation

{ TProfessores }

procedure TProfessores.FromJSON(AJson: TJSONObject);
var
  CodigoVal: TJSONValue;
  NomeVal: TJSONValue;
  CpfVal: TJSONValue;
begin
  CodigoVal := AJson.GetValue('codigo');
  NomeVal := AJson.GetValue('nome');
  CpfVal := AJson.GetValue('cpf');

  if (not Assigned(CodigoVal)) or (not Assigned (CpfVal)) or (not Assigned(NomeVal)) then
    raise Exception.Create('JSON invalido: campos ausentes.');

  try
    Codigo := StrToInt(CodigoVal.Value);
    Nome := NomeVal.Value;
    Cpf := CpfVal.Value;

  except
    raise Exception.Create('Erro ao converter dados do JSON.');
  end;

end;

procedure TProfessores.FromLine(ALine: string);
var
  Campos: TArray<string>;
begin
  Campos := ALine.Split([';']);
  if Length(Campos) <> 3 then
  raise Exception.Create('Linha invalida');
  Codigo := StrToInt(Campos[0]);
  Nome := Campos[1];
  Cpf := Campos[2];
end;

function TProfessores.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('codigo', TJSONNumber.Create(Codigo));
  Result.AddPair('nome', Nome);
  Result.AddPair('cpf', Cpf);
end;

function TProfessores.ToLine: string;
begin
  Result := Format('%d;%s;%s', [Codigo, Nome, Cpf]);
end;

end.
