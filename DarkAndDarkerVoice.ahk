#SingleInstance Force
#Requires AutoHotkey v2.0

; Load the HotVoice Library
#include Lib\HotVoice2.ahk
#Include Lib\DarkAndDarkerCommon.ahk

; Dark and Darker Hotkeys
; Requires DungeonCrawler.exe active
#HotIf WinActive("ahk_exe DungeonCrawler.exe")