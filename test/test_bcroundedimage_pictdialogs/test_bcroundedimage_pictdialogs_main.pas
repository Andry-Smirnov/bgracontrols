unit test_bcroundedimage_pictdialogs_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Spin, StdCtrls, ExtDlgs,
  BCRoundedImage, BGRABitmap, BGRADialogs, BGRABitmapTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    BCRoundedImage1: TBCRoundedImage;
    btLoad: TButton;
    btLoadT: TButton;
    btLoad2: TButton;
    btLoad3: TButton;
    Button1: TButton;
    cbProportional: TCheckBox;
    cbStretch: TCheckBox;
    edRounding: TFloatSpinEdit;
    Label1: TLabel;
    lbDetails: TLabel;
    openPict: TOpenPictureDialog;
    Panel1: TPanel;
    rgAlign: TRadioGroup;
    rgAlignV: TRadioGroup;
    rgStyle: TRadioGroup;
    savePict: TSavePictureDialog;
    procedure BCRoundedImage1PaintEvent(const Sender: TBCRoundedImage; const Bitmap: TBGRABitmap);
    procedure btLoadClick(Sender: TObject);
    procedure btLoadTClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbProportionalChange(Sender: TObject);
    procedure cbStretchChange(Sender: TObject);
    procedure edRoundingChange(Sender: TObject);
    procedure rgAlignClick(Sender: TObject);
    procedure rgAlignVClick(Sender: TObject);
    procedure rgStyleClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BCRoundedImage1PaintEvent(const Sender: TBCRoundedImage; const Bitmap: TBGRABitmap);
begin
  //
end;

procedure TForm1.btLoadClick(Sender: TObject);
var
   openPictBGRA: TBGRAOpenPictureDialog;

begin
  try
     openPictBGRA:= TBGRAOpenPictureDialog.Create(Self);
     if openPictBGRA.Execute then
     begin
       BCRoundedImage1.Picture:= nil;
       BCRoundedImage1.Bitmap.LoadFromFile(openPictBGRA.FileName); //'c:\tmp\Acquisitions Book 1.03.01, Byzantine.jpg'
       BCRoundedImage1.Invalidate;
       lbDetails.Caption:= 'image: BGRA '+IntToStr(BCRoundedImage1.Bitmap.Width)+' x '+IntToStr(BCRoundedImage1.Bitmap.Height);
     end;

  finally
    openPictBGRA.Free;
  end;
end;

procedure TForm1.btLoadTClick(Sender: TObject);
begin
  if openPict.Execute then
  begin
    BCRoundedImage1.Bitmap:= nil;
    BCRoundedImage1.Picture.LoadFromFile(openPict.FileName); //'c:\tmp\Acquisitions Book 1.03.01, Byzantine.jpg'
    BCRoundedImage1.Invalidate;
    lbDetails.Caption:= 'image: PICT '+IntToStr(BCRoundedImage1.Picture.Width)+' x '+IntToStr(BCRoundedImage1.Picture.Height);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   t, t2: String;

begin
  BuildBGRAFilterStrings(True, t, t2);
end;

procedure TForm1.cbProportionalChange(Sender: TObject);
begin
  BCRoundedImage1.Proportional:= cbProportional.Checked;
end;

procedure TForm1.cbStretchChange(Sender: TObject);
begin
  BCRoundedImage1.Stretch:= cbStretch.Checked;
end;

procedure TForm1.edRoundingChange(Sender: TObject);
begin
  BCRoundedImage1.Rounding:= edRounding.Value;
end;

procedure TForm1.rgAlignClick(Sender: TObject);
begin
  BCRoundedImage1.Alignment:= TAlignment(rgAlign.ItemIndex);
end;

procedure TForm1.rgAlignVClick(Sender: TObject);
begin
  BCRoundedImage1.VerticalAlignment:= TTextLayout(rgAlignV.ItemIndex);
end;

procedure TForm1.rgStyleClick(Sender: TObject);
begin
  BCRoundedImage1.Style:= TBCRoundedImageStyle(rgStyle.ItemIndex);
end;

end.

