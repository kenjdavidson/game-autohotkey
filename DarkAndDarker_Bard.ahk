#SingleInstance Force
#Requires AutoHotkey v2.0

; Load the HotVoice Library
#Include darkanddarker\Character.ahk
#Include darkanddarker\Merchant.ahk

; Dark and Darker Hotkeys
; Requires DungeonCrawler.exe active
#HotIf WinActive("ahk_exe DungeonCrawler.exe")

; This just presses a down/up key with a 50 millisecond pause.  This is needed as
; the game doesn't like sending a single click.
ShortKeyPress(key) {
    Send("{" key " down}")
    Sleep(50)
    Send("{" key " up}")
}

; This will play one of the bard songs from the Q selection wheel.  You can see below that
; you pass in the name of the song and the notes to play.
SelectAndPlayBardSongQ(song, notes) {
    Send("{q down}")
    Sleep(100)
    MoveMouseRelative(song.x, song.y)
    Send("{q up}")
    Sleep(100)
    ShortKeyPress("p")
    for sleepTime in notes {
        Sleep(sleepTime)
        ShortKeyPress("p")
    }
    Send("{f}")
}

; This is the same thing for the E song wheel.
SelectAndPlayBardSongE(song, notes) {
    Send("{e down}")
    Sleep(100)
    MoveMouseRelative(song.x, song.y)
    Send("{e up}")
    Sleep(100)
    ShortKeyPress("p")
    for sleepTime in notes {
        Sleep(sleepTime)
        ShortKeyPress("p")
    }
    Send("{f}")
}

; This defines the songs and their notes.  The song names are just set to the CAST 1 through 5,
; where 1 is the top moving clockwise around the options.   The notes are just a list of
; milliseconds to wait before clicking the note to play.   These can be adjusted to match
; what you're looking for.
SHRIEK_OF_WEAKNESS := CAST_2
SHRIEK_OF_WEAKNESS_NOTES := [1200, 600, 500]

ROUSING_RYTHM := CAST_1
ROUSING_RYTHM_NOTES := [600, 600, 600, 600]

BEATS_OF_ALACRITY := CAST_5
BEATS_OF_ALACRITY_NOTES := [1000, 500, 200, 200]

HARMONIC_SHEILD := CAST_2
HARMONIC_SHEILD_NOTES := [900, 900, 900, 900, 900, 900]

BALLAD_OF_COURAGE := CAST_3
BALLAD_OF_COURAGE_NOTES := [600, 600, 600, 600]

ARIA_OF_ALACRITY := CAST_4
ARIA_OF_ALACRITY_NOTES := [800, 900, 900, 900]

ALLEGRO := CAST_5
ALLEGRO_NOTES := [900, 900, 900, 500]

ACCELARENDO := CAST_1
ACCELARENDO_NOTES := [500, 500, 500, 500, 700]

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
; These quick casts are where you would define the key you want to press (1:: for example)
; and the songs that you want to play.  The songs are defined above.
; The current configuration is:
; 1 for Shriek of Weakness
; 0 for Rousing Rythm, Beats of Alacrity, Allegro, and Accelarendo
; 9 for Harmonic Sheild and Ballad of Courage
1:: {
    SelectAndPlayBardSongE(SHRIEK_OF_WEAKNESS, SHRIEK_OF_WEAKNESS_NOTES)
}
2:: {
    SelectAndPlayBardSongE(ACCELARENDO, ACCELARENDO_NOTES)
}
3:: {
    SelectAndPlayBardSongE(ALLEGRO, ALLEGRO_NOTES)
}
0:: {
    SelectAndPlayBardSongQ(ROUSING_RYTHM, ROUSING_RYTHM_NOTES)
    Sleep(50)
    SelectAndPlayBardSongQ(BEATS_OF_ALACRITY, BEATS_OF_ALACRITY_NOTES)
    Sleep(50)
    Click "X1"
    Sleep(50)
    SelectAndPlayBardSongQ(HARMONIC_SHEILD, HARMONIC_SHEILD_NOTES)
    Sleep(50)
    SelectAndPlayBardSongQ(BALLAD_OF_COURAGE, BALLAD_OF_COURAGE_NOTES)
    Sleep(50)
    Click "X1"
    Sleep(50)
    SelectAndPlayBardSongQ(ARIA_OF_ALACRITY, ARIA_OF_ALACRITY_NOTES)
    Sleep(50)
    Click "X1"
}
9:: {
    SelectAndPlayBardSongQ(ROUSING_RYTHM, ROUSING_RYTHM_NOTES)
    Sleep(50)
    SelectAndPlayBardSongQ(BEATS_OF_ALACRITY, BEATS_OF_ALACRITY_NOTES)
}
8:: {
    SelectAndPlayBardSongQ(HARMONIC_SHEILD, HARMONIC_SHEILD_NOTES)
    Sleep(50)
    SelectAndPlayBardSongQ(BALLAD_OF_COURAGE, BALLAD_OF_COURAGE_NOTES)
}
7:: {
    SelectAndPlayBardSongQ(ARIA_OF_ALACRITY, ARIA_OF_ALACRITY_NOTES)
}

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