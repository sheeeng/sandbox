#msgoodies: PowerShell, write-verbose word wraps
#http://msgoodies.blogspot.no/2007/02/powershell-write-verbose-word-wraps.html

function Set-RegistryValue($Key,$Name,$Value,$type=[Microsoft.win32.registryvaluekind]::DWord) {
 $parent=split-path $key -parent
 $parent=get-item $parent
 $key=get-item $key
 $keyh=$parent.opensubkey($key.name.split("\")[-1],$true)
 $keyh.setvalue($name,$value,$type)
 $keyh.close()
}

function Set-OutputBuffer($width=10000) {
 $key=""
 if ($host.ui.rawui.WindowTitle -eq "taskeng.exe") {
  $key="hkcu:\console\taskeng.exe"
 }
 elseif ($host.ui.rawui.WindowTitle -eq "$($env:windir)\system32\svchost.exe" ) {
  $key="hkcu:\console\%SystemRoot%_system32_svchost.exe"
 }
 # other titles are ignored
 if ($key) {
  $taskeng=$key
  if (!(test-path $taskeng)) {md $taskeng -verbose}
  set-RegistryValue $taskeng FontSize 0x00050000
  set-RegistryValue $taskeng ScreenBufferSize 0x02000200
  set-RegistryValue $taskeng WindowSize 0x00200200
  set-RegistryValue $taskeng FontFamily 0x00000036
  set-RegistryValue $taskeng FontWeight 0x00000190
  set-ItemProperty $taskeng FaceName "Lucida Console"

  $bufferSize=$host.ui.rawui.bufferSize
  $bufferSize.width=$width
  $host.ui.rawui.BufferSize=$BufferSize
  $maxSize=$host.ui.rawui.MaxWindowSize
  $windowSize=$host.ui.rawui.WindowSize
  $windowSize.width=$maxSize.width
  $host.ui.rawui.WindowSize=$windowSize
 }

}

$verbosepreference="continue"
Set-OutputBuffer

# test code

$host.ui.rawui
Write-Verbose"$(get-date)"
Write-Verbose $($s="";for($i=1;$i -lt 10;$i+=1) {$s+=([string] $i * 9) + " "};$s*5)