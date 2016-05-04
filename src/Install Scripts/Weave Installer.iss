;-- Weave_Installer.iss --
; Using a locally bundled Weave distribution ZIP file, once a Tomcat webapps folder is specified, the Weave files are deployed.
; @jtfallon

[Setup]
AppID = Weave2
AppName= Weave
AppVersion=2.0
DefaultDirName=" "
DefaultGroupName= Weave
Uninstallable = no
AppendDefaultDirName = no

[Languages]
Name: en; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel=Weave Visual Analytics, Inc.

[Files]
Source: "../weave.zip"; DestDir: "{app}"; AfterInstall: ExtractMe('{app}\weave.zip', '{app}');

[Code]

const
  SHCONTCH_NOPROGRESSBOX = 4;
  SHCONTCH_RESPONDYESTOALL = 16;

procedure Unzip(ZipFile, TargetFolder: String); 
var
  ShellObj, SrcFile, DestFolder: Variant;
begin
  ShellObj := CreateOleObject('Shell.Application');
  SrcFile := ShellObj.NameSpace(ZipFile);
  DestFolder := ShellObj.NameSpace(TargetFolder);
  DestFolder.CopyHere(SrcFile.Items, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL)
end;

procedure ExtractMe(src, target : String); 
begin
  // Add extra application code here, then:
  Unzip(ExpandConstant(src), ExpandConstant(target));
  DeleteFile(ExpandConstant(src));
end;