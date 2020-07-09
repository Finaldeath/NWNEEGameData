//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_celldoor1
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: When the player has spoken to all 3 cellmates,
//       the cell door is unlocked and opened.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"


void main()
{
    object oPC = GetEnteringObject();
    object oDoor = GetObjectByTag("YourCellToArenaComplex1");

    if (GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        if (PlotLevelCheckEquals(NPC_TAG_GARTH, 1) &&
            PlotLevelCheckEquals(NPC_TAG_ELF, 1) &&
            PlotLevelCheckEquals(NPC_TAG_BLIZZARD, 1))
        {
            SetLocalInt(OBJECT_SELF, "fired", 1);

            SetLocked(oDoor, FALSE);
            DelayCommand(1.0, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));
            FloatingTextStringOnCreature("The cell door shoots up and somebody calls your name from the other side.", oPC);
        }
    }
}
