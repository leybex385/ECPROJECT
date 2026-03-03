@echo off
set PORT=8000
echo Starting Zero-Install Server on http://localhost:%PORT%
echo Press Ctrl+C to stop.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l=[System.Net.HttpListener]::new();$l.Prefixes.Add('http://localhost:%PORT%/');$l.Start();while($l.IsListening){$c=$l.GetContext();$r=$c.Request;$s=$c.Response;$p=Join-Path $pwd.Path $r.Url.LocalPath.TrimStart('/');if(Test-Path $p -PathType Leaf){$ext=[System.IO.Path]::GetExtension($p).ToLower();if($ext -eq '.html'){$s.ContentType='text/html'}elseif($ext -eq '.js'){$s.ContentType='application/javascript'}elseif($ext -eq '.css'){$s.ContentType='text/css'}elseif($ext -eq '.png'){$s.ContentType='image/png'}elseif($ext -eq '.jpg' -or $ext -eq '.jpeg'){$s.ContentType='image/jpeg'}elseif($ext -eq '.svg'){$s.ContentType='image/svg+xml'}elseif($ext -eq '.ico'){$s.ContentType='image/x-icon'};$b=[System.IO.File]::ReadAllBytes($p);$s.OutputStream.Write($b,0,$b.Length)}else{$s.StatusCode=404};$s.Close()}"
