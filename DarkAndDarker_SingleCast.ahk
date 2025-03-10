#SingleInstance Force
#Requires AutoHotkey v2.0

; Load the HotVoice Library
#Include darkanddarker\Character.ahk
#Include darkanddarker\Merchant.ahk

; Dark and Darker Hotkeys
; Requires DungeonCrawler.exe active
#HotIf WinActive("ahk_exe DungeonCrawler.exe")

; F1 is used to toggle the Jump and Purchase hotkeys
; This does not toggle the CTRL-Hotkey used for configurations
f1:: {
    Hotkey("$space", "Toggle")
    Hotkey("f12", "Toggle")
}

; Toggle the 1 through 5 hotkeys.
f2:: {
    Hotkey("1", "Toggle")
    Hotkey("2", "Toggle")
    Hotkey("3", "Toggle")
    Hotkey("4", "Toggle")
    Hotkey("5", "Toggle")
}

; Casting quick selection
; Instead of having to press E then move mouse
; keys 1 through 5 will perform both the E and mouse move
1:: SelectCastE(CAST_1)
2:: SelectCastE(CAST_2)
3:: SelectCastE(CAST_3)
4:: SelectCastE(CAST_4)
5:: SelectCastE(CAST_5)

; Perform a jump crouch with single button
; Needs a little bit of fine tuning in terms of sleep between clicks
$space:: JumpCrouch

; Purchase health pots and bandages
; Currently hardcoded to 3 of each
f12:: {
    PurchaseItems(VENDOR_ALCHEMIST, PotType, PotAmount)
    MoveToAndClick(MENU_ESC)
    PurchaseItems(VENDOR_SURGEON, BandageType, BandageAmount)
    MoveToAndClick(MENU_ESC)
}

; Show configuration GUi
; TODO - save the results to a configuration file
^f12:: PotAndBandageConfigurationUI()