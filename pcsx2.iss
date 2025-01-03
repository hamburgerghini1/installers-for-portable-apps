; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; Basic setup information
AppName=PCSX2
AppVersion=2.2.0
DefaultDirName={commonpf}\PCSX2
DefaultGroupName=PCSX2
OutputDir=.
OutputBaseFilename=PCSX2Setup
Compression=lzma
SolidCompression=yes
AppPublisher=Hamburgerghini1

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Add the files to be installed
Source: "C:\Users\tommi\Downloads\PCSX2\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Create a shortcut in the Start menu
Name: "{group}\PCSX2"; Filename: "{app}\pcsx2.exe"

[Run]
; Run the application after installation
Filename: "{app}\pcsx2.exe"; Description: "{cm:LaunchProgram, PCSX2}"; Flags: nowait postinstall skipifsilent