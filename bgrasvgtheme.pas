unit BGRASVGTheme;

{$mode delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  BGRATheme, BGRABitmap, BGRABitmapTypes, BGRASVG, BGRASVGType, XMLConf;

type

  { TBGRASVGTheme }

  TBGRASVGTheme = class(TBGRATheme)
  private
    FButtonActive: TStringList;
    FButtonHover: TStringList;
    FButtonNormal: TStringList;
    FButtonSliceScalingBottom: integer;
    FButtonSliceScalingLeft: integer;
    FButtonSliceScalingRight: integer;
    FButtonSliceScalingTop: integer;
    FCheckBoxChecked: TStringList;
    FCheckBoxUnchecked: TStringList;
    FColorizeActive: string;
    FColorizeDisabled: string;
    FColorizeHover: string;
    FColorizeNormal: string;
    FRadioButtonChecked: TStringList;
    FRadioButtonUnchecked: TStringList;
    procedure SetButtonActive(AValue: TStringList);
    procedure SetButtonHover(AValue: TStringList);
    procedure SetButtonNormal(AValue: TStringList);
    procedure SetButtonSliceScalingBottom(AValue: integer);
    procedure SetButtonSliceScalingLeft(AValue: integer);
    procedure SetButtonSliceScalingRight(AValue: integer);
    procedure SetButtonSliceScalingTop(AValue: integer);
    procedure SetCheckBoxChecked(AValue: TStringList);
    procedure SetCheckBoxUnchecked(AValue: TStringList);
    procedure SetColorizeActive(AValue: string);
    procedure SetColorizeDisabled(AValue: string);
    procedure SetColorizeHover(AValue: string);
    procedure SetColorizeNormal(AValue: string);
    procedure SetRadioButtonChecked(AValue: TStringList);
    procedure SetRadioButtonUnchecked(AValue: TStringList);
  protected
    procedure LoadTheme(const XMLConf: TXMLConfig);
    procedure SaveTheme(const XMLConf: TXMLConfig);
    procedure CheckEmptyResourceException(const aResource: string);
    procedure SliceScalingDraw(const Source: TBGRASVG;
      const marginLeft, marginTop, marginRight, marginBottom: integer;
      const Dest: TBGRABitmap; DestDPI: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure DrawButton(Caption: string; State: TBGRAThemeButtonState;
      Focused: boolean; ARect: TRect; ASurface: TBGRAThemeSurface); override;
    procedure DrawRadioButton(Caption: string; State: TBGRAThemeButtonState;
    {%H-}Focused: boolean; Checked: boolean; ARect: TRect;
      ASurface: TBGRAThemeSurface); override;
    procedure DrawCheckBox(Caption: string; State: TBGRAThemeButtonState;
    {%H-}Focused: boolean; Checked: boolean; ARect: TRect;
      ASurface: TBGRAThemeSurface); override;
  public
    // XML File
    procedure SaveToFile(AFileName: string);
    // XML File
    procedure LoadFromFile(AFileName: string);
    // String Stream
    procedure SaveToStream(AStream: TStream);
    // String Stream
    procedure LoadFromStream(AStream: TStream);
    // Resource
    procedure LoadFromResource(AResource: string);
  published
    // Check box unchecked state
    property CheckBoxUnchecked: TStringList read FCheckBoxUnchecked
      write SetCheckBoxUnchecked;
    // Check box checked state
    property CheckBoxChecked: TStringList read FCheckBoxChecked write SetCheckBoxChecked;
    // Radio button unchecked state
    property RadioButtonUnchecked: TStringList
      read FRadioButtonUnchecked write SetRadioButtonUnchecked;
    // Radio button checked state
    property RadioButtonChecked: TStringList
      read FRadioButtonChecked write SetRadioButtonChecked;
    // Button normal state
    property ButtonNormal: TStringList read FButtonNormal write SetButtonNormal;
    // Button mouse over state
    property ButtonHover: TStringList read FButtonHover write SetButtonHover;
    // Button pressed state
    property ButtonActive: TStringList read FButtonActive write SetButtonActive;
    // 9-Slice-Scaling margin left
    property ButtonSliceScalingLeft: integer
      read FButtonSliceScalingLeft write SetButtonSliceScalingLeft;
    // 9-Slice-Scaling margin top
    property ButtonSliceScalingTop: integer
      read FButtonSliceScalingTop write SetButtonSliceScalingTop;
    // 9-Slice-Scaling margin right
    property ButtonSliceScalingRight: integer
      read FButtonSliceScalingRight write SetButtonSliceScalingRight;
    // 9-Slice-Scaling margin bottom
    property ButtonSliceScalingBottom: integer
      read FButtonSliceScalingBottom write SetButtonSliceScalingBottom;
    // CSS Color to tint the normal states, use rgba(0,0,0,0) to disable
    property ColorizeNormal: string read FColorizeNormal write SetColorizeNormal;
    // CSS Color to tint the hover states, use rgba(0,0,0,0) to disable
    property ColorizeHover: string read FColorizeHover write SetColorizeHover;
    // CSS Color to tint the active states, use rgba(0,0,0,0) to disable
    property ColorizeActive: string read FColorizeActive write SetColorizeActive;
    // CSS Color to tint the disabled states, use rgba(0,0,0,0) to disable
    property ColorizeDisabled: string read FColorizeDisabled write SetColorizeDisabled;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BGRA Themes', [TBGRASVGTheme]);
end;

{ TBGRASVGTheme }

procedure TBGRASVGTheme.SetCheckBoxUnchecked(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FCheckBoxUnchecked) then
  begin
    FCheckBoxUnchecked.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetColorizeActive(AValue: string);
begin
  if FColorizeActive = AValue then
    Exit;
  FColorizeActive := AValue;
end;

procedure TBGRASVGTheme.SetColorizeDisabled(AValue: string);
begin
  if FColorizeDisabled = AValue then
    Exit;
  FColorizeDisabled := AValue;
end;

procedure TBGRASVGTheme.SetColorizeHover(AValue: string);
begin
  if FColorizeHover = AValue then
    Exit;
  FColorizeHover := AValue;
end;

procedure TBGRASVGTheme.SetColorizeNormal(AValue: string);
begin
  if FColorizeNormal = AValue then
    Exit;
  FColorizeNormal := AValue;
end;

procedure TBGRASVGTheme.SetRadioButtonChecked(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FRadioButtonChecked) then
  begin
    FRadioButtonChecked.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetRadioButtonUnchecked(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FRadioButtonUnchecked) then
  begin
    FRadioButtonUnchecked.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.LoadTheme(const XMLConf: TXMLConfig);
begin
  XMLConf.RootName := 'BGRASVGTheme';
  // Button
  FButtonActive.Text := XMLConf.GetValue('Button/Active/SVG', ''){%H-};
  FButtonHover.Text := XMLConf.GetValue('Button/Hover/SVG', ''){%H-};
  FButtonNormal.Text := XMLConf.GetValue('Button/Normal/SVG', ''){%H-};
  FButtonSliceScalingBottom := XMLConf.GetValue('Button/SliceScaling/Bottom', 0);
  FButtonSliceScalingLeft := XMLConf.GetValue('Button/SliceScaling/Left', 0);
  FButtonSliceScalingRight := XMLConf.GetValue('Button/SliceScaling/Right', 0);
  FButtonSliceScalingTop := XMLConf.GetValue('Button/SliceScaling/Top', 0);
  // CheckBox
  FCheckBoxChecked.Text := XMLConf.GetValue('CheckBox/Checked/SVG', ''){%H-};
  FCheckBoxUnchecked.Text := XMLConf.GetValue('CheckBox/Unchecked/SVG', ''){%H-};
  // Colorize
  FColorizeActive := XMLConf{%H-}.GetValue('Colorize/Active', '');
  FColorizeDisabled := XMLConf{%H-}.GetValue('Colorize/Disabled', '');
  FColorizeHover := XMLConf{%H-}.GetValue('Colorize/Hover', '');
  FColorizeNormal := XMLConf{%H-}.GetValue('Colorize/Normal', '');
  // RadioButton
  FRadioButtonChecked.Text :=
    XMLConf.GetValue('RadioButton/Checked/SVG', ''{%H-}){%H-};
  FRadioButtonUnchecked.Text :=
    XMLConf.GetValue('RadioButton/Unchecked/SVG', ''{%H-}){%H-};
end;

procedure TBGRASVGTheme.SaveTheme(const XMLConf: TXMLConfig);
begin
  XMLConf.RootName := 'BGRASVGTheme';
  // Button
  XMLConf.SetValue('Button/Active/SVG', FButtonActive.Text{%H-});
  XMLConf.SetValue('Button/Hover/SVG', FButtonHover.Text{%H-});
  XMLConf.SetValue('Button/Normal/SVG', FButtonNormal.Text{%H-});
  XMLConf.SetValue('Button/SliceScaling/Bottom', FButtonSliceScalingBottom);
  XMLConf.SetValue('Button/SliceScaling/Left', FButtonSliceScalingLeft);
  XMLConf.SetValue('Button/SliceScaling/Right', FButtonSliceScalingRight);
  XMLConf.SetValue('Button/SliceScaling/Top', FButtonSliceScalingTop);
  // CheckBox
  XMLConf.SetValue('CheckBox/Checked/SVG', FCheckBoxChecked.Text{%H-});
  XMLConf.SetValue('CheckBox/Unchecked/SVG', FCheckBoxUnchecked.Text{%H-});
  // Colorize
  XMLConf.SetValue('Colorize/Active', FColorizeActive{%H-});
  XMLConf.SetValue('Colorize/Disabled', FColorizeDisabled{%H-});
  XMLConf.SetValue('Colorize/Hover', FColorizeHover{%H-});
  XMLConf.SetValue('Colorize/Normal', FColorizeNormal{%H-});
  // RadioButton
  XMLConf.SetValue('RadioButton/Checked/SVG', FRadioButtonChecked.Text{%H-});
  XMLConf.SetValue('RadioButton/Unchecked/SVG', FRadioButtonUnchecked.Text{%H-});
end;

procedure TBGRASVGTheme.CheckEmptyResourceException(const aResource: string);
begin
  if (aResource.IsEmpty) then
    raise Exception.Create('Resource must not be empty.');
end;

procedure TBGRASVGTheme.SliceScalingDraw(const Source: TBGRASVG;
  const marginLeft, marginTop, marginRight, marginBottom: integer;
  const Dest: TBGRABitmap; DestDPI: integer);
var
  svgBox: TSVGViewBox;
  svgTopLeft, svgBottomRight: TPointF;
  sourcePosX, sourcePosY: array[1..4] of single;
  destPosX, destPosY: array[1..4] of integer;
  y, x: integer;

  procedure DrawPart(sourceRect: TRectF; destRect: TRect);
  var
    zoom: TPointF;
  begin
    if sourceRect.IsEmpty or destRect.IsEmpty then
      exit;
    dest.ClipRect := destRect;
    zoom := PointF(destRect.Width / sourceRect.Width, destRect.Height /
      sourceRect.Height);
    Source.Draw(dest.Canvas2D, -sourceRect.Left * zoom.x + destRect.Left,
      -sourceRect.Top * zoom.y + destRect.Top, Source.DefaultDpi * zoom);
  end;

begin
  svgBox := Source.ViewBoxInUnit[cuPixel];
  svgTopLeft := svgBox.min;
  svgBottomRight := svgBox.min + svgBox.size;

  sourcePosX[1] := svgTopLeft.x;
  sourcePosX[2] := svgTopLeft.x + marginLeft;
  sourcePosX[3] := svgBottomRight.x - marginRight;
  sourcePosX[4] := svgBottomRight.x;
  sourcePosY[1] := svgTopLeft.y;
  sourcePosY[2] := svgTopLeft.y + marginTop;
  sourcePosY[3] := svgBottomRight.y - marginBottom;
  sourcePosY[4] := svgBottomRight.y;
  if sourcePosX[2] > sourcePosX[3] then
  begin
    sourcePosX[2] := (sourcePosX[1] + sourcePosX[4]) / 2;
    sourcePosX[3] := sourcePosX[2];
  end;
  if sourcePosY[2] > sourcePosY[3] then
  begin
    sourcePosY[2] := (sourcePosY[1] + sourcePosY[4]) / 2;
    sourcePosY[3] := sourcePosY[2];
  end;

  destPosX[1] := 0;
  destPosX[2] := round(marginLeft * DestDPI / 96);
  destPosX[3] := dest.Width - round(marginRight * DestDPI / 96);
  destPosX[4] := dest.Width;
  destPosY[1] := 0;
  destPosY[2] := round(marginTop * DestDPI / 96);
  destPosY[3] := dest.Height - round(marginBottom * DestDPI / 96);
  destPosY[4] := dest.Height;
  if destPosX[2] > destPosX[3] then
  begin
    destPosX[2] := round((destPosX[1] + destPosX[4]) / 2);
    destPosX[3] := destPosX[2];
  end;
  if destPosY[2] > destPosY[3] then
  begin
    destPosY[2] := round((destPosY[1] + destPosY[4]) / 2);
    destPosY[3] := destPosY[2];
  end;

  for y := 1 to 3 do
    for x := 1 to 3 do
      DrawPart(RectF(sourcePosX[x], sourcePosY[y], sourcePosX[x + 1], sourcePosY[y + 1]),
        Rect(destPosX[x], destPosY[y], destPosX[x + 1], destPosY[y + 1]));
  Dest.NoClip;
end;

constructor TBGRASVGTheme.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // https://material.io/resources/icons/
  FCheckBoxUnchecked := TStringList.Create;
  FCheckBoxUnchecked.Text :=
    '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M19 5v14H5V5h14m0-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z"/></svg>';
  FCheckBoxChecked := TStringList.Create;
  FCheckBoxChecked.Text :=
    '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.11 0 2-.9 2-2V5c0-1.1-.89-2-2-2zm-9 14l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>';
  FRadioButtonUnchecked := TStringList.Create;
  FRadioButtonUnchecked.Text :=
    '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/></svg>';
  FRadioButtonChecked := TStringList.Create;
  FRadioButtonChecked.Text :=
    '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0-5C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/></svg>';
  // Button
  FButtonNormal := TStringList.Create;
  FButtonNormal.Text :=
    '<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg   xmlns:dc="http://purl.org/dc/elements/1.1/"   xmlns:cc="http://creativecommons.org/ns#"   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"   xmlns:svg="http://www.w3.org/2000/svg"   xmlns="http://www.w3.org/2000/svg"   xmlns:xlink="http://www.w3.org/1999/xlink"   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"   width="32"   height="32"   viewBox="0 0 32 32"   version="1.1"   id="svg8"   inkscape:version="1.0.1 (3bc2e813f5, 2020-09-07)"   sodipodi:docname="lime.svg">  <style     id="style833"></style>  <defs     id="defs2">    <linearGradient       inkscape:collect="always"       id="linearGradient858">      <stop         style="stop-color:#87cdde;stop-opacity:1"         offset="0"         id="stop854" />      <stop         style="stop-color:#ffffff;stop-opacity:1"         offset="1"         id="stop856" />    </linearGradient>    <linearGradient       inkscape:collect="always"       xlink:href="#linearGradient858"       id="linearGradient1415"       x1="3.9924731"       y1="5.9193549"       x2="3.9924731"       y2="2.788172"       gradientUnits="userSpaceOnUse"       gradientTransform="matrix(4.1517857,0,0,4.1517856,-1.5758928,-1.5758928)" />  </defs>  <sodipodi:namedview     id="base"     pagecolor="#ffffff"     bordercolor="#666666"     borderopacity="1.0"     inkscape:pageopacity="0.0"     inkscape:pageshadow="2"     inkscape:zoom="11.313708"     inkscape:cx="4.3902273"     inkscape:cy="23.941929"     inkscape:document-units="px"     inkscape:current-layer="layer1"     inkscape:document-rotation="0"     showgrid="true"     units="px"     inkscape:window-width="1920"     inkscape:window-height="1017"     inkscape:window-x="-8"     inkscape:window-y="-8"     inkscape:window-maximized="1">    <inkscape:grid       type="xygrid"       id="grid837" />  </sodipodi:namedview>  <metadata     id="metadata5">    <rdf:RDF>      <cc:Work         rdf:about="">        <dc:format>image/svg+xml</dc:format>        <dc:type           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />        <dc:title></dc:title>      </cc:Work>    </rdf:RDF>  </metadata>  <g     inkscape:label="Capa 1"     inkscape:groupmode="layer"     id="layer1">    <path       vectorEffect="non-scaling-stroke"       id="rect835"       style="fill:url(#linearGradient1415);fill-opacity:1;stroke:#002255;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"       d="M 9.8000004,0.50000004 H 22.2 c 5.1522,0 9.3,4.14779986 9.3,9.30000016 V 22.2 c 0,5.152199 -4.1478,9.3 -9.3,9.3 H 9.8000004 C 4.6478005,31.5 0.50000005,27.352199 0.50000005,22.2 V 9.8000002 c 0,-5.1522003 4.14780045,-9.30000016 9.30000035,-9.30000016 z" />  </g></svg>';
  FButtonHover := TStringList.Create;
  FButtonHover.Text := FButtonNormal.Text;
  FButtonActive := TStringList.Create;
  FButtonActive.Text := FButtonNormal.Text;
  FButtonSliceScalingLeft := 10;
  FButtonSliceScalingTop := 10;
  FButtonSliceScalingRight := 10;
  FButtonSliceScalingBottom := 10;
  // Colorize
  FColorizeNormal := 'rgba(0,0,0,0)';
  FColorizeHover := 'rgba(255,255,255,0.5)';
  FColorizeActive := 'rgba(0,0,0,0.5)';
  FColorizeDisabled := 'rgba(127,127,127,0.7)';
end;

destructor TBGRASVGTheme.Destroy;
begin
  FCheckBoxUnchecked.Free;
  FCheckBoxChecked.Free;
  FRadioButtonUnchecked.Free;
  FRadioButtonChecked.Free;
  FButtonNormal.Free;
  FButtonHover.Free;
  FButtonActive.Free;
  inherited Destroy;
end;

procedure TBGRASVGTheme.DrawButton(Caption: string; State: TBGRAThemeButtonState;
  Focused: boolean; ARect: TRect; ASurface: TBGRAThemeSurface);
var
  Style: TTextStyle;
  svg: TBGRASVG;
  color: string;
begin
  with ASurface do
  begin
    case State of
      btbsNormal: svg := TBGRASVG.CreateFromString(FButtonNormal.Text);
      btbsHover: svg := TBGRASVG.CreateFromString(FButtonHover.Text);
      btbsActive: svg := TBGRASVG.CreateFromString(FButtonActive.Text);
      btbsDisabled: svg := TBGRASVG.CreateFromString(FButtonNormal.Text);
    end;
    SliceScalingDraw(svg{%H-}, FButtonSliceScalingLeft, FButtonSliceScalingTop,
      FButtonSliceScalingRight, FButtonSliceScalingBottom, ASurface.Bitmap,
      Screen.PixelsPerInch);
    svg.Free;
    case State of
      btbsNormal: color := FColorizeNormal;
      btbsHover: color := FColorizeHover;
      btbsActive: color := FColorizeActive;
      btbsDisabled: color := FColorizeDisabled;
    end;
    BitmapColorOverlay(color{%H-});
    DrawBitmap;

    if Focused then
    begin
      DestCanvas.Pen.Color := clBlack;
      DestCanvas.Rectangle(ARect);
    end;

    if Caption <> '' then
    begin
      Style.Alignment := taCenter;
      Style.Layout := tlCenter;
      Style.Wordbreak := True;
      Style.SystemFont := False;
      Style.Clipping := True;
      Style.Opaque := False;
      DestCanvas.TextRect(ARect, 0, 0, Caption, Style);
    end;
  end;
end;

procedure TBGRASVGTheme.DrawRadioButton(Caption: string;
  State: TBGRAThemeButtonState; Focused: boolean; Checked: boolean;
  ARect: TRect; ASurface: TBGRAThemeSurface);
var
  Style: TTextStyle;
  svg: TBGRASVG;
  color: string;
begin
  with ASurface do
  begin
    BitmapRect := RectWithSize(ARect.Left, ARect.Top, ARect.Height, ARect.Height);
    if Checked then
      svg := TBGRASVG.CreateFromString(FRadioButtonChecked.Text)
    else
      svg := TBGRASVG.CreateFromString(FRadioButtonUnchecked.Text);
    svg.StretchDraw(Bitmap.Canvas2D, 0, 0, Bitmap.Width, Bitmap.Height);
    svg.Free;
    case State of
      btbsNormal: color := FColorizeNormal;
      btbsHover: color := FColorizeHover;
      btbsActive: color := FColorizeActive;
      btbsDisabled: color := FColorizeDisabled;
    end;
    BitmapColorOverlay(color{%H-});
    DrawBitmap;

    if Caption <> '' then
    begin
      Style.Alignment := taLeftJustify;
      Style.Layout := tlCenter;
      Style.Wordbreak := True;
      Style.SystemFont := False;
      Style.Clipping := True;
      Style.Opaque := False;
      DestCanvas.TextRect(Rect(Arect.Height, 0, ARect.Right, ARect.Bottom),
        ARect.Height, 0, Caption, Style);
    end;
  end;
end;

procedure TBGRASVGTheme.SetCheckBoxChecked(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FCheckBoxChecked) then
  begin
    FCheckBoxChecked.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetButtonActive(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FButtonActive) then
  begin
    FButtonActive.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetButtonHover(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FButtonHover) then
  begin
    FButtonHover.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetButtonNormal(AValue: TStringList);
begin
  CheckEmptyResourceException(AValue.Text);
  if (AValue <> FButtonNormal) then
  begin
    FButtonNormal.Assign(AValue);
  end;
end;

procedure TBGRASVGTheme.SetButtonSliceScalingBottom(AValue: integer);
begin
  if FButtonSliceScalingBottom = AValue then
    Exit;
  FButtonSliceScalingBottom := AValue;
end;

procedure TBGRASVGTheme.SetButtonSliceScalingLeft(AValue: integer);
begin
  if FButtonSliceScalingLeft = AValue then
    Exit;
  FButtonSliceScalingLeft := AValue;
end;

procedure TBGRASVGTheme.SetButtonSliceScalingRight(AValue: integer);
begin
  if FButtonSliceScalingRight = AValue then
    Exit;
  FButtonSliceScalingRight := AValue;
end;

procedure TBGRASVGTheme.SetButtonSliceScalingTop(AValue: integer);
begin
  if FButtonSliceScalingTop = AValue then
    Exit;
  FButtonSliceScalingTop := AValue;
end;

procedure TBGRASVGTheme.DrawCheckBox(Caption: string; State: TBGRAThemeButtonState;
  Focused: boolean; Checked: boolean; ARect: TRect; ASurface: TBGRAThemeSurface);
var
  Style: TTextStyle;
  svg: TBGRASVG;
  color: string;
begin
  with ASurface do
  begin
    BitmapRect := RectWithSize(ARect.Left, ARect.Top, ARect.Height, ARect.Height);
    if Checked then
      svg := TBGRASVG.CreateFromString(FCheckBoxChecked.Text)
    else
      svg := TBGRASVG.CreateFromString(FCheckBoxUnchecked.Text);
    svg.StretchDraw(Bitmap.Canvas2D, 0, 0, Bitmap.Width, Bitmap.Height);
    svg.Free;
    case State of
      btbsNormal: color := FColorizeNormal;
      btbsHover: color := FColorizeHover;
      btbsActive: color := FColorizeActive;
      btbsDisabled: color := FColorizeDisabled;
    end;
    BitmapColorOverlay(color{%H-});
    DrawBitmap;

    if Caption <> '' then
    begin
      Style.Alignment := taLeftJustify;
      Style.Layout := tlCenter;
      Style.Wordbreak := True;
      Style.SystemFont := False;
      Style.Clipping := True;
      Style.Opaque := False;
      DestCanvas.TextRect(Rect(Arect.Height, 0, ARect.Right, ARect.Bottom),
        ARect.Height, 0, Caption, Style);
    end;
  end;
end;

procedure TBGRASVGTheme.SaveToFile(AFileName: string);
var
  FXMLConf: TXMLConfig;
begin
  FXMLConf := TXMLConfig.Create(Self);
  try
    FXMLConf.Filename := AFileName;
    SaveTheme(FXMLConf);
    FXMLConf.Flush;
  finally
    FXMLConf.Free;
  end;
end;

procedure TBGRASVGTheme.LoadFromFile(AFileName: string);
var
  FXMLConf: TXMLConfig;
begin
  FXMLConf := TXMLConfig.Create(Self);
  try
    FXMLConf.Filename := AFileName;
    LoadTheme(FXMLConf);
  finally
    FXMLConf.Free;
  end;
end;

procedure TBGRASVGTheme.SaveToStream(AStream: TStream);
var
  FXMLConf: TXMLConfig;
begin
  FXMLConf := TXMLConfig.Create(Self);
  try
    SaveTheme(FXMLConf);
    FXMLConf.SaveToStream(AStream);
    FXMLConf.Flush;
  finally
    FXMLConf.Free;
  end;
end;

procedure TBGRASVGTheme.LoadFromStream(AStream: TStream);
var
  FXMLConf: TXMLConfig;
begin
  FXMLConf := TXMLConfig.Create(Self);
  try
    FXMLConf.RootName := 'BGRASVGTheme';
    AStream.Position := 0;
    FXMLConf.LoadFromStream(AStream);
    LoadTheme(FXMLConf);
  finally
    FXMLConf.Free;
  end;
end;

procedure TBGRASVGTheme.LoadFromResource(AResource: string);
var
  AStream: TStream;
begin
  AStream := BGRAResource.GetResourceStream(AResource);
  LoadFromStream(AStream);
  AStream.Free;
end;

end.
