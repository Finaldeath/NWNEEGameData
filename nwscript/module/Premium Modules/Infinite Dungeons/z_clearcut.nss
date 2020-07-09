// list the name and tag of every object in the area the first pc is in

#include "inc_id1_debug"

void main()
{
    PrintString("");

    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        if (GetCutsceneMode(oPC) == TRUE)
        {
            SetCutsceneMode(oPC, FALSE);
        }

        oPC = GetNextPC();
    }

    PrintString("");
}
