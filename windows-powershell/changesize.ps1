$host.UI.RawUI.BufferSize = new-object System.Management.Automation.Host.Size(175,20000)
$host.UI.RawUI.WindowSize = new-object System.Management.Automation.Host.Size(160,60)

Pause

(Get-Host).UI.RawUI
#$a = (Get-Host).UI.RawUI

$bufferSize=(Get-Host).ui.rawui.bufferSize
$bufferSize.Width=160 #Default: 120
$bufferSize.Height=3000 #Default: 3000
(Get-Host).ui.rawui.BufferSize=$BufferSize

$size = (Get-Host).UI.RawUI.WindowSize
$size.Width = 160 #Default: 120
$size.Height = 50 #Default: 50
(Get-Host).UI.RawUI.WindowSize = $size

Pause