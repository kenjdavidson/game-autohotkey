#Requires AutoHotkey v2.0

; Relative movement locations for selecting spells.
; The numerical order is clockwise.
CAST_1 := { x: 0, y: -100 }
CAST_2 := { x: 100, y: 0 }
CAST_3 := { x: 40, y: 40 }
CAST_4 := { x: -40, y: 40 }
CAST_5 := { x: -100, y: 0 }

; E select the requested spell
SelectCastE(cast) {
    Send("{e down}")
    Sleep(50)
    MoveMouseRelative(cast.x, cast.y)
    Send("{e up}")
    Sleep(50)
    Send("{WheelDown}")
}

; Q select the requested spell
SelectCastQ(cast) {
    Send("{q down}")
    Sleep(50)
    MoveMouseRelative(cast.x, cast.y)
    Send("{q up}")
    Sleep(50)
    Send("{WheelDown}")
}

; Perform a jump crouch.  This function is a work in progress, it has some quicks
; in that it does the jump crouch, but there is some funkiness with the release
; of the crouch. The odd time the crouch gets locked.
; It's also possibel to get this into a bunny hop if you catch the space repeatedly.
Jumping := false
JumpCrouch() {
    global Jumping

    Send("{Space down}")
    Sleep(50)
    Send("{LControl down}")
    Sleep(450)
    Send("{LControl up}")
    Sleep(5)
    Send("{Space up}")
    Sleep(5)
    Jumping := false
}

; Move the mouse by the specified amount, relatively.  Used for casting wheel
; selection macros.
MoveMouseRelative(x, y, speed := 1) {
    MouseMove(x, y, speed, "R")
    Sleep(50)
}
