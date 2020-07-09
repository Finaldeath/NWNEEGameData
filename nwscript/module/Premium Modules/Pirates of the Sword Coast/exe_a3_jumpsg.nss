//::///////////////////////////////////////////////
//:: exe_a3_jumpsg
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the player from the seige intro to their
    room on the midnight rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

void main()
{
    object oCursor = OBJECT_INVALID;
    object oTarget = GetObjectByTag("A3_SEIGESTART1");

    // cycle through the players and move them.
    oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        // JE: JumpToObject is not reliable
        //AssignCommand(oCursor, JumpToObject(oTarget));
        JumpPCsToLocation(GetLocation(oTarget), 0, oCursor);
        ForceRest(oCursor);

        oCursor = GetNextPC();
    }
}
