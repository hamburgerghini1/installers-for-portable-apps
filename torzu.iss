; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; Basic setup information
AppName=Torzu
AppVersion=03.01.2025
DefaultDirName={commonpf}\Torzu
DefaultGroupName=Torzu
OutputDir=.
OutputBaseFilename=TorzuSetup
Compression=lzma2/ultra64
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Add the necessary files to be installed
Source: "C:\Users/tommi/Downloads/torzu\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Create a shortcut in the Start menu
Name: "{group}\Torzu"; Filename: "{app}\yuzu.exe"

[Run]
; Run the application after installation
Filename: "{app}\yuzu.exe"; Description: "{cm:LaunchProgram, Yuzu}"; Flags: nowait postinstall skipifsilent