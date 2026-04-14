$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

function New-RoundedRectPath {
  param(
    [float]$X,
    [float]$Y,
    [float]$Width,
    [float]$Height,
    [float]$Radius
  )

  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $Radius * 2
  $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
  $path.AddArc($X + $Width - $diameter, $Y, $diameter, $diameter, 270, 90)
  $path.AddArc($X + $Width - $diameter, $Y + $Height - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($X, $Y + $Height - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
  return $path
}

function Draw-OutlinedText {
  param(
    [System.Drawing.Graphics]$Graphics,
    [string]$Text,
    [System.Drawing.Font]$Font,
    [System.Drawing.RectangleF]$Rect,
    [System.Drawing.StringFormat]$Format,
    [System.Drawing.Brush]$FillBrush,
    [System.Drawing.Brush]$StrokeBrush,
    [float]$StrokeWidth = 3
  )

  $family = $Font.FontFamily
  $style = [System.Drawing.FontStyle]$Font.Style
  $emSize = $Graphics.DpiY * $Font.Size / 72
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path.AddString($Text, $family, [int]$style, $emSize, $Rect, $Format)
  $pen = New-Object System.Drawing.Pen($StrokeBrush, $StrokeWidth)
  $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
  $Graphics.DrawPath($pen, $path)
  $Graphics.FillPath($FillBrush, $path)
  $pen.Dispose()
  $path.Dispose()
}

function Draw-Tag {
  param(
    [System.Drawing.Graphics]$Graphics,
    [float]$X,
    [float]$Y,
    [float]$Width,
    [float]$Height,
    [string]$Text,
    [System.Drawing.Font]$Font
  )

  $path = New-RoundedRectPath -X $X -Y $Y -Width $Width -Height $Height -Radius 10
  $fill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(230, 98, 64, 32))
  $stroke = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(235, 225, 194, 142), 2)
  $Graphics.FillPath($fill, $path)
  $Graphics.DrawPath($stroke, $path)

  $fmt = New-Object System.Drawing.StringFormat
  $fmt.Alignment = [System.Drawing.StringAlignment]::Center
  $fmt.LineAlignment = [System.Drawing.StringAlignment]::Center
  $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 249, 232, 201))
  $Graphics.DrawString($Text, $Font, $brush, (New-Object System.Drawing.RectangleF($X, $Y - 1, $Width, $Height)), $fmt)

  $brush.Dispose()
  $fill.Dispose()
  $stroke.Dispose()
  $path.Dispose()
  $fmt.Dispose()
}

function Draw-WrappedText {
  param(
    [System.Drawing.Graphics]$Graphics,
    [string]$Text,
    [System.Drawing.Font]$Font,
    [System.Drawing.Brush]$Brush,
    [float]$X,
    [float]$Y,
    [float]$Width,
    [float]$LineHeight
  )

  $lines = New-Object System.Collections.Generic.List[string]
  $buffer = ""
  foreach ($char in $Text.ToCharArray()) {
    $test = $buffer + $char
    $size = $Graphics.MeasureString($test, $Font)
    if ($size.Width -gt $Width -and $buffer.Length -gt 0) {
      $lines.Add($buffer)
      $buffer = [string]$char
    } else {
      $buffer = $test
    }
  }
  if ($buffer.Length -gt 0) {
    $lines.Add($buffer)
  }

  for ($i = 0; $i -lt $lines.Count; $i++) {
    $Graphics.DrawString($lines[$i], $Font, $Brush, $X, $Y + ($i * $LineHeight))
  }
}

$source = "C:\Users\wang_\Desktop\daping\图片25年历程.png"
$output = "C:\Users\wang_\Desktop\研究院大屏\page-discipline\图片25年历程-更新.png"

$bitmap = [System.Drawing.Bitmap]::FromFile($source)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# Rebuild center title area as 26年历程
$centerBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(240, 8, 10, 16))
$graphics.FillEllipse($centerBrush, 3605, 78, 1370, 730)
$graphics.FillRectangle($centerBrush, 4030, 100, 540, 720)

$fmtCenter = New-Object System.Drawing.StringFormat
$fmtCenter.Alignment = [System.Drawing.StringAlignment]::Center
$fmtCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

