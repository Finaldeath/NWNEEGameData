// onEnter event for Daggerford Docks (AR0400)
// .. transforms the barracuda into the seacrest

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // run the standard PJ spawns
        SpawnEnter(oPC);

        // after hevesar's quests are done, the barracuda has left the dock
        // .. and is "replaced" by a different ship, the seacrest
        if (GetLocalInt(GetModule(), "hevesar_plot") >= 6)
        {
            if (GetLocalInt(OBJECT_SELF, "nHevesarQuest6") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nHevesarQuest6", 1);

                // remove the barracuda crew (they *must* be placed creatures not spawns)
                int i = 0;
                object oCrew = GetObjectByTag("pm_barracudacrew", i);
                while (GetIsObjectValid(oCrew))
                {
                    if (GetArea(oCrew) == OBJECT_SELF)
                    {
                        DestroyObject(oCrew);
                    }
                    oCrew = GetObjectByTag("pm_barracudacrew", ++i);
                }

                // lock the barracuda door
                object oDoor = GetObjectByTag("C1AR0500_C1AR0501_EXIT");
                AssignCommand(oDoor, ActionCloseDoor(oDoor));
                SetLocked(oDoor, TRUE);
                SetLockKeyTag(oDoor, "THIS_DOOR_WONT_OPEN");
            }
        }
    }
}

