#Requires AutoHotkey v2.0

; Game Menu Locations
; TODO - update to be based on image search
MENU_ESC := { x: 80, y: 40 }
MENU_PLAY := { x: 225, y: 30 }
MENU_LEADERBOARD := { x: 325, y: 30 }
MENU_RELIGION := { x: 525, y: 30 }
MENU_STASH := { x: 725, y: 30 }
MENU_MERCHANT := { x: 1025, y: 30 }
MENU_TRADE := { x: 1225, y: 30 }
MENU_GATHERING := { x: 1350, y: 30 }
MENU_CUSTOMIZE := { x: 1520, y: 30 }
MENU_STORE := { x: 1680, y: 30 }

; Merchant Locations
; TODO - update this to be based on ImageSearch instead of hard coded
VENDOR_ALCHEMIST := { x: 380, y: 330 }
VENDOR_SQUIRE := { x: 600, y: 550 }
VENDOR_SURGEON := { x: 850, y: 600 }
VENDOR_LESS_BTN := { x: 910, y: 600 }
VENDOR_MORE_BTN := { x: 1010, y: 600 }
FILL_IN_ALL_STASH_BTN := { x: 960, y: 910 }
MAKE_DEAL_BTN := { x: 960, y: 980 }

; Vendor Item Locations
GREY_POT_3 := { x: 150, y: 290 }
WHITE_POT_3 := { x: 190, y: 290 }
GREY_BANDAGE_3 := { x: 150, y: 290 }
WHITE_BANDAGE_3 := { x: 190, y: 290 }

; Perform a jump/crouch with a single button
Jumping := false
JumpCrouch() {
    if Jumping == false {
        global Jumping
        Jumping := true
        Send("{Space down}")
        Sleep(50)
        Send("{LControl down}")
        Sleep(400)
        Send("{LControl up}")
        Send("{Space up}")
        Sleep(50)
        Jumping := false
    }
}

; SECTION: Purchase Pots

PotType := WHITE_POT_3
PotAmount := 3
BandageType := WHITE_BANDAGE_3
BandageAmount := 3

; Purchase pots and bandages of a particular type.  At this point the locations of grey/white
; pots/bandages are at the same location but in the future this may need to be updated to separate.
; @param the location of the type to be purchased.
; @param the number of pots to purchase
; @param the number of bandages to purchase
PurchasePotsAndBandages(type, potCount, bandageCount) {
    if potCount > 0 {
        PurchaseItems(VENDOR_ALCHEMIST, type, potCount)
        MoveToAndClick(MENU_ESC)
    }
    if bandageCount > 0 {
        PurchaseItems(VENDOR_SURGEON, type, bandageCount)
        MoveToAndClick(MENU_ESC)
    }

    if potCount > 0 or bandageCount > 0 {
        MoveToAndClick(MENU_PLAY)
    }
}

; Move to specified vendor and attempts to purchase items at the provided location.  Currently this
; performs count purchases; TODO - update to use the more button to increase count.
; @param vendor screen location
; @param item screen location
; @param count of the item to be purchased
PurchaseItems(vendor, item, count) {
    MoveToAndClick(MENU_MERCHANT)
    MoveToAndClick(vendor)
    MoveToAndClick(item)

    loop count {
        MoveToAndClick(FILL_IN_ALL_STASH_BTN)
        MoveToAndClick(MAKE_DEAL_BTN)
    }
}

; Performs a move and click operation.
; @param position which will be clicked
; @param type of click to perform, defaults to left
; @param amount of time to sleep after the button click
MoveToAndClick(position, click := "left", sleepTime := 250) {
    MouseMove(position.x, position.y)
    MouseClick()
    Sleep(sleepTime)
}

; Show GUI configuration for Pots and Bandages
PotSelections := ["Grey 3", "White 3"]
PotSelectionsValues := [GREY_POT_3, WHITE_POT_3]
BandageSelections := ["Grey 3", "White 3"]
BandageSelectionsValues := [GREY_BANDAGE_3, WHITE_BANDAGE_3]
PotAndBandageConfigurationUI() {
    ConfigurationGui := Gui()
    ConfigurationGui.Title := "Pots and Bandages"
    ConfigurationGui.AddText("", "Pot Type")
    CurrentPotIndex := "Choose" GetValueIndex(PotSelectionsValues, PotType)
    PotsSelectionInput := ConfigurationGui.AddComboBox(CurrentPotIndex "w100", PotSelections)
    ConfigurationGui.AddText("", "Pot Amount ")
    PotAmountInput := ConfigurationGui.AddEdit("w100")
    PotAmountInput.Value := PotAmount

    ConfigurationGui.AddText("", "Bandage Type")
    CurrentBandageIndex := "Choose" GetValueIndex(BandageSelectionsValues, BandageType)
    BandageSelectionInput := ConfigurationGui.AddComboBox(CurrentBandageIndex "w100", BandageSelections)
    ConfigurationGui.AddText("", "Bandage Amount ")
    BandageAmountInput := ConfigurationGui.AddEdit("Number w100")
    BandageAmountInput.Value := BandageAmount

    SaveButton := ConfigurationGui.AddButton("", "Save")
    SaveButton.OnEvent("Click", (*) => (
        OnChangePotAndBandage(PotsSelectionInput, PotAmountInput, BandageSelectionInput, BandageAmountInput)
        ConfigurationGui.Destroy()
    ))
    CancelButton := ConfigurationGui.AddButton("", "Cancel")
    CancelButton.OnEvent("Click", (*) => ConfigurationGui.Destroy())

    ConfigurationGui.Show()
}

OnChangePotAndBandage(NewPotType, NewPotAmount, NewBandageType, NewBandageAmount) {
    global PotType, PotAmount, BandageType, BandageAmount

    PotType := PotSelectionsValues[NewPotType.Value]
    PotAmount := NewPotAmount.Value
    BandageType := BandageSelectionsValues[NewPotType.Value]
    BandageAmount := NewBandageAmount.Value
}

GetValueIndex(ToSearch, SearchFor) {
    if !(IsObject(ToSearch))
        return 1

    for index, value in ToSearch
        if (value == SearchFor)
            return index

    return 1
}
