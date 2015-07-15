# Copied from https://gallery.technet.microsoft.com/scriptcenter/Backup-Windows-product-key-b41468c2 page.

#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

#Main function
Function GetWin8Key
{
	$Hklm = 2147483650
	$Target = $env:COMPUTERNAME
	$regPath = "Software\Microsoft\Windows NT\CurrentVersion"
	$DigitalID = "DigitalProductId"
	$wmi = [WMIClass]"\\$Target\root\default:stdRegProv"
	#Get registry value 
	$Object = $wmi.GetBinaryValue($hklm,$regPath,$DigitalID)
	[Array]$DigitalIDvalue = $Object.uValue 
	#If get successed
	If($DigitalIDvalue)
	{
		#Get producnt name and product ID
		$ProductName = (Get-itemproperty -Path "HKLM:Software\Microsoft\Windows NT\CurrentVersion" -Name "ProductName").ProductName 
		$ProductID =  (Get-itemproperty -Path "HKLM:Software\Microsoft\Windows NT\CurrentVersion" -Name "ProductId").ProductId
		#Convert binary value to serial number 
		$Result = ConvertTokey $DigitalIDvalue
		$OSInfo = (Get-WmiObject "Win32_OperatingSystem"  | select Caption).Caption
		#if result is not null
		If($OSInfo -match "Microsoft Windows 8")
		{
			if($Result)
			{
				
				[string]$value ="ProductName  : $ProductName `r`n" `
				+ "ProductID    : $ProductID `r`n" `
				+ "Installed Key: $Result"
				$value 
				#Save Windows info to a file 
				$Choice = GetChoice
				If( $Choice -eq 0 )
				{	
					$txtpath = "C:\Users\"+$env:USERNAME+"\Desktop"
					New-Item -Path $txtpath -Name "WindowsKeyInfo.txt" -Value $value   -ItemType File  -Force | Out-Null 
				}
				Elseif($Choice -eq 1)
				{
					Exit 
				}
			}
			Else
			{
				Write-Warning "Please run this script on Windows 8."
			}
		}
		Else
		{
			Write-Warning "Please run this script on Windows 8."
		}
		
	}
	Else
	{
		Write-Warning "Failed to get Windows 8 product key,Some error occured."
	}

}
#Get user choice 
Function GetChoice
{
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",""
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",""
    $choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes,$no)
    $caption = "Confirming"
    $message = "Save product key to a file?"
    $result = $Host.UI.PromptForChoice($caption,$message,$choices,0)
    $result
}
#Convert binary to serial number 
Function ConvertToKey($Key)
{
	$Keyoffset = 52 
	$isWin8 = [int]($Key[66]/6) -band 1
	$HF7 = 0xF7
	$Key[66] = ($Key[66] -band $HF7) -bOr (($isWin8 -band 2) * 4)
	$i = 24
	[String]$Chars = "BCDFGHJKMPQRTVWXY2346789"	
	do
	{
		$Cur = 0 
		$X = 14
		Do
		{
			$Cur = $Cur * 256    
			$Cur = $Key[$X + $Keyoffset] + $Cur
			$Key[$X + $Keyoffset] = [math]::Floor([double]($Cur/24))
			$Cur = $Cur % 24
			$X = $X - 1 
		}while($X -ge 0)
		$i = $i- 1
		$KeyOutput = $Chars.SubString($Cur,1) + $KeyOutput
		$last = $Cur
	}while($i -ge 0)
	
	$Keypart1 = $KeyOutput.SubString(1,$last)
	$Keypart2 = $KeyOutput.Substring(1,$KeyOutput.length-1)
	if($last -eq 0 )
	{
		$KeyOutput = "N" + $Keypart2
	}
	else
	{
		$KeyOutput = $Keypart2.Insert($Keypart2.IndexOf($Keypart1)+$Keypart1.length,"N")
	}
	$a = $KeyOutput.Substring(0,5)
	$b = $KeyOutput.substring(5,5)
	$c = $KeyOutput.substring(10,5)
	$d = $KeyOutput.substring(15,5)
	$e = $KeyOutput.substring(20,5)
	$keyproduct = $a + "-" + $b + "-"+ $c + "-"+ $d + "-"+ $e
	$keyproduct 
	
  
}
GetWin8Key