$fontBig = New-Object System.Drawing.Font("KaiTi", 118, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$fontYear = New-Object System.Drawing.Font("Microsoft YaHei", 38, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$fontHistory = New-Object System.Drawing.Font("Microsoft YaHei", 62, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)

$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$strokeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(170, 40, 24, 12))
Draw-OutlinedText -Graphics $graphics -Text "26" -Font $fontBig -Rect (New-Object System.Drawing.RectangleF(3820, 120, 700, 420)) -Format $fmtCenter -FillBrush $whiteBrush -StrokeBrush $strokeBrush -StrokeWidth 5
$graphics.DrawString("年", $fontYear, $whiteBrush, 4438, 212)
$graphics.DrawString("历", $fontHistory, $whiteBrush, 4620, 238)
$graphics.DrawString("程", $fontHistory, $whiteBrush, 4682, 328)

$fontSmallRed = New-Object System.Drawing.Font("Arial", 18, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$redBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 216, 91, 71))
$graphics.DrawString("2000-2025", $fontSmallRed, $redBrush, 3858, 594)

# Cover original right-most area and redraw 2025 nodes
$panelRect = New-Object System.Drawing.Rectangle(7440, 90, 1640, 900)
$panelBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(242, 7, 10, 18))
$graphics.FillRectangle($panelBrush, $panelRect)

# Decorative outline approximating original panel
$outlinePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 171, 121, 62), 2)
$outlinePen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dot
$graphics.DrawArc($outlinePen, 7455, 120, 210, 120, 90, 180)
$graphics.DrawArc($outlinePen, 8855, 120, 180, 120, 270, 180)
$graphics.DrawArc($outlinePen, 7455, 810, 210, 120, 90, -180)
$graphics.DrawArc($outlinePen, 8855, 810, 180, 120, 270, -180)
$graphics.DrawLine($outlinePen, 7560, 120, 8940, 120)
$graphics.DrawLine($outlinePen, 7560, 930, 8940, 930)

$nodePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(228, 214, 180, 120), 3)
$nodeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 231, 192, 114))

$fontDate = New-Object System.Drawing.Font("Georgia", 23, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$fontBody = New-Object System.Drawing.Font("Microsoft YaHei", 22, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$bodyBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 250, 245, 232))

$yAxis = 535
$graphics.DrawLine((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 184, 132, 70), 3)), 7560, $yAxis, 8990, $yAxis)

$nodes = @(
  @{ Date = "2025.01.10"; X = 7645; Dir = "up";   Text = "薛付忠院长主编的医学数据学专业指南性专著《医学数据学专业建设探索与实践》顺利出版发行"; Wrap = 350 },
  @{ Date = "2025.05.08"; X = 8125; Dir = "down"; Text = "获山东大学2025年教学成果奖（本科）特等奖"; Wrap = 360 },
  @{ Date = "2025.05.28"; X = 7898; Dir = "up";   Text = "山东大学“数智健康”东营研究基地揭牌"; Wrap = 310 },
  @{ Date = "2025.12.19"; X = 8548; Dir = "up";   Text = "成果“大数据驱动的慢病一体化智能预测预警干预的关键技术及转化应用”获教育部科学研究优秀成果奖（工程技术类）二等奖"; Wrap = 390 },
  @{ Date = "2025.12.27"; X = 8710; Dir = "down"; Text = "获第十届高等教育省级教学成果奖（本科）一等奖"; Wrap = 340 }
)

foreach ($node in $nodes) {
  $x = [float]$node.X
  if ($node.Dir -eq "up") {
    $graphics.DrawLine($nodePen, $x, 300, $x, $yAxis)
    $graphics.FillEllipse($nodeBrush, $x - 12, $yAxis - 12, 24, 24)
    Draw-Tag -Graphics $graphics -X ($x - 78) -Y 234 -Width 156 -Height 38 -Text $node.Date -Font $fontDate
    Draw-WrappedText -Graphics $graphics -Text $node.Text -Font $fontBody -Brush $bodyBrush -X ($x - 130) -Y 286 -Width $node.Wrap -LineHeight 31
  } else {
    $graphics.DrawLine($nodePen, $x, $yAxis, $x, 770)
    $graphics.FillEllipse($nodeBrush, $x - 12, $yAxis - 12, 24, 24)
    Draw-Tag -Graphics $graphics -X ($x - 78) -Y 782 -Width 156 -Height 38 -Text $node.Date -Font $fontDate
    Draw-WrappedText -Graphics $graphics -Text $node.Text -Font $fontBody -Brush $bodyBrush -X ($x - 170) -Y 620 -Width $node.Wrap -LineHeight 31
  }
}

$bitmap.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)

$fontBig.Dispose()
$fontYear.Dispose()
$fontHistory.Dispose()
$fontSmallRed.Dispose()
$fontDate.Dispose()
$fontBody.Dispose()
$whiteBrush.Dispose()
$strokeBrush.Dispose()
$redBrush.Dispose()
$bodyBrush.Dispose()
$centerBrush.Dispose()
$panelBrush.Dispose()
$outlinePen.Dispose()
$nodePen.Dispose()
$nodeBrush.Dispose()
$fmtCenter.Dispose()
$graphics.Dispose()
$bitmap.Dispose()
