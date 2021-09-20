; :Author: snxx
; :Copyright: GPL v3.0
;---------------------

!addincludedir "${objdir}\V"
!addincludedir "${srcdir}\V"
!include "version.nsh"
!include "arch.nsh"

!define PRODUCT_NAME "SoundCloud Desktop"
!define PRODUCT_SHORT_NAME "SC"
!define PACKAGE_NAME "${PRODUCT_NAME} ${VERSION}"
!define PACKAGE_SHORT_NAME "${PRODUCT_SHORT_NAME}-${VERSION}"

!if "${SC_PACKEDVERSION}" >= 0x3000000
	Unicode True
!endif

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "SoundCloud"
!include "SCMultiUser.nsh"

!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MULTIUSER_INSTALLMODEPAGE_INTERFACE



; The name of the installer
Name "${PACKAGE_NAME} Setup"
OutFile "soundcloud-setup.exe"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\"
;--------------------------------

; Request application privileges for Windows Vista
RequestExecutionLevel admin
;--------------------------

; Variables
Var StartMenuFolder
Var CmdFailed
;------------

; Interface Settings
Caption "${PACKAGE_SHORT_NAME}"
Icon "${srcdir}\nsis\setup.ico"
UninstallIcon "${srcdir}\nsis\unins000.ico"
;-------------------------------------------------

; The default installation directory
; Path: %LocalAppData%\Programs\SoundCloud
InstallDir "$APPDATA\Local\Programs\SoundCloud"
;-------------------------------------

; Pages
!insertmacro MUI_PAGE_DIRECTORY
Page directory
Page instfiles

UninstPage uninstConfirm
;-----------------------

!insertmacro MUI_LANGUAGE English

; The staff to install
Section "SC" SecVlang
	Sectionin
	SetOutPath "$APPDATA\Local\Programs\SoundCloud"
	File ""
	WriteRegStr HKLM ""
	
	WriteUninstaller "$\unins000.exe"
SectionEnd ; end the Staff section
;---------------------------------

Section "Manual" SecManual
	SetOutPath "$INSTDIR"
	File "${objdir}\docs\doc.chm"
	CreateShortCut "${}\$StartMenuFolder\man.lnk" "$INSTDIR\v${SC_PACKEDVERSION}.chm"
SectionEnd ; end the Manual section
;----------------------------------

; Uninstaller
Section "Uninstall"
	DeleteRegKey HKLM ""

	Delete "$APPDATA\Local\Programs\SoundCloud"
	Delete "$APPDATA\Local\Programs\SoundCloud"
	
	RMDir "$APPDATA\Local\Programs\SoundCloud"
	RMDir "$APPDATA\Local\Programs\SoundCloud"
SectionEnd ; end the Uninstall section
;-------------------------------------
