//::///////////////////////////////////////////////
//:: exe_a3_jumpiod
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the player from the IoD Intro cutscene
    to the Island of the Dead Area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

void main()
{
    object oCursor = OBJECT_INVALID;
    object oTarget = GetObjectByTag("A3_SPAWN_PCENTER");

    // cycle through the players and move them.
    oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        //JE: JumpToObject is not reliable.
        //AssignCommand(oCursor, JumpToObject(oTarget));
        JumpPCsToLocation(GetLocation(oTarget), 0, oCursor);

        ForceRest(oCursor);

        oCursor = GetNextPC();
    }
}
