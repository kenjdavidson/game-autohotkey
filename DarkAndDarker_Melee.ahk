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

; Perform a jump crouch with single button
; Needs a little bit of fine tuning in terms of sleep between clicks
$space:: JumpCrouch

WheelUp:: {
    JumpSwitchWeapon("WheelUp")
}

WheelDown:: {
    JumpSwitchWeapon("WheelDown")
}

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