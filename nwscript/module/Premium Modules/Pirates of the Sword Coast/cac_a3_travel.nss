//::///////////////////////////////////////////////
//:: cac_a3_travel
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The dragon takes the PC and his party to the
    secret entrance to the Umberlant Temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_generic"

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetPCSpeaker();
    object oTarg = GetObjectByTag("A3_JUMPTARG");
    object oCursor = OBJECT_INVALID;

    location lTarg = GetLocation(oTarg);

    UpdateSafePoint(oArea);

    // JE: JumpToLocation is not reliable
    JumpPCsToLocation(lTarg, 1, oPC);
/*
    oCursor = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        AssignCommand(oCursor, JumpToLocation(lTarg));
        oCursor = GetNextFactionMember(oPC, FALSE);
    }
*/
}
