; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; Basic setup information
AppName=Xpadder
AppVersion=5.7.0
DefaultDirName={commonpf}\Xpadder
DefaultGroupName=Xpadder
OutputDir=.
OutputBaseFilename=XpadderSetup
Compression=lzma
SolidCompression=yes
AppPublisher=Hamburgerghini1

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Add the files to be installed
Source: "C:\Users\tommi\Downloads\Xpadder*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Create a shortcut in the Start menu
Name: "{group}\Xpadder"; Filename: "{app}\Xpadder.exe"

[Run]
; Run the application after installation
Filename: "{app}\Xpadder.exe"; Description: "{cm:LaunchProgram, Xpadder}"; Flags: nowait postinstall skipifsilent