//  TRAVELING SALESMAN PROJECT
//  GrMikeD - GrMikeD@usa.net

// Unit of the Main Form
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Series, TeEngine, TeeProcs, Chart, Grids, ComCtrls, jpeg, ExtCtrls,
  StdCtrls, Spin, Buttons, shellapi, timecount;

Const MaxV= 200;  //the MAX number of cities (nodes of the graph)

type
  TTSPSolverForm = class(TForm)
    Label1: TLabel;
    LimitLabel: TLabel;
    AlgoGroup: TRadioGroup;
    NumberSpinEdit: TSpinEdit;
    StatusBar: TStatusBar;
    ResultBox: TGroupBox;
    AlgoLabel: TLabel;
    DiscLabel: TLabel;
    Bevel: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    FlopEdit: TEdit;
    TimeEdit: TEdit;
    SameGraphCheckBox: TCheckBox;
    Panel: TPanel;
    Image: TImage;
    Label5: TLabel;
    Label4: TLabel;
    EmailLabel: TLabel;
    WebSiteLabel: TLabel;
    PageControl: TPageControl;
    GraphSheet: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    CostEdit: TEdit;
    TourEdit: TEdit;
    GraphGrid: TStringGrid;
    ResultsSheet: TTabSheet;
    FlopSheet: TTabSheet;
    FlopChart: TChart;
    Log1CheckBox: TCheckBox;
    TimeSheet: TTabSheet;
    TimeChart: TChart;
    ExhaustiveFlopPoint: TPointSeries;
    HeuristicFlopPoint: TPointSeries;
    ExhaustiveTimePoint: TPointSeries;
    HeuristicTimePoint: TPointSeries;
    ExhaustiveTimeLine: TLineSeries;
    HeuristicTimeLine: TLineSeries;
    HeuristicFlopLine: TLineSeries;
    ExhaustiveFlopLine: TLineSeries;
    ExhaustiveCostBar: TBarSeries;
    HeuristicCostBar: TBarSeries;
    Log2CheckBox: TCheckBox;
    CostSheet: TTabSheet;
    CostChart: TChart;
    ViewCheckBox: TCheckBox;
    AutoCheckBox: TCheckBox;
    SaveDialog: TSaveDialog;
    TitleLabel: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ExhaustiveView: TListView;
    HeuristicView: TListView;
    AddButton: TBitBtn;
    StartButton: TBitBtn;
    ResetExhaustiveButton: TBitBtn;
    ResetHeuristicButton: TBitBtn;
    CopyButton1: TBitBtn;
    CopyButton2: TBitBtn;
    CopyButton3: TBitBtn;
    SaveButton1: TBitBtn;
    SaveButton2: TBitBtn;
    SaveButton3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CopyButton1Click(Sender: TObject);
    procedure SaveButton1Click(Sender: TObject);
    procedure ResetExhaustiveButtonClick(Sender: TObject);
    procedure EmailLabelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SameGraphCheckBoxClick(Sender: TObject);
    procedure NumberSpinEditChange(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure AutoCheckBoxClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExhaustiveViewInsert(Sender: TObject; Item: TListItem);
    procedure HeuristicViewInsert(Sender: TObject; Item: TListItem);
    procedure ViewCheckBoxClick(Sender: TObject);
    procedure Log1CheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    procedure Initiate;
    procedure CreateGraph;
    procedure SetEnv(const b: boolean);
    procedure ClearEnv;
    procedure ViewResults;
  public
    { Public declarations }
  end;

var
  TSPSolverForm: TTSPSolverForm;
  Counter: TCounter;
  V: integer;  //the selected number of nodes
  E: array[1..MaxV,1..MaxV] of integer;  //array of disctances (E[i,j]=cij)
  P: array[0..MaxV] of integer;  //array of the optimal path found each time
  PathFound: boolean;  //it is 0 when there is no path found (connectivity problem error) 
  Cost: integer;  //the cost of the minimum path found each time
  flop: integer;  //the flop consumed
  time: real;  //the time in sec consumed
  Stop: boolean;  //shows that the user wants to terminate the execution of the algorithm

implementation

{$R *.DFM}
uses exhaustive, heuristic;

var  CanSameGraph: boolean;  //shows if the algorithm can run again using the same graph

procedure TTSPSolverForm.CreateGraph;
var i,j,k: integer;

begin
  GraphGrid.ColCount:= V+1;
  GraphGrid.RowCount:= V+1;
  for i:=1 to GraphGrid.RowCount-1 do
  begin
    GraphGrid.Rows[i].Text:= 'a' + IntToStr(i);
    GraphGrid.Cols[i].Text:= GraphGrid.Rows[i].Text;
  end;
  if SameGraphCheckBox.Checked=false then
  begin
    Randomize;
    for i:=1 to V do
      for j:=1 to V do
      begin
        if j=i then
        begin
          E[i,j]:=-1;
          GraphGrid.Cells[j,i]:= '-1';
        end;
        if j>i then
        begin
          repeat
            k:= random(995);
          until k<>0;
          if (k mod 21= 0) then
            k:= -1
          else
            k:= k+5;
          E[i,j]:= k;
          E[j,i]:= k;
          GraphGrid.Cells[j,i]:= IntToStr(k);
          GraphGrid.Cells[i,j]:= IntToStr(k);
        end;
      end;
  end
  else
    for i:=1 to V do
      for j:=1 to V do
        GraphGrid.Cells[j,i]:= IntToStr(E[i,j]);
end;

procedure TTSPSolverForm.Initiate;
begin
  StatusBar.Panels[1].Text:= 'Please Wait...';
  Stop:= false;
  PathFound:= false;
  ClearEnv;
  V:= Numberspinedit.Value;
  flop:= 0;
  cost:= 0;
  time:= 0;
  Case AlgoGroup.ItemIndex of
    0:  AlgoLabel.Caption:= 'Exhaustive Algorithm';
    1:  AlgoLabel.Caption:= 'Heuristic Algorithm';
  end;
  DiscLabel.Caption:= 'for ' + IntToStr(V) + ' Nodes';
  CreateGraph;
end;

procedure TTSPSolverForm.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex:= 0;
  NumberSpinEdit.MaxLength:= MaxV;
  LimitLabel.Caption:= '(4'+'-'+IntToStr(MaxV)+')';
  CanSameGraph:= false;
  PathFound:= false;
  Counter:= TCounter.Create(Application);
end;

procedure TTSPSolverForm.CopyButton1Click(Sender: TObject);
begin
  if Sender=CopyButton1 then
    FlopChart.CopyToClipboardBitmap;
  if Sender=CopyButton2 then
    TimeChart.CopyToClipboardBitmap;
  if Sender=CopyButton3 then
    CostChart.CopyToClipboardBitmap;
end;

procedure TTSPSolverForm.SaveButton1Click(Sender: TObject);
begin
 if Sender=SaveButton1 then
   SaveDialog.FileName:= 'flopN.bmp';
 if Sender=SaveButton2 then
   SaveDialog.FileName:= 'timeN.bmp';
 if Sender=SaveButton3 then
   SaveDialog.FileName:= 'costN.bmp';
 if SaveDialog.Execute then
 begin
   if Sender=SaveButton1 then
     FlopChart.SaveToBitmapFile(SaveDialog.FileName);
   if Sender=SaveButton2 then
     TimeChart.SaveToBitmapFile(SaveDialog.FileName);
   if Sender=SaveButton3 then
     CostChart.SaveToBitmapFile(SaveDialog.FileName);
 end;
end;

procedure TTSPSolverForm.ResetExhaustiveButtonClick(Sender: TObject);
begin
  if Sender=ResetExhaustiveButton then
  begin
    ExhaustiveView.Items.Clear;
    ResetExhaustiveButton.Enabled:= false;
    ExhaustiveFlopLine.Clear;
    ExhaustiveFlopPoint.Clear;
    ExhaustiveTimeLine.Clear;
    ExhaustiveTimePoint.Clear;
    ExhaustiveCostBar.Clear;
  end;
  if Sender=ResetHeuristicButton then
  begin
    HeuristicView.Items.Clear;
    ResetHeuristicButton.Enabled:= false;
    HeuristicFlopLine.Clear;
    HeuristicFlopPoint.Clear;
    HeuristicTimeLine.Clear;
    HeuristicTimePoint.Clear;
    HeuristicCostBar.Clear;
  end;
end;

procedure TTSPSolverForm.EmailLabelClick(Sender: TObject);
begin
  if Sender=WebsiteLabel then
    ShellExecute(Handle,'open',PChar(WebsiteLabel.Caption),nil,nil,SW_SHOW);
  if Sender=EmailLabel then
    ShellExecute(Handle,'open',PChar('mailto:GrMikeD@usa.net?subject=For the TspSolver'),nil,nil,SW_SHOW);
end;

procedure TTSPSolverForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Counter.Free;
end;

procedure TTSPSolverForm.SameGraphCheckBoxClick(Sender: TObject);
begin
  NumberSpinEdit.Enabled:= not(SameGraphCheckBox.Checked);
end;

procedure TTSPSolverForm.NumberSpinEditChange(Sender: TObject);
begin
  CanSameGraph:= false;
  SameGraphCheckBox.Checked:= false;
  SameGraphCheckBox.Enabled:= false;
end;

procedure TTSPSolverForm.AddButtonClick(Sender: TObject);
var i: integer;
    Item,FoundItem: TListItem;
begin
  if AlgoGroup.ItemIndex=0 then
  begin
    for i:=0 to ExhaustiveFlopPoint.XValues.Count-1 do
    begin
        if ExhaustiveFlopPoint.XValues[i]=V then
        begin
           ExhaustiveFlopPoint.Delete(i);
           ExhaustiveTimePoint.Delete(i);
           ExhaustiveCostBar.Delete(i);
           break;
        end;
    end;
    ExhaustiveFlopPoint.AddXY(V, flop, '', clRed);
    ExhaustiveTimePoint.AddXY(V, time, '', clRed);
    ExhaustiveCostBar.AddXY(V, cost, '', clRed);
    FoundItem:= ExhaustiveView.FindCaption(0, IntToStr(V), false, true, false);
    if FoundItem<>nil then
      FoundItem.Delete;
    Item:= ExhaustiveView.Items.Add;
    Item.Caption:= IntToStr(V);
    Item.SubItems.Add(IntToStr(flop));
    Item.SubItems.Add(FloatToStrF(time,ffFixed,4,4));
    Item.SubItems.Add(IntToStr(cost));
  end
  else
  begin
    for i:=0 to HeuristicFlopPoint.XValues.Count-1 do
    begin
        if HeuristicFlopPoint.XValues[i]=V then
        begin
           HeuristicFlopPoint.Delete(i);
           HeuristicTimePoint.Delete(i);
           HeuristicCostBar.Delete(i);
           break;
        end;
    end;
    HeuristicFlopPoint.AddXY(V, flop, '', clBlue);
    HeuristicTimePoint.AddXY(V, time, '', clBlue);
    HeuristicCostBar.AddXY(V, cost, '', clBlue);
    FoundItem:= HeuristicView.FindCaption(0, IntToStr(V), false, true, false);
    if FoundItem<>nil then
      FoundItem.Delete;
    Item:= HeuristicView.Items.Add;
    Item.Caption:= IntToStr(V);
    Item.SubItems.Add(IntToStr(flop));
    Item.SubItems.Add(FloatToStrF(time,ffFixed,4,4));
    Item.SubItems.Add(IntToStr(cost));
  end;
end;

procedure TTSPSolverForm.AutoCheckBoxClick(Sender: TObject);
begin
  if PathFound=true then
    AddButton.Enabled:= not(AutoCheckBox.checked);
end;

procedure TTSPSolverForm.SetEnv(const b: boolean);
begin
  AlgoGroup.Enabled:= b;
  SameGraphCheckBox.Enabled:= b;
  if b and PathFound then
    AddButton.Enabled:= not(AutoCheckBox.Checked)
  else
    AddButton.Enabled:= false;
  FlopEdit.Enabled:= b;
  TimeEdit.Enabled:= b;
  NumberSpinEdit.Enabled:= not(SameGraphCheckBox.Checked);
  AutoCheckBox.Enabled:= b;
  TourEdit.Enabled:= b;
  CostEdit.Enabled:= b;
end;

procedure TTSPSOlverForm.ClearEnv;
begin
  FlopEdit.Text:= '0';
  TimeEdit.Text:= '0 sec';
  TourEdit.Clear;
  CostEdit.Clear;
end;

procedure TTSPSOlverForm.ViewResults;
begin
  FlopEdit.Text:= IntToStr(Flop);
  TimeEdit.Text:= FloatToStrF(time,ffFixed,4,4);
  if Stop then
  begin
    ClearEnv;
    AddButton.Enabled:= false;
  end
  else
    if PathFound=false then
    begin
      Beep;
      TourEdit.Text:= 'Connectivity Problem';
      CostEdit.Text:= '';
      FlopEdit.Text:= '0';
      TimeEdit.Text:= '0 sec';
      AddButton.Enabled:= false;
    end
    else
    begin
      FlopEdit.Text:= IntToStr(flop);
      TimeEdit.Text:= FloatToStrF(time,ffFixed,4,4)+' sec';
      if AutoCheckBox.Checked then
        AddButtonClick(Application);
    end;
  StatusBar.Panels[1].Text:= '';
end;

procedure TTSPSolverForm.StartButtonClick(Sender: TObject);
begin
  if StartButton.Caption='&Stop' then
    Stop:= true
  else
  begin
    StartButton.Caption:= '&Stop';
    StartButton.Glyph.LoadFromResourceName(hInstance,'Stop');
    StartButton.Update;
    SetEnv(false);
    Initiate;
    Case AlgoGroup.ItemIndex of
      0:  Exhaust;
      1:  Heurist;
    end;
    SetEnv(true);
    StartButton.Caption:= '&Start';
    StartButton.Glyph.LoadFromResourceName(hInstance,'Start');
    StartButton.Update;
    ViewResults;
  end;
end;

procedure TTSPSolverForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Stop:= true;
end;

procedure TTSPSolverForm.ExhaustiveViewInsert(Sender: TObject;
  Item: TListItem);
begin
  ResetExhaustiveButton.Enabled:= true;
end;

procedure TTSPSolverForm.HeuristicViewInsert(Sender: TObject;
  Item: TListItem);
begin
  ResetHeuristicButton.Enabled:= true;
end;

procedure TTSPSolverForm.ViewCheckBoxClick(Sender: TObject);
begin
  CostChart.View3D:= not(CostChart.View3D);
end;

procedure TTSPSolverForm.Log1CheckBoxClick(Sender: TObject);
begin
  if Sender=Log1CheckBox then
    FlopChart.LeftAxis.Logarithmic:= Log1CheckBox.Checked;
  if Sender=Log2CheckBox then
    TimeChart.LeftAxis.Logarithmic:= Log2CheckBox.Checked;
end;

end.