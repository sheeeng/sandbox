' Credit: https://gist.github.com/eyecatchup/d577a2628666a0ad1375
' 
' VBS Script to get the Windows Product Key from registry.
'
' Save the VBScript somewhere on your Windows PC.
' An alertbox pops up displaying the product key stored in the 
' Windows registry when you run the local script.

Set WshShell = WScript.CreateObject("WScript.Shell")

KeyPath = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"
MsgBox ExtractKey(WshShell.RegRead(KeyPath))

Function ExtractKey(KeyInput)
	Const KeyOffset = 52
	i = 28
	CharWhitelist = "BCDFGHJKMPQRTVWXY2346789"
	Do
		Cur = 0
		x = 14
		Do
			Cur = Cur * 256
			Cur = KeyInput(x + KeyOffset) + Cur
			KeyInput(x + KeyOffset) = (Cur \ 24) And 255
			Cur = Cur Mod 24
			x = x -1
		Loop While x >= 0
		i = i -1
		KeyOutput = Mid(CharWhitelist, Cur + 1, 1) & KeyOutput
		If (((29 - i) Mod 6) = 0) And (i <> -1) Then
			i = i -1
			KeyOutput = "-" & KeyOutput
		End If
	Loop While i >= 0
	ExtractKey = KeyOutput
End Function
