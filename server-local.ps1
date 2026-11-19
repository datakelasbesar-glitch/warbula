$ErrorActionPreference = 'Stop'
$Root = [IO.Path]::GetFullPath($PSScriptRoot).TrimEnd('\')
$Listener = New-Object Net.Sockets.TcpListener([Net.IPAddress]::Loopback, 8000)
$MimeTypes = @{'.html'='text/html; charset=utf-8';'.js'='text/javascript; charset=utf-8';'.css'='text/css; charset=utf-8';'.png'='image/png';'.jpg'='image/jpeg';'.jpeg'='image/jpeg';'.svg'='image/svg+xml';'.ico'='image/x-icon';'.json'='application/json; charset=utf-8';'.md'='text/plain; charset=utf-8';'.txt'='text/plain; charset=utf-8';'.zip'='application/zip';'.mp4'='video/mp4';'.webp'='image/webp'}
try { $Listener.Start() } catch {
    Write-Host 'Port 8000 sedang dipakai. Tutup server WARBULA yang lama, lalu coba lagi.'
    exit 1
}
Write-Host ''
Write-Host 'WARBULA - KEBUDAYAAN NGAWI' -ForegroundColor Green
Write-Host 'Server aktif: http://127.0.0.1:8000'
Write-Host "Folder: $Root"
Write-Host 'Biarkan jendela ini terbuka. Ctrl+C untuk berhenti.'
Write-Host ''
try { Start-Process 'http://127.0.0.1:8000' } catch { Write-Host 'Buka alamat di atas pada browser.' }
try {
    while ($true) {
        $Client = $Listener.AcceptTcpClient()
        $Client.ReceiveTimeout = 4000
        $Client.SendTimeout = 10000
        try {
            $Stream = $Client.GetStream()
            $Reader = New-Object IO.StreamReader($Stream, [Text.Encoding]::ASCII, $false, 1024, $true)
            $RequestLine = $Reader.ReadLine()
            if (-not $RequestLine) { continue }
            $Parts = $RequestLine.Split(' ')
            if ($Parts.Length -lt 2) { continue }
            while ($true) { $HeaderLine=$Reader.ReadLine(); if ([string]::IsNullOrEmpty($HeaderLine)) { break } }
            $Status='200 OK'; $ContentType='text/plain; charset=utf-8'; $Data=[byte[]]@()
            $Method=$Parts[0]
            if ($Method -ne 'GET' -and $Method -ne 'HEAD') {
                $Status='405 Method Not Allowed'; $Data=[Text.Encoding]::UTF8.GetBytes('GET atau HEAD saja.')
            } else {
                try {
                    $RequestPath=[Uri]::UnescapeDataString(($Parts[1] -split '\?')[0])
                    if ($RequestPath -eq '/') { $RequestPath='/index.html' }
                    $FilePath=[IO.Path]::GetFullPath([IO.Path]::Combine($Root, $RequestPath.TrimStart('/').Replace('/', '\')))
                    $InsideRoot=$FilePath.StartsWith($Root+'\', [StringComparison]::OrdinalIgnoreCase)
                    if (-not $InsideRoot) {
                        $Status='403 Forbidden'; $Data=[Text.Encoding]::UTF8.GetBytes('Akses ditolak.')
                    } elseif (-not [IO.File]::Exists($FilePath)) {
                        $Status='404 Not Found'; $Data=[Text.Encoding]::UTF8.GetBytes('Berkas tidak ditemukan.')
                    } else {
                        $Data=[IO.File]::ReadAllBytes($FilePath)
                        $Extension=[IO.Path]::GetExtension($FilePath).ToLowerInvariant()
                        $ContentType=$MimeTypes[$Extension]
                        if (-not $ContentType) { $ContentType='application/octet-stream' }
                    }
                } catch { $Status='400 Bad Request'; $Data=[Text.Encoding]::UTF8.GetBytes('Permintaan tidak valid.') }
            }
            $Response="HTTP/1.1 $Status`r`nContent-Type: $ContentType`r`nContent-Length: $($Data.Length)`r`nConnection: close`r`nX-Content-Type-Options: nosniff`r`n`r`n"
            $Headers=[Text.Encoding]::ASCII.GetBytes($Response)
            $Stream.Write($Headers,0,$Headers.Length)
            if ($Method -ne 'HEAD' -and $Data.Length -gt 0) { $Stream.Write($Data,0,$Data.Length) }
            $Stream.Flush()
        } catch { } finally { $Client.Close() }
    }
} finally { $Listener.Stop() }
