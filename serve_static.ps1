$prefix = "http://localhost:8000/"
$root = $PSScriptRoot
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "Serving $root on $prefix"

while ($true) {
    $context = $listener.GetContext()
    Start-Job -ScriptBlock {
        param($ctx, $root)
        try {
            $req = $ctx.Request
            $res = $ctx.Response
            $urlPath = [System.Uri]::UnescapeDataString($req.Url.AbsolutePath.TrimStart('/'))
            if ([string]::IsNullOrEmpty($urlPath)) { $urlPath = 'index.html' }
            $file = Join-Path $root $urlPath
            if (-not (Test-Path $file)) {
                $res.StatusCode = 404
                $bytes = [System.Text.Encoding]::UTF8.GetBytes('Not Found')
                $res.OutputStream.Write($bytes, 0, $bytes.Length)
                $res.Close()
                return
            }
            $ext = [System.IO.Path]::GetExtension($file).ToLower()
            switch ($ext) {
                '.html' { $type = 'text/html' }
                '.css' { $type = 'text/css' }
                '.js' { $type = 'application/javascript' }
                '.png' { $type = 'image/png' }
                '.jpg' { $type = 'image/jpeg' }
                '.jpeg' { $type = 'image/jpeg' }
                '.svg' { $type = 'image/svg+xml' }
                '.ico' { $type = 'image/x-icon' }
                default { $type = 'application/octet-stream' }
            }
            $res.ContentType = $type
            $bytes = [System.IO.File]::ReadAllBytes($file)
            $res.ContentLength64 = $bytes.Length
            $res.OutputStream.Write($bytes, 0, $bytes.Length)
            $res.Close()
        } catch {
            try { $ctx.Response.StatusCode = 500; $ctx.Response.Close() } catch {}
        }
    } -ArgumentList $context, $root | Out-Null
}
