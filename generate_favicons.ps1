$ErrorActionPreference = 'Stop'

$src = Join-Path $PSScriptRoot 'icon.png'
if (-not (Test-Path $src)) {
    Write-Error "Source file not found: $src"
    exit 1
}

$sizes = @{
    'apple-touch-icon.png' = 180
    'favicon-32x32.png' = 32
    'favicon-16x16.png' = 16
}

Add-Type -AssemblyName System.Drawing

foreach ($name in $sizes.Keys) {
    $size = $sizes[$name]
    Write-Host "Generating $name (${size}x${size})..."
    $img = [System.Drawing.Image]::FromFile($src)
    $thumb = New-Object System.Drawing.Bitmap $size, $size
    $g = [System.Drawing.Graphics]::FromImage($thumb)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.DrawImage($img, 0, 0, $size, $size)
    $g.Dispose()

    $outPath = Join-Path $PSScriptRoot $name
    $thumb.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $thumb.Dispose()
    $img.Dispose()
}

Write-Host "All icons generated successfully." 
