unit TsmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TsmTypes, TsmSim;

type
  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  public
    Simulation: TSimulation;

    _Cities: Word;                     // # cities to visit
    _PopSize: Word;                    // Population size
    _Parents: Word;                    // # parents in population
    _Generations: Word;                // # generations before auto-halt
    _MutationRate: Word;               // % Prob. of mut. at cross-over
    RandomizeInitPop: Boolean;         // Randomize initial population?
    RandomizeCities: Boolean;          // Randomize city positions?
  private
    FExecuting: Boolean;
    procedure SetExecuting(Exec: Boolean);
    procedure ThreadDone(Sender: TObject);
  protected
    property Executing: Boolean read FExecuting write SetExecuting;
  end;

var
  MainForm: TMainForm;

implementation

uses
  TsmAbout, IniFiles;

const
  IniFileName: String = 'Salesman.ini';

{$R *.DFM}

{--------------------- TMainForm ----------------------}

procedure TMainForm.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
begin
  RandomizeInitPop := True;
  RandomizeCities := True;

  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
  begin
    // Get parameters for simulation
    _Cities  := ReadInteger('Parameters', 'Cities', 40);
    _PopSize   := ReadInteger('Parameters', 'Population', 150);
    _Parents := ReadInteger('Parameters', 'Parents', 40);
    _MutationRate := ReadInteger('Parameters', 'Mutation', 5);
    _Generations := ReadInteger('Parameters', 'Generations', 30);
  end;
  IniFile.Free;

  Edit1.Text := IntToStr(_Cities);
  Edit2.Text := IntToStr(_PopSize);
  Edit3.Text := IntToStr(_Parents);
  Edit4.Text := IntToStr(_MutationRate);
  Edit5.Text := IntToStr(_Generations);

{  Executing := False; }
end;


procedure TMainForm.FormDestroy(Sender: TObject);
var
  IniFile: TIniFile;
begin
  // Destroy the simulation
  if Assigned(Simulation) then
  begin
    Simulation.Suspend;
    Simulation.Free;
  end;

  IniFile := TIniFile.Create(IniFileName);
  with IniFile do
  begin
    // Write simulation parameters
    WriteInteger('Parameters', 'Cities', _Cities);
    WriteInteger('Parameters', 'Population', _PopSize);
    WriteInteger('Parameters', 'Parents', _Parents);
    WriteInteger('Parameters', 'Mutation', _MutationRate);
    WriteInteger('Parameters', 'Generations', _Generations);
  end;
  IniFile.Free;
end;


procedure TMainForm.Button1Click(Sender: TObject);
begin
  if not Executing then
  begin
    Simulation := TSimulation.Create;
    Simulation.OnTerminate := ThreadDone;
  end
  else
    // Suspend but don't destroy simulation. We need it to display graphs etc.
    Simulation.Suspend;
  Executing := not Executing;
end;


procedure TMainForm.Button2Click(Sender: TObject);
begin
  with Simulation do
  begin
    if Suspended then
      Button2.Caption := '&Pause'
    else
      Button2.Caption := 'Un&pause';
    Suspended := not Suspended;
  end;
end;


procedure TMainForm.Button3Click(Sender: TObject);
begin
  Close;
end;


procedure TMainForm.SetExecuting(Exec: Boolean);
begin
  FExecuting := Exec;
  if FExecuting then
  begin
    Button1.Caption := '&Stop';
    Button2.Caption := '&Pause';
    Button2.Enabled := True;
    GroupBox1.Enabled := False;
  end
  else
  begin
    Button1.Caption := '&Start';
    Button2.Enabled := False;
    GroupBox1.Enabled := True;
  end;
end;


procedure TMainForm.ThreadDone(Sender: TObject);
begin
  Executing := False;
  Button1.Caption := '&Start';
end;


procedure TMainForm.EditExit(Sender: TObject);
begin
  // Assign parameters
  _Cities       := StrToInt(Edit1.Text);
  _PopSize      := StrToInt(Edit2.Text);
  _Parents      := StrToInt(Edit3.Text);
  _MutationRate := StrToInt(Edit4.Text);
  _Generations  := StrToInt(Edit5.Text);
  // Check parameters
  if _Parents >= _PopSize then
    MessageDlg('Number of parents must be smaller than the population size.',
               mtWarning, [mbOk], 0);
end;


procedure TMainForm.Button4Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;


procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['A'..'z', '-']) then
    Key := #0;           // Don't accept letters
end;

end.

