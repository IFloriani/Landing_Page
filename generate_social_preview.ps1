$svg = "$PSScriptRoot\social-preview.svg"
$png = "$PSScriptRoot\social-preview.png"

Write-Host "Converting SVG to PNG..."

# Try ImageMagick (magick)
if (Get-Command magick -ErrorAction SilentlyContinue) {
    Write-Host "Using ImageMagick (magick)"
    & magick $svg -resize 1200x630^> $png
    if (Test-Path $png) { Write-Host "Created $png"; exit 0 } else { Write-Host "Conversion failed with ImageMagick."; exit 2 }
}

# Try Inkscape
if (Get-Command inkscape -ErrorAction SilentlyContinue) {
    Write-Host "Using Inkscape"
    & inkscape $svg --export-type=png --export-filename=$png --export-width=1200 --export-height=630
    if (Test-Path $png) { Write-Host "Created $png"; exit 0 } else { Write-Host "Conversion failed with Inkscape."; exit 3 }
}

Write-Host "No supported converter found. Please install ImageMagick (https://imagemagick.org) or Inkscape (https://inkscape.org)."
Write-Host "After installation, run this script from the project root in PowerShell:`n    .\generate_social_preview.ps1"
exit 1
