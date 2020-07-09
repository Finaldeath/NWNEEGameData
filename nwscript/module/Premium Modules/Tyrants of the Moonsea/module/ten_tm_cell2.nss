//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_cell2
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Open cell door after a short delay.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oDoor = OBJECT_INVALID;

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0) &&
        (GetLocalInt(oPC, "arena") == 4))
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);

        oDoor = GetObjectByTag("YourCellToArenaComplex1");
        DelayCommand(19.5, AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE)));
        DelayCommand(20.0, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));
    }
}
