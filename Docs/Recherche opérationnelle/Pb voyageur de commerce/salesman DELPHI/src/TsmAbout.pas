unit TsmAbout;

interface

uses
  Controls, StdCtrls, ExtCtrls, Classes, Forms, Windows, Graphics;

type
  TAboutBox = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Version: TLabel;
    Author: TLabel;
    Freeware: TLabel;
    Product: TLabel;
    HtmlLink: TLabel;
    procedure HtmlLinkClick(Sender: TObject);
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

uses
  ShellAPI;

procedure TAboutBox.HtmlLinkClick(Sender: TObject);
begin
  ShellExecute(Application.MainForm.Handle, nil,
               PChar(HtmlLink.Caption), nil, '.', SW_RESTORE);
{ Alternatively you could use:
  ExecuteFile(HtmlLink.Caption, '.', 'c:\', SW_RESTORE);
  Remember to get the FMXUtils unit from the Delphi Demo folder. }
end;

end.

