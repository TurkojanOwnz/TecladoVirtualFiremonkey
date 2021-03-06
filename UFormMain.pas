unit UFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TFormMain = class(TForm)
    StyleBook1: TStyleBook;
    pBackground: TPanel;
    lytBackground: TLayout;
    lytKeyboard: TLayout;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure EventOnKeyboard(_SenderFocus: TObject);
    procedure EventOffKeyboard;

    procedure EventOnNumPad(_SenderFocus: TObject; _Integer: boolean);
    procedure EventOffNumPad;

    procedure EventsLink;
    procedure CreateFrameInputs;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  FormMain: TFormMain;

implementation

uses
  UFrameKeyboard, UFrameNumpad, ULibrary, UFrameInputs;

{$R *.fmx}

{ TFormMain }

procedure TFormMain.CreateFrameInputs;
begin
  FrameInputs := TFrameInputs.Create(pBackground);
end;

destructor TFormMain.Destroy;
begin
  EventOffKeyboard;
  EventOffNumPad;

  if Assigned(FrameInputs) then
    FrameInputs.Release;

  inherited;
end;

procedure TFormMain.EventOffKeyboard;
begin
  if Assigned(FrameKeyboard) then
    FrameKeyboard.Release;
end;

procedure TFormMain.EventOffNumPad;
begin
  if Assigned(FrameNumpad) then
    FrameNumpad.Release;
end;

procedure TFormMain.EventOnKeyboard(_SenderFocus: TObject);
begin
  if not Assigned(FrameKeyboard) then
  begin
    FrameKeyboard := TFrameKeyboard.Create(lytKeyboard, _SenderFocus);
    lytBackground.BringToFront;
  end;
end;

procedure TFormMain.EventOnNumPad(_SenderFocus: TObject; _Integer: boolean);
begin
  if not Assigned(FrameNumpad) then
  begin
    FrameNumpad := TFrameNumpad.Create(lytKeyboard, _SenderFocus, _Integer);
    lytBackground.BringToFront;
  end;
end;

procedure TFormMain.EventsLink;
begin
  OnKeyboard  := EventOnKeyboard;
  OffKeyboard := EventOffKeyboard;
  OnNumpad    := EventOnNumpad;
  OffNumpad   := EventOffNumpad;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  EventsLink;
  CreateFrameInputs;
end;

end.
