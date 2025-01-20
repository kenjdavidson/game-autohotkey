#SingleInstance Force
#Requires AutoHotkey v2.0

; Load the HotVoice Library
; #include Lib\HotVoice.ahk
#Include darkanddarker\DarkAndDarkerCommon.ahk

; Dark and Darker Hotkeys
; Requires DungeonCrawler.exe active
#HotIf WinActive("ahk_exe DungeonCrawler.exe")

; Perform a jump crouch with single button
; Needs a little bit of fine tuning in terms of sleep between clicks
$space:: JumpCrouch

; Purchase health pots and bandages
; Currently hardcoded to 3 of each
f12:: PurchasePotsAndBandages(WHITE_BANDAGE_3, 3, 3)

; Show configuration GUi
; TODO - save the results to a configuration file
^f12:: PotAndBandageConfigurationUI